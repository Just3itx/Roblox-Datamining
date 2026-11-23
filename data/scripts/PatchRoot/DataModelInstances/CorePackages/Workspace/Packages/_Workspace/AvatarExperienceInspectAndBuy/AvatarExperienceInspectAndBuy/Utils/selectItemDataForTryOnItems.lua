-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T16:40:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceInspectAndBuy = script:FindFirstAncestor("AvatarExperienceInspectAndBuy")
local AvatarExperienceInspectAndBuyParent = AvatarExperienceInspectAndBuy.Parent
local _Types = require(AvatarExperienceInspectAndBuy.Types)
local _AvatarExperienceRodux = require(AvatarExperienceInspectAndBuyParent.AvatarExperienceRodux)
local buildItemDataFromAXRodux = require(AvatarExperienceInspectAndBuy.Utils.buildItemDataFromAXRodux)

local function selectItemDataForTryOnItems(arg1, arg2)
    local result = {}
    if not (arg1 and arg2) then
        return result
    end

    for _, value in arg2 do
        local itemData = buildItemDataFromAXRodux(arg1, value.itemId, value.itemType)
        if not itemData then
            continue
        end

        table.insert(
            result,
            {
                itemData = itemData,
                isEquipped = value.selectedInTryOnManager == true,
                ordering = value.itemRecency or 0
            }
        )
    end
    table.sort(result, function(arg3, arg4): boolean
        if arg3.ordering ~= arg4.ordering then
            return arg3.ordering < arg4.ordering
        elseif arg3.itemData.id ~= arg4.itemData.id then
            return tostring(arg3.itemData.id) < tostring(arg4.itemData.id)
        end
        return tostring(arg3.itemData.itemType) < tostring(arg4.itemData.itemType)
    end)

    return result
end

return selectItemDataForTryOnItems
