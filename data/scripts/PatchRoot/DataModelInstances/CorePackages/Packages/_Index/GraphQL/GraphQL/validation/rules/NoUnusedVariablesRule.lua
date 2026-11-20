-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T08:20:32Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local GraphQLError = require(scriptParentParentParent.error.GraphQLError).GraphQLError

local module = {}

function module.NoUnusedVariablesRule(arg1)
    local tbl1 = {}

    return {
        OperationDefinition = {
            enter = function()
                tbl1 = {}
            end,
            leave = function(_, arg2)
                local tbl2 = {}
                local recursiveVariableUsages = arg1:getRecursiveVariableUsages(arg2)

                for _, value in ipairs(recursiveVariableUsages) do
                    tbl2[value.node.name.value] = true
                end

                for _, value in ipairs(tbl1) do
                    local value2 = value.variable.name.value
                    if tbl2[value2] ~= true then
                        arg1:reportError(
                            GraphQLError.new(
                                arg2.name and ("Variable \"$%s\" is never used in operation \"%s\"."):format(value2, arg2.name.value)
                                    or ("Variable \"$%s\" is never used."):format(value2),
                                value
                            )
                        )
                    end
                end
            end
        },
        VariableDefinition = function(_, arg2)
            table.insert(tbl1, arg2)
        end
    }
end

return module
