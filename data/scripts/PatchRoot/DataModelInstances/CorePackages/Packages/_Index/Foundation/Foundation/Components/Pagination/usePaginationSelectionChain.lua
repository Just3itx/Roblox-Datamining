-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T08:31:25Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local React = require(FoundationParent.React)
local useRefCache = require(FoundationParent.ReactUtils).useRefCache

local _Types = require(Foundation.Components.Types)

local function usePaginationSelectionChain(tbl1, arg1, callback: ((...any) -> (...any))?)
    local var1 = useRefCache()
    local firstSlotId = tbl1[1]

    local getSlotRef = React.useCallback(function(str1: string)
        local var3 = var1[str1]
        return if firstSlotId == str1 and callback ~= nil then function(current)
            var3.current = current
            callback(current)
        end else var3
    end, { firstSlotId, callback, var1 })

    local getSlotBindings = React.useCallback(function(str1: string)
        local var4 = table.find(tbl1, str1)
        if var4 == nil then
            return {
                ref = var1[str1],
                Selectable = false
            }
        end

        return {
            ref = var1[str1],
            Selectable = true,
            NextSelectionLeft = if var4 > 1 then var1[tbl1[var4 - 1]] else nil,
            NextSelectionRight = if var4 < #tbl1 then var1[tbl1[var4 + 1]] else nil,
            NextSelectionUp = arg1 and arg1.NextSelectionUp,
            NextSelectionDown = arg1 and arg1.NextSelectionDown
        }
    end, { tbl1, var1, arg1 })

    return React.useMemo(function()
        return {
            firstSlotId = firstSlotId,
            getSlotBindings = getSlotBindings,
            getSlotRef = getSlotRef
        }
    end, { firstSlotId, getSlotBindings, getSlotRef })
end

return usePaginationSelectionChain
