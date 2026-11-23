-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T13:40:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCommon = script:FindFirstAncestor("AvatarExperienceCommon")
local Constants = require(AvatarExperienceCommon.Constants)

local function selectDefaultTryOnBodyColors(arg1)
    local outfitTryOn = arg1.AvatarExperience.AvatarScene.OutfitTryOn
    local outfitInfos = arg1.AvatarExperience.AvatarEditor.OutfitInfos
    local outfitIdMap = outfitTryOn.OutfitIdMap
    for _, tryOnItem in outfitTryOn.TryOnItems do
        if outfitIdMap
            and tryOnItem.itemType == "Bundle"
            and tryOnItem.itemSubType == Constants.BODY_BUNDLE_TYPE_ID
            and tryOnItem.receivedBundleInfo
        then
            local var1 = outfitIdMap[tryOnItem.itemId]
            local outfitInfo = if var1 then outfitInfos[var1] else nil
            return if outfitInfo then outfitInfo.bodyColor3s else nil
        end
    end
    return nil
end

return selectDefaultTryOnBodyColors
