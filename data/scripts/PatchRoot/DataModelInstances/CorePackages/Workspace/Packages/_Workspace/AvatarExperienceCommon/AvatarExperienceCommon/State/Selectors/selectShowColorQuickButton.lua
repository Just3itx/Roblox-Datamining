-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T13:40:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local selectTryOnBodyIds = require(script.Parent.selectTryOnBodyIds)

local function selectShowColorQuickButton(arg1)
    local var1 = selectTryOnBodyIds(arg1)

    local lastToggledItem = arg1.AvatarExperience.AvatarScene.OutfitTryOn.LastToggledItem

    for _, value in var1 do
        local bundleInfo = arg1.AvatarExperience.Common.BundleInfos[value]

        if bundleInfo and bundleInfo.isRecolorable and lastToggledItem and lastToggledItem.itemId == value then
            return true
        end
    end
    return false
end

return selectShowColorQuickButton
