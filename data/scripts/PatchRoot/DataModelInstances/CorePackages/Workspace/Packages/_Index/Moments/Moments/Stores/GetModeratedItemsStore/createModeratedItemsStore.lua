-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T05:30:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsParent = script:FindFirstAncestor("Moments").Parent

local Signals = require(MomentsParent.Signals)
local Cryo = require(MomentsParent.Cryo)

local createSignal = Signals.createSignal
local createComputed = Signals.createComputed

local function createModeratedItemsStore()
    local getItems, var2 = createSignal({})
    local tbl1 = ({})

    return {
        getItems = getItems,
        getIsModerated = function(str1: string)
            if tbl1[str1] == nil then
                tbl1[str1] = createComputed(function(arg1): boolean
                    return table.find(getItems(arg1), str1) ~= nil
                end)
            end
            return tbl1[str1]
        end,
        markReported = function(str1: string)
            local var3 = getItems(false)
            if not table.find(var3, str1) then
                var2((Cryo.List.join(var3, { str1 })))
            end
        end,
        addModeratedItems = function(tbl2)
            local var3 = getItems(false)
            local tbl3 = {}
            for _, value in tbl2 do
                if not table.find(var3, value) then
                    table.insert(tbl3, value)
                end
            end
            if #tbl3 > 0 then
                var2((Cryo.List.join(var3, tbl3)))
            end
        end
    }
end

return createModeratedItemsStore
