-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T08:20:37Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local jsutils = scriptParentParentParent.jsutils
local scriptParentParentParentParent = scriptParentParentParent.Parent
local LuauPolyfill = require(scriptParentParentParentParent.LuauPolyfill)
local Array = LuauPolyfill.Array
local Object = LuauPolyfill.Object

local inspect = require(jsutils.inspect).inspect
local keyMap = require(jsutils.keyMap).keyMap
local GraphQLError = require(scriptParentParentParent.error.GraphQLError).GraphQLError
local language = scriptParentParentParent.language
local Kind = require(language.kinds).Kind
local print = require(language.printer).print
local definition = require(scriptParentParentParent.type.definition)
local isType = definition.isType
local isRequiredArgument = definition.isRequiredArgument
local specifiedDirectives = require(scriptParentParentParent.type.directives).specifiedDirectives

local module = {}

function module.ProvidedRequiredArgumentsRule(arg1)
    return Object.assign({}, module.ProvidedRequiredArgumentsOnDirectivesRule(arg1), {
        Field = {
            leave = function(_, arg2)
                local fieldDef = arg1:getFieldDef()
                if not fieldDef then
                    return false
                end

                local var1 = arg2.arguments or {}
                local var2 = keyMap(var1, function(arg3)
                    return arg3.name.value
                end)
                for _, arg in ipairs(fieldDef.args) do
                    if not var2[arg.name] and isRequiredArgument(arg) then
                        local var3 = inspect(arg.type)
                        arg1:reportError(
                            GraphQLError.new(
                                ("Field \"%s\" argument \"%s\" of type \"%s\" is required, but it was not provided."):format(
                                    fieldDef.name,
                                    arg.name,
                                    var3
                                ),
                                arg2
                            )
                        )
                    end
                end
            end
        }
    })
end

function module.ProvidedRequiredArgumentsOnDirectivesRule(arg1)
    local tbl1 = {}

    local schema = arg1:getSchema()
    local var1 = specifiedDirectives
    if schema then
        var1 = schema:getDirectives()
    end
    for _, value in ipairs(var1) do
        tbl1[value.name] = keyMap(Array.filter(value.args, isRequiredArgument), function(arg2)
            return arg2.name
        end)
    end

    local definitions = arg1:getDocument().definitions
    for _, definition2 in ipairs(definitions) do
        if definition2.kind ~= Kind.DIRECTIVE_DEFINITION then
            continue
        end
        local var2 = definition2.arguments or {}

        tbl1[definition2.name.value] = keyMap(Array.filter(var2, isRequiredArgumentNode), function(arg2)
            return arg2.name.value
        end)
    end

    return {
        Directive = {
            leave = function(_, arg2)
                local value = arg2.name.value
                local var2 = tbl1[value]

                if not var2 then
                    return
                end
                local var3 = arg2.arguments or {}
                local var4 = keyMap(var3, function(arg3)
                    return arg3.name.value
                end)
                for _, value2 in ipairs(Object.keys(var2)) do
                    if not var4[value2] then
                        local type = var2[value2].type
                        local var5 = isType(type) and inspect(type) or print(type)

                        arg1:reportError(
                            GraphQLError.new(
                                ("Directive \"@%s\" argument \"%s\" of type \"%s\" is required, but it was not provided."):format(value, value2, var5),
                                arg2
                            )
                        )
                    end
                end
            end
        }
    }
end

function isRequiredArgumentNode(arg1): boolean
    return arg1.type.kind == Kind.NON_NULL_TYPE and arg1.defaultValue == nil
end

return module
