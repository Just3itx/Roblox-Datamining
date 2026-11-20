-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T08:11:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local GraphQLError = require(scriptParentParentParent.error.GraphQLError).GraphQLError
local language = scriptParentParentParent.language
local print = require(language.printer).print
local isCompositeType = require(scriptParentParentParent.type.definition).isCompositeType
local typeFromAST = require(scriptParentParentParent.utilities.typeFromAST).typeFromAST

local module = {}

function module.FragmentsOnCompositeTypesRule(arg1)
    return {
        InlineFragment = function(_, arg2)
            local typeCondition = arg2.typeCondition
            if not typeCondition then
                return
            end

            local var1 = typeFromAST(arg1:getSchema(), typeCondition)
            if var1 and not isCompositeType(var1) then
                local var2 = print(typeCondition)
                arg1:reportError(
                    GraphQLError.new(("Fragment cannot condition on non composite type \"%s\"."):format(var2), typeCondition)
                )
            end
        end,
        FragmentDefinition = function(_, arg2)
            local var1 = typeFromAST(arg1:getSchema(), arg2.typeCondition)
            if var1 and not isCompositeType(var1) then
                local var2 = print(arg2.typeCondition)
                arg1:reportError(
                    GraphQLError.new(
                        ("Fragment \"%s\" cannot condition on non composite type \"%s\"."):format(arg2.name.value, var2),
                        arg2.typeCondition
                    )
                )
            end
        end
    }
end

return module
