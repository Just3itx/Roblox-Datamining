-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T08:11:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local GraphQLError = require(scriptParentParentParent.error.GraphQLError).GraphQLError

local module = {}

function module.NoUndefinedVariablesRule(arg1)
    local tbl1 = {}

    return {
        OperationDefinition = {
            enter = function()
                tbl1 = {}
            end,
            leave = function(_, arg2)
                local recursiveVariableUsages = arg1:getRecursiveVariableUsages(arg2)

                for _, value in ipairs(recursiveVariableUsages) do
                    local node = value.node
                    local value2 = node.name.value
                    if tbl1[value2] ~= true then
                        arg1:reportError(
                            GraphQLError.new(
                                arg2.name and ("Variable \"$%s\" is not defined by operation \"%s\"."):format(value2, arg2.name.value)
                                    or ("Variable \"$%s\" is not defined."):format(value2),
                                { node, arg2 }
                            )
                        )
                    end
                end
            end
        },
        VariableDefinition = function(_, arg2)
            tbl1[arg2.variable.name.value] = true
        end
    }
end

return module
