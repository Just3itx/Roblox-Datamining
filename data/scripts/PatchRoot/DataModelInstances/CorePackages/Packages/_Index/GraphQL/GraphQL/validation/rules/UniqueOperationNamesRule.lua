-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T08:20:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local GraphQLError = require(scriptParentParentParent.error.GraphQLError).GraphQLError

local module = {}

function module.UniqueOperationNamesRule(arg1)
    local tbl1 = {}
    return {
        OperationDefinition = function(_, arg2): boolean
            local name = arg2.name
            if name then
                if tbl1[name.value] then
                    arg1:reportError(
                        GraphQLError.new(("There can be only one operation named \"%s\"."):format(name.value), { tbl1[name.value], name })
                    )
                else
                    tbl1[name.value] = name
                end
            end
            return false
        end,
        FragmentDefinition = function(): boolean
            return false
        end
    }
end

return module
