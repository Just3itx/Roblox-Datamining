-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T08:11:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent
local Array = require(scriptParentParentParentParent.LuauPolyfill).Array

local GraphQLError = require(scriptParentParentParent.error.GraphQLError).GraphQLError

local module = {}

function module.NoFragmentCyclesRule(arg1)
    local tbl1 = ({})

    local tbl2 = {}

    local tbl3 = ({})

    local function detectCycleRecursive(arg2)
        if tbl1[arg2.name.value] then
            return
        end

        local value = arg2.name.value
        tbl1[value] = true

        local fragmentSpreads = arg1:getFragmentSpreads(arg2.selectionSet)

        if #fragmentSpreads == 0 then
            return
        end

        tbl3[value] = #tbl2

        for _, fragmentSpread in ipairs(fragmentSpreads) do
            local value2 = fragmentSpread.name.value
            local var1 = tbl3[value2]

            table.insert(tbl2, fragmentSpread)

            if var1 == nil then
                local fragment = arg1:getFragment(value2)
                if fragment then
                    detectCycleRecursive(fragment)
                end
            else
                local var2 = Array.slice(tbl2, var1 + 1)
                local str1 = table.concat(Array.map(Array.slice(var2, 1, #var2), function(arg3)
                    return "\"" .. arg3.name.value .. "\""
                end), ", ")

                arg1:reportError(
                    GraphQLError.new(
                        ("Cannot spread fragment \"%s\" within itself"):format(value2) .. (if str1 == "" then "." else (" via %s."):format(str1) or "."),
                        var2
                    )
                )
            end

            table.remove(tbl2)
        end

        tbl3[value] = nil
    end

    return {
        OperationDefinition = function(): boolean
            return false
        end,
        FragmentDefinition = function(_, arg2): boolean
            detectCycleRecursive(arg2)
            return false
        end
    }
end

return module
