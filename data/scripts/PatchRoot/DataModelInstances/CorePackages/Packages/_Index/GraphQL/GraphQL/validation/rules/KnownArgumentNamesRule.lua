-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T08:11:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent
local LuauPolyfill = require(scriptParentParentParentParent.LuauPolyfill)
local Array = LuauPolyfill.Array
local Object = LuauPolyfill.Object

local GraphQLError = require(scriptParentParentParent.error.GraphQLError).GraphQLError
local language = scriptParentParentParent.language
local jsutils = scriptParentParentParent.jsutils
local didYouMean = require(jsutils.didYouMean).didYouMean
local suggestionList = require(jsutils.suggestionList).suggestionList
local Kind = require(language.kinds).Kind
local specifiedDirectives = require(scriptParentParentParent.type.directives).specifiedDirectives

local module = {}

function module.KnownArgumentNamesRule(arg1)
    return Object.assign({}, module.KnownArgumentNamesOnDirectivesRule(arg1), {
        Argument = function(_, arg2)
            local argument = arg1:getArgument()
            local fieldDef = arg1:getFieldDef()
            local parentType = arg1:getParentType()

            if argument or not fieldDef or not parentType then
                return
            end

            local value = arg2.name.value
            local var1 = Array.map(fieldDef.args, function(arg3)
                return arg3.name
            end)
            local var2 = suggestionList(value, var1)
            arg1:reportError(
                GraphQLError.new(
                    ("Unknown argument \"%s\" on field \"%s.%s\"."):format(value, parentType.name, fieldDef.name) .. didYouMean(var2),
                    arg2
                )
            )
        end
    })
end

function module.KnownArgumentNamesOnDirectivesRule(arg1)
    local tbl1 = {}

    local schema = arg1:getSchema()
    local var1 = specifiedDirectives
    if schema then
        var1 = schema:getDirectives()
    end
    for _, value in ipairs(var1) do
        tbl1[value.name] = Array.map(value.args, function(arg2)
            return arg2.name
        end)
    end

    local definitions = arg1:getDocument().definitions
    for _, definition in ipairs(definitions) do
        if definition.kind ~= Kind.DIRECTIVE_DEFINITION then
            continue
        end
        local var2 = definition.arguments or {}

        tbl1[definition.name.value] = Array.map(var2, function(arg2)
            return arg2.name.value
        end)
    end

    return {
        Directive = function(_, arg2): boolean
            local value = arg2.name.value
            local var2 = tbl1[value]

            if arg2.arguments and var2 then
                for _, argument in ipairs(arg2.arguments) do
                    local value2 = argument.name.value
                    if Array.indexOf(var2, value2) == -1 then
                        local var3 = suggestionList(value2, var2)
                        arg1:reportError(
                            GraphQLError.new(("Unknown argument \"%s\" on directive \"@%s\"."):format(value2, value) .. didYouMean(var3), argument)
                        )
                    end
                end
            end

            return false
        end
    }
end

return module
