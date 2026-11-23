-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T13:40:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCommon = script:FindFirstAncestor("AvatarExperienceCommon")

local isMakeupAssetType = require(AvatarExperienceCommon.Utils.isMakeupAssetType)
local selectTryOnItems = require(script.Parent.selectTryOnItems)
local selectEquippedLayeredMakeupAssets = require(script.Parent.selectEquippedLayeredMakeupAssets)

local function selectTotalLayeredMakeupAssets(arg1): number
    local num1 = #selectEquippedLayeredMakeupAssets(arg1)

    local num2 = 0
    for _, value in selectTryOnItems(arg1) do
        if value.selectedInTryOnManager and value.itemType and isMakeupAssetType(value.itemSubType) then
            num2 += 1
        end
    end

    return num1 + num2
end

return selectTotalLayeredMakeupAssets
