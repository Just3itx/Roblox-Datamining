-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:51:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")

local Moments = script:FindFirstAncestor("Moments")
local MomentsParent = Moments.Parent

local React = require(MomentsParent.React)
local GameLaunch = require(MomentsParent.GameLaunch)
local Localization = require(MomentsParent.Localization)
local MomentsCommon = require(MomentsParent.MomentsCommon)

local LaunchGame = GameLaunch.LaunchGame
local useLocalization = Localization.Hooks.useLocalization

local Analytics = MomentsCommon.Analytics
local EventNames = Analytics.EventNames
local fireAnalyticsEvent = Analytics.fireAnalyticsEvent

local Constants = require(Moments.Constants)
local Constants2 = require(Moments.ExperienceDetailsSheet.Constants)
local _Types = require(Moments.ExperienceDetailsSheet.Types)
local emitRecommendationAction = require(Moments.Analytics.emitRecommendationAction)
local MomentsFeedType = require(Moments.Enums.MomentsFeedType)
local useMomentsSession = require(Moments.Stores.GetMomentsStore.MomentsSessionContext).useMomentsSession
local GetMomentsPreferencesStore = require(Moments.Stores.GetMomentsPreferencesStore)
local sessionUtil = require(Moments.Analytics.sessionUtil)
local GetToastStore = require(Moments.Stores.GetToastStore)
local listenForTeleportFailure = require(script.Parent.listenForTeleportFailure)
local FFlagMomentsPlayEvent = require(Moments.Flags.FFlagMomentsPlayEvent)
local FFlagMomentsRecommendationFeedType = require(Moments.Flags.FFlagMomentsRecommendationFeedType)

local tbl1 = {
    joining = Constants2.LocalizationKeys.joining
}

local function getFeedType(recommendationSource: string?) -- Luacid: Inlined by compiler; 1 call site recovered
    if recommendationSource == Analytics.RecommendationSource.Following then
        return MomentsFeedType.Following
    end

    if recommendationSource == Analytics.RecommendationSource.Trending then
        return MomentsFeedType.Trending
    end

    return nil
end

local function useJoinExperience()
    local var1 = useLocalization(tbl1)
    local var2 = useMomentsSession()

    local var3 = React.useRef(nil)

    React.useEffect(function()
        return function()
            if var3.current ~= nil then
                var3.current()
                var3.current = nil
            end
        end
    end, {})

    return React.useCallback(function(arg1, num1: number?, viewId: string?)
        local momentsPreferencesStore = GetMomentsPreferencesStore(false)

        if var3.current ~= nil then
            var3.current()
            var3.current = nil
        end

        momentsPreferencesStore.setTeleporting(true)

        local destinationPlaceId = num1 or arg1.placeId
        local momentsSessionId = var2.getMomentsSessionId(false)
        local feedItemId = arg1.feedItemId or ""
        local tracingId = arg1.tracingId or ""

        if arg1.feedItemId ~= nil and arg1.feedItemId ~= "" then
            fireAnalyticsEvent(EventNames.FeedExperienceJoinAttempted, {
                feedItemId = arg1.feedItemId,
                feedSessionId = tracingId,
                placeId = tostring(arg1.placeId),
                universeId = tostring(arg1.universeId),
                destinationPlaceId = tostring(destinationPlaceId)
            })
        else
            local str1 = if arg1.feedItemId == nil then "nil" else "empty"
            Analytics.reportMomentSkip("feed_action", str1, { action = "join" })
        end

        local var5

        if not FFlagMomentsRecommendationFeedType and arg1.recommendationSource == Analytics.RecommendationSource.Following then
            var5 = HttpService:GenerateGUID(false)
        else
            var5 = emitRecommendationAction({
                itemId = feedItemId,
                tracingId = tracingId,
                momentsSessionId = momentsSessionId,
                actionType = Constants.RecommendationActionType.Play,
                destinationPlaceId = destinationPlaceId,
                contentType = arg1.contentType,
                feedType = if FFlagMomentsRecommendationFeedType then getFeedType(arg1.recommendationSource) else nil
            })
        end

        GetToastStore(false).triggerToast({ title = var1.joining, text = "" })

        if var5 then
            sessionUtil.setPlayIntent(var5)
        end

        if FFlagMomentsPlayEvent and var5 ~= nil and arg1.feedItemId ~= nil and arg1.feedItemId ~= "" then
            local makeMomentsPlayFields = require(Moments.Analytics.makeMomentsPlayFields)
            fireAnalyticsEvent(
                EventNames.MomentsPlayEvent,
                makeMomentsPlayFields({
                    feedItemId = arg1.feedItemId,
                    momentsPlayIntentId = var5,
                    viewId = viewId,
                    clientEventTimestampMs = DateTime.now().UnixTimestampMillis
                })
            )
        end

        var3.current = listenForTeleportFailure(function()
            var3.current = nil
            momentsPreferencesStore.setTeleporting(false)
        end)

        LaunchGame(
            tostring(destinationPlaceId),
            Constants2.JoinReferralPage,
            { moments_play_intent_id = var5 },
            nil,
            Constants2.JoinLaunchSource
        )
    end, { var1.joining, var2 })
end

return useJoinExperience
