-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T08:20:30Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local GraphQLError = require(scriptParentParentParent.error.GraphQLError).GraphQLError

local module = {}

function module.NoUnusedFragmentsRule(arg1)
    local tbl1 = {}
    local tbl2 = {}

    return {
        OperationDefinition = function(_, arg2): boolean
            table.insert(tbl1, arg2)
            return false
        end,
        FragmentDefinition = function(_, arg2): boolean
            table.insert(tbl2, arg2)
            return false
        end,
        Document = {
            leave = function()
                local tbl3 = {}
                for _, value in ipairs(tbl1) do
                    for _, value2 in ipairs(arg1:getRecursivelyReferencedFragments(value)) do
                        tbl3[value2.name.value] = true
                    end
                end

                for _, value in ipairs(tbl2) do
                    local value2 = value.name.value
                    if tbl3[value2] ~= true then
                        arg1:reportError(GraphQLError.new(("Fragment \"%s\" is never used."):format(value2), value))
                    end
                end
            end
        }
    }
end

return module
