-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:10:42Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Moments = script:FindFirstAncestor("Moments")
local MomentsParent = Moments.Parent

local React = require(MomentsParent.React)

local _FeedTypes = require(Moments.Components.Feed.FeedTypes)
local MomentItem = require(script.MomentItem)
local MomentItemSkeleton = require(script.MomentItemSkeleton)

local _createMomentStore = require(script.createMomentStore)

local MomentsCommon = require(MomentsParent.MomentsCommon)
local MomentsTypes = require(MomentsParent.MomentsTypes)
local SharedFlags = require(MomentsParent.SharedFlags)
local FFlagMomentsServeEDPVideos = SharedFlags.FFlagMomentsServeEDPVideos
local FFlagMomentsOptimisticProfilePending = SharedFlags.FFlagMomentsOptimisticProfilePending
local FFlagMomentsHideOfficialContentLabel = SharedFlags.FFlagMomentsHideOfficialContentLabel
local FStringMomentsOfficialContentCreatorId = require(Moments.Flags.FStringMomentsOfficialContentCreatorId)

local GetMomentsPreferencesStore = require(Moments.Stores.GetMomentsPreferencesStore)
local GetFFlagMomentsRenderPostAssets = require(MomentsParent.MomentsCommon.GetFFlagMomentsRenderPostAssets)
local FFlagMomentsAvatarLookTryOn = SharedFlags.FFlagMomentsAvatarLookTryOn
local makeRecommendationAttribution = require(Moments.Analytics.makeRecommendationAttribution)
local FFlagMomentsRecommendationContentType = require(Moments.Flags.FFlagMomentsRecommendationContentType)
local toMediaItem = require(Moments.Components.Feed.Media.toMediaItem)
local Comments = require(Moments.Components.Comments)

local MomentMediaView = MomentsCommon.Media.MomentMediaView

local var1 = tonumber(FStringMomentsOfficialContentCreatorId)

local function momentAttribution(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    if arg1 == nil then
        return nil
    end
    local var2 = makeRecommendationAttribution
    local recommendationMetadata = arg1.recommendationMetadata
    if not FFlagMomentsRecommendationContentType then
        arg1 = nil
    end

    return var2(recommendationMetadata, arg1)
end

local function createMediaSurface(moment)
    local var2 = toMediaItem({ kind = "moment", moment = moment })

    if var2 == nil then
        return nil
    end

    return React.createElement(MomentMediaView, {
        momentId = var2.momentId,
        posterContent = var2.posterContent,
        showLoadingSkeleton = var2.captureType == Enum.CaptureType.Video,
        suppressTapToToggle = true,
        getScaleType = GetMomentsPreferencesStore(false).getMediaScaleType
    })
end

return {
    {
        kind = "moment",
        getKey = function(arg1)
            local moment = arg1.moment
            local recommendationMetadata = moment.recommendationMetadata
            return if recommendationMetadata and recommendationMetadata.feedItemId and recommendationMetadata.feedItemId ~= "" then recommendationMetadata.feedItemId else moment.momentId
        end,
        getAttribution = function(arg1)
            return momentAttribution(arg1.moment)
        end,
        render = function(arg1, _: number)
            local moment = arg1.moment

            if moment == nil then
                return nil
            end

            local element = nil
            if not GetFFlagMomentsRenderPostAssets() then
                local var2 = toMediaItem(arg1)
                if var2 ~= nil then
                    element = React.createElement(MomentMediaView, {
                        momentId = var2.momentId,
                        posterContent = var2.posterContent,
                        showLoadingSkeleton = var2.captureType == Enum.CaptureType.Video,
                        suppressTapToToggle = true,
                        getScaleType = GetMomentsPreferencesStore(false).getMediaScaleType
                    })
                end
            end

            local recommendationMetadata = moment.recommendationMetadata
            local var2 = momentAttribution(moment)
            local isSponsored = moment.metadata.partnerUploadType == "influencer"
            local tbl1 = {
                kind = "experience",
                momentId = moment.momentId,
                creatorId = moment.creatorId,
                placeId = moment.metadata.placeId or 0,
                universeId = moment.metadata.universeId or 0,
                outfitId = if FFlagMomentsAvatarLookTryOn then moment.metadata.outfitId else nil,
                isSponsored = isSponsored,
                isOfficialContent = if FFlagMomentsHideOfficialContentLabel then not (var1 == nil) and moment.creatorId == var1 else nil,
                description = moment.metadata.description,
                isModerated = moment.isModerated == true,
                isPending = FFlagMomentsOptimisticProfilePending and moment.status == MomentsTypes.Enums.MomentStatus.Pending,
                commentCount = if SharedFlags.FFlagMomentsComments then Comments.getSeededCommentCount(moment.comments) else nil,
                feedItemId = if recommendationMetadata == nil then nil else recommendationMetadata.feedItemId,
                feedSessionId = if recommendationMetadata == nil then nil else recommendationMetadata.tracingId,
                contentType = if FFlagMomentsRecommendationContentType and var2 ~= nil then var2.contentType else nil
            }

            local content = React.createElement(MomentItem, {
                data = tbl1,
                mediaSurface = element,
                renderMediaSurface = if GetFFlagMomentsRenderPostAssets() then createMediaSurface else nil,
                moment = moment
            })

            if not FFlagMomentsServeEDPVideos or moment.entityType ~= "edpVideo" then
                return content
            end

            local edpVideoEligibilityContainer = require(script.EdpVideoEligibility.EdpVideoEligibilityContainer)
            return React.createElement(edpVideoEligibilityContainer, {
                momentId = moment.momentId,
                universeId = moment.metadata.universeId,
                content = content,
                loadingContent = React.createElement(MomentItemSkeleton)
            })
        end
    },
    {
        kind = "skeleton",
        getKey = function(_): string
            return "__feed_skeleton__"
        end,
        getAttribution = function(_)
            return nil
        end,
        render = function(_, _: number)
            return React.createElement(MomentItemSkeleton)
        end
    }
}
