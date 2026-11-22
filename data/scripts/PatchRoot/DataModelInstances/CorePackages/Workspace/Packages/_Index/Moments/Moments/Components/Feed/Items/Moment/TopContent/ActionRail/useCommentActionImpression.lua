-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:20:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Moments = script:FindFirstAncestor("Moments")
local MomentsParent = Moments.Parent

local React = require(MomentsParent.React)
local Signals = require(MomentsParent.Signals)
local SignalsReact = require(MomentsParent.SignalsReact)
local MomentsCommon = require(MomentsParent.MomentsCommon)
local SharedFlags = require(MomentsParent.SharedFlags)
local MomentsGetMomentsCommentsStore = require(MomentsParent.DataHydration.MomentsGetMomentsCommentsStore)
local FFlagMomentsComments = SharedFlags.FFlagMomentsComments
local FFlagMomentsCommentsIxpEnabled = SharedFlags.FFlagMomentsCommentsIxpEnabled

local useVerticalPager = require(Moments.Components.VerticalPager).useVerticalPager
local usePagerItem = require(Moments.Components.VerticalPager).usePagerItem
local useFeedOptional = require(Moments.Components.Feed.FeedContext).useFeedOptional
local FStringMomentsCommentsIxpLayer = require(Moments.Flags.FStringMomentsCommentsIxpLayer)
local FFlagMomentsCommentsCountAnalytics = require(Moments.Flags.FFlagMomentsCommentsCountAnalytics)
local makeCommentCountFields = require(Moments.Analytics.makeCommentCountFields)
local MomentImpressionMemory = require(Moments.Components.Feed.Items.Moment.MomentImpressionMemory)
local FFlagMomentsFixOverlayRemountImpressions = require(Moments.Flags.FFlagMomentsFixOverlayRemountImpressions)

local function useCommentActionImpression(bool1: boolean)
    local var1 = useVerticalPager()
    local var2 = usePagerItem()
    local var3 = useFeedOptional()
    local item = var2.item

    local var4 = React.useMemo(function()
        return Signals.createComputed(function(arg1): boolean
            return not (item == nil) and var1.store.getCurrentItem(arg1) == item
        end)
    end, { var1, item })
    local var5 = SignalsReact.useSignalState(var4)
    if bool1 then
        if var5 then
            if var3 == nil then
                var5 = false
            else
                var5 = var3.isActiveFeed
            end
        end
    else
        var5 = bool1
    end

    local var6 = if FFlagMomentsFixOverlayRemountImpressions then MomentImpressionMemory.useImpressionRef("commentAction") else React.useRef(false)

    React.useEffect(function()
        local current = var6.current
        var6.current = var5
        if not var5 or current or item == nil or item.kind ~= "moment" then
            return
        end

        local recommendationMetadata = item.moment.recommendationMetadata
        local feedItemId = if recommendationMetadata == nil then nil else recommendationMetadata.feedItemId

        if FFlagMomentsComments and feedItemId ~= nil and feedItemId ~= "" then
            local var7 = not FFlagMomentsCommentsCountAnalytics and {}
                or makeCommentCountFields(MomentsGetMomentsCommentsStore(false).getCachedMomentComments(feedItemId).data(false))

            var7.feedItemId = feedItemId
            MomentsCommon.Analytics.fireAnalyticsEvent(MomentsCommon.Analytics.EventNames.MomentCommentActionButtonImpression, var7)
        end

        if FFlagMomentsCommentsIxpEnabled then
            MomentsCommon.Utils.logMomentsLayerExposure(FStringMomentsCommentsIxpLayer)
        end
    end, { var5, item })
end

return useCommentActionImpression
