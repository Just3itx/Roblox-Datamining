-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T08:20:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local GraphQLError = require(scriptParentParentParent.error.GraphQLError).GraphQLError
local language = scriptParentParentParent.language
local Kind = require(language.kinds).Kind
local predicates = require(language.predicates)
local isTypeDefinitionNode = predicates.isTypeDefinitionNode
local isTypeExtensionNode = predicates.isTypeExtensionNode
local specifiedDirectives = require(scriptParentParentParent.type.directives).specifiedDirectives

local module = {}

function module.UniqueDirectivesPerLocationRule(arg1)
    local tbl1 = {}

    local schema = arg1:getSchema()
    local var1 = if schema then schema:getDirectives() else specifiedDirectives

    for _, value in ipairs(var1) do
        tbl1[value.name] = not value.isRepeatable
    end

    local definitions = arg1:getDocument().definitions
    for _, definition in ipairs(definitions) do
        if definition.kind == Kind.DIRECTIVE_DEFINITION then
            tbl1[definition.name.value] = not definition.repeatable
        end
    end

    local tbl2 = {}
    local tbl3 = ({})

    return {
        enter = function(_, arg2)
            if arg2.directives == nil then
                return
            end

            local tbl4

            if arg2.kind == Kind.SCHEMA_DEFINITION or arg2.kind == Kind.SCHEMA_EXTENSION then
                tbl4 = tbl2
            elseif isTypeDefinitionNode(arg2) or isTypeExtensionNode(arg2) then
                local value = arg2.name.value
                tbl4 = tbl3[value]
                if tbl4 == nil then
                    tbl4 = {}
                    tbl3[value] = tbl4
                end
            else
                tbl4 = {}
            end

            for _, value in ipairs(arg2.directives) do
                local value2 = value.name.value

                if not tbl1[value2] then
                    continue
                end

                if tbl4[value2] then
                    arg1:reportError(
                        GraphQLError.new(
                            ("The directive \"@%s\" can only be used once at this location."):format(value2),
                            { tbl4[value2], value }
                        )
                    )
                else
                    tbl4[value2] = value
                end
            end
        end
    }
end

return module
