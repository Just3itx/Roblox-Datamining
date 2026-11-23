-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T13:10:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCommon = script:FindFirstAncestor("AvatarExperienceCommon")

local FFlagAXOutfitSaveSkipUnownedTryOnBackground = require(AvatarExperienceCommon.Parent.AvatarExperienceFlags).FFlagAXOutfitSaveSkipUnownedTryOnBackground

local selectActiveBackground = require(script.Parent.selectActiveBackground)
local selectTryOnBackgroundId = require(script.Parent.selectTryOnBackgroundId)
local NO_BACKGROUND_ASSET_ID = require(script.Parent.constants).NO_BACKGROUND_ASSET_ID

local function isAssetOwned(arg1, num1: number): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    local var1 = arg1 and (arg1.AvatarExperience or arg1)
    local assetInfos = var1 and var1.Common and var1.Common.AssetInfos
    local assetInfo = assetInfos and assetInfos[tostring(num1)]
    return not (assetInfo == nil) and assetInfo.isOwned == true
end

local function buildOutfitProfileConfiguration(arg1)
    local var1 = selectActiveBackground(arg1)

    if FFlagAXOutfitSaveSkipUnownedTryOnBackground
        and var1 ~= nil
        and var1 == selectTryOnBackgroundId(arg1)
        and not isAssetOwned(arg1, var1)
    then
        var1 = selectActiveBackground(arg1, { ignoreTryOn = true })
    end
    local tbl1 = { BackgroundAssetId = 0 }
    if var1 == nil then
        var1 = NO_BACKGROUND_ASSET_ID
    end

    tbl1.BackgroundAssetId = var1
    return tbl1
end

return buildOutfitProfileConfiguration
