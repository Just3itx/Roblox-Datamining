-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T08:20:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local GraphQLError = require(scriptParentParentParent.error.GraphQLError).GraphQLError

local module = {}

function module.UniqueVariableNamesRule(arg1)
    local tbl1 = ({})
    return {
        OperationDefinition = function()
            tbl1 = {}
        end,
        VariableDefinition = function(_, arg2)
            local value = arg2.variable.name.value
            if not tbl1[value] then
                tbl1[value] = arg2.variable.name

                return
            end

            arg1:reportError(
                GraphQLError.new(("There can be only one variable named \"$%s\"."):format(value), { tbl1[value], arg2.variable.name })
            )
        end
    }
end

return module
