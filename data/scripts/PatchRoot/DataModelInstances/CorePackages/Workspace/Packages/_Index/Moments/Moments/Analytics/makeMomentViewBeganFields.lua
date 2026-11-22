-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T03:41:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Moments = script:FindFirstAncestor("Moments")
local MomentsParent = Moments.Parent

local MomentsCommon = require(MomentsParent.MomentsCommon)
local _MomentsTypes = require(MomentsParent.MomentsTypes)
local MomentsGetPostAssetStore = require(MomentsParent.DataHydration.MomentsGetPostAssetStore)
local GetFFlagMomentsRenderPostAssets = require(MomentsParent.MomentsCommon.GetFFlagMomentsRenderPostAssets)
local FFlagMomentsAvatarLookTryOn = require(MomentsParent.SharedFlags).FFlagMomentsAvatarLookTryOn
local FFlagMomentsImpressionPrimaryEntity = require(Moments.Flags.FFlagMomentsImpressionPrimaryEntity)
local deriveMomentFromPost = require(Moments.Utils.deriveMomentFromPost)

local tbl1 = {
    [Enum.CaptureType.Video] = 1,
    [Enum.CaptureType.Screenshot] = 2
}

local function resolveTryOnOutfitId(arg1, bool1: boolean)
    if not (FFlagMomentsAvatarLookTryOn and bool1) then
        return 0
    end
    if arg1.metadata.outfitId ~= nil then
        return arg1.metadata.outfitId
    end

    local postAssetId = if arg1.postAsset == nil then nil else arg1.postAsset.postAssetId

    if not GetFFlagMomentsRenderPostAssets() or postAssetId == nil or postAssetId <= 0 then
        return 0
    end
    local var1 = MomentsGetPostAssetStore(false).getCachedPostAsset(postAssetId).data(false)
    if var1 == nil then
        return nil
    end
    local var2 = deriveMomentFromPost(arg1, var1)

    if var2 == nil then
        return 0
    end

    return var2.metadata.outfitId or 0
end

local function makeMomentViewBeganFields(arg1, str1: string, viewId: string?, bool1: boolean?): {feedItemId: any, feedSessionId: any, momentId: any, source: string, viewMode: string}?
    local recommendationMetadata = arg1.recommendationMetadata
    local feedItemId = recommendationMetadata.feedItemId
    if feedItemId == nil or feedItemId == "" then
        MomentsCommon.Analytics.reportMomentSkip("impression", if feedItemId == nil then "nil" else "empty", { entry = str1 })
        return nil
    end
    local tbl2 = {
        momentId = arg1.momentId,
        feedItemId = feedItemId,
        feedSessionId = recommendationMetadata.tracingId or "",
        viewMode = "vertical",
        source = str1
    }
    local universeId = arg1.metadata.universeId
    if universeId ~= nil and universeId > 0 then
        tbl2.destinationUniverseId = tostring(universeId)
    end
    if FFlagMomentsImpressionPrimaryEntity then
        local var1 = resolveTryOnOutfitId(arg1, bool1 == true)
        if var1 ~= nil and var1 > 0 then
            tbl2.primaryEntityType = tostring(3)
            tbl2.primaryCtaEntityId = tostring(var1)
        elseif var1 ~= nil then
            local var2 = tbl1[arg1.metadata.captureType]
            if var2 ~= nil then
                tbl2.primaryEntityType = tostring(var2)
            end

            if universeId ~= nil and universeId > 0 then
                tbl2.primaryCtaEntityId = tostring(universeId)
            end
        end
    end
    if viewId ~= nil then
        tbl2.viewId = viewId
    end
    return tbl2
end

return makeMomentViewBeganFields
