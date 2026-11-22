-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T05:21:35Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Moments = script:FindFirstAncestor("Moments")
local MomentsParent = Moments.Parent

local React = require(MomentsParent.React)
local Localization = require(MomentsParent.Localization)
local _MomentsTypes = require(MomentsParent.MomentsTypes)

local FeedContext = require(Moments.Components.Feed.FeedContext)
local SignalActionType = require(Moments.Enums.SignalActionType)
local MomentContext = require(Moments.Components.Feed.Items.Moment.MomentContext)
local makeRecommendationAttribution = require(Moments.Analytics.makeRecommendationAttribution)
local FFlagMomentsRecommendationContentType = require(Moments.Flags.FFlagMomentsRecommendationContentType)

local shareMoment = require(script.Parent.shareMoment)

local useLocalization = Localization.Hooks.useLocalization

local tbl1 = {
    shareLinkTitle = "Feature.Moments.Label.ShareLinkTitle",
    linkCopied = "Feature.Moments.Label.LinkCopied",
    linkCopyFailed = "Feature.Moments.Label.LinkCopyFailed"
}

local function useShareMoment(arg1)
    local var1 = MomentContext.useMoment()
    local momentId = var1.momentId
    local var2 = React.useContext(FeedContext.FeedContext)

    local var3 = useLocalization(tbl1)

    local useCallback = React.useCallback
    local function func1()
        local recommendationAttribution = makeRecommendationAttribution(
            if arg1 then arg1.recommendationMetadata else nil,
            nil,
            if FFlagMomentsRecommendationContentType then var1.store.getData(false).contentType else nil
        )

        local var4 = nil
        if recommendationAttribution then
            var4 = var2 and function(tbl2)
                return var2.logAction(SignalActionType.Share, recommendationAttribution, tbl2)
            end or var4
        end

        shareMoment({
            momentId = momentId,
            feedItemId = if arg1 and arg1.recommendationMetadata then arg1.recommendationMetadata.feedItemId else nil,
            feedSessionId = if arg1 and arg1.recommendationMetadata then arg1.recommendationMetadata.tracingId else nil,
            description = if arg1 and arg1.metadata then arg1.metadata.description else nil,
            logAction = var4,
            strings = {
                linkPreviewTitle = var3.shareLinkTitle,
                linkCopied = var3.linkCopied,
                linkCopyFailed = var3.linkCopyFailed
            }
        })
    end

    local store = if FFlagMomentsRecommendationContentType then var1.store else false
    return {
        onShareActivated = useCallback(func1, { momentId, arg1, var2, var3, store })
    }
end

return useShareMoment
