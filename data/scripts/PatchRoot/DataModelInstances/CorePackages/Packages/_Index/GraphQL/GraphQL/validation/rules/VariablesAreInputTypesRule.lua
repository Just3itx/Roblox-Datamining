-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T08:20:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local GraphQLError = require(scriptParentParentParent.error.GraphQLError).GraphQLError
local print = require(scriptParentParentParent.language.printer).print
local isInputType = require(scriptParentParentParent.type.definition).isInputType
local typeFromAST = require(scriptParentParentParent.utilities.typeFromAST).typeFromAST

local module = {}

function module.VariablesAreInputTypesRule(arg1)
    return {
        VariableDefinition = function(_, arg2)
            local var1 = typeFromAST(arg1:getSchema(), arg2.type)

            if var1 and not isInputType(var1) then
                local value = arg2.variable.name.value
                local var2 = print(arg2.type)

                arg1:reportError(GraphQLError.new(("Variable \"$%s\" cannot be non-input type \"%s\"."):format(value, var2), arg2.type))
            end
        end
    }
end

return module
