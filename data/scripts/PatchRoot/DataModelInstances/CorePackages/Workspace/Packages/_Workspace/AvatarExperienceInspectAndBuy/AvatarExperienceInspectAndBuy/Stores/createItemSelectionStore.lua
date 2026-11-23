-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T16:31:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceInspectAndBuyParent = script:FindFirstAncestor("AvatarExperienceInspectAndBuy").Parent
local Signals = require(AvatarExperienceInspectAndBuyParent.Signals)
local _AXCommon = require(AvatarExperienceInspectAndBuyParent.AXCommon)

local function createItemSelectionStore()
    local getItemDataMap, var2 = Signals.createSignal({})

    local tbl1 = ({})

    return {
        getItemDataMap = getItemDataMap,
        getItemData = function(str1: string)
            if tbl1[str1] == nil then
                tbl1[str1] = Signals.createComputed(function(arg1)
                    return getItemDataMap(arg1)[str1]
                end)
            end
            return tbl1[str1]
        end,
        setItemData = function(str1: string, tbl2)
            local var3 = table.clone(getItemDataMap(false))
            var3[str1] = tbl2
            var2(var3)
        end,
        clearItemData = function(str1: string)
            local var3 = table.clone(getItemDataMap(false))
            var3[str1] = nil
            var2(var3)
        end,
        clearAll = function()
            var2({})
        end
    }
end
return createItemSelectionStore
