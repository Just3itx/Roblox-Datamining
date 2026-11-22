-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:41:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Moments = script:FindFirstAncestor("Moments")
local MomentsParent = Moments.Parent

local LocalizationService = game:GetService("LocalizationService")

local _AnalyticsMetricChart = require(MomentsParent.AnalyticsMetricChart)
local BuilderIcons = require(MomentsParent.BuilderIcons)
local Foundation = require(MomentsParent.Foundation)
local Localization = require(MomentsParent.Localization)
local MomentsCommon = require(MomentsParent.MomentsCommon)
local MomentsTypes = require(MomentsParent.MomentsTypes)
local React = require(MomentsParent.React)
local SignalsReact = require(MomentsParent.SignalsReact)

local abbreviateCount = Localization.abbreviateCount
local NumberLocalization = Localization.NumberLocalization
local useLocalization = Localization.Hooks.useLocalization
local useSignalState = SignalsReact.useSignalState
local useTokens = Foundation.Hooks.useTokens
local ReactionType = MomentsTypes.Enums.ReactionType

local CreatorAnalytics = require(MomentsParent.DataHydration.CreatorAnalytics)

local _createPostInsightsPageStore = require(script.Parent.createPostInsightsPageStore)
local makeFeedActionFields = require(Moments.Analytics.makeFeedActionFields)
local postInsightsStrings = require(script.Parent.postInsightsStrings)
local usePostInsightsAnalytics = require(script.Parent.usePostInsightsAnalytics)
local toMediaItem = require(Moments.Components.Feed.Media.toMediaItem)

local DataStatus = CreatorAnalytics.DataStatus
local EventNames = MomentsCommon.Analytics.EventNames

local function isAwaitingQueries(tbl1) -- Luacid: Inlined by compiler; 3 call sites recovered
    local bool1 = false
    for _, value in tbl1 do
        if value == DataStatus.Failed then
            return false
        end
        if value == DataStatus.NotReady then
            bool1 = true
        end
    end

    return bool1
end

local function getPlayableSeconds(metadata) -- Luacid: Inlined by compiler; 1 call site recovered
    local trim = if metadata.edits == nil then nil else metadata.edits.trim

    if trim ~= nil and trim.endTime > trim.startTime then
        return trim.endTime - trim.startTime
    end
    local assetTotalDuration = metadata.assetTotalDuration
    return if assetTotalDuration == nil or not (assetTotalDuration > 0) then nil else assetTotalDuration
end

local function percentKey(num1: number, robloxLocaleId: string) -- Luacid: Inlined by compiler; 2 call sites recovered
    return {
        postInsightsStrings.PERCENT_KEY,
        number = NumberLocalization.localize(math.round(num1 * 1000) / 10, robloxLocaleId)
    }
end

local tbl1 = {
    ReactionType.ThumbsUp,
    ReactionType.Heart,
    ReactionType.LaughJoy,
    ReactionType.Wow,
    ReactionType.Cry,
    ReactionType.Fire,
    ReactionType.Skull
}

local function usePostInsightsPageViewModel(arg1, callback: (...any) -> (...any))
    local var1 = useTokens()
    local var2 = useLocalization(postInsightsStrings.PAGE_KEYS)
    local moment = arg1.moment
    local momentStore = arg1.momentStore

    local var3 = useSignalState(momentStore.getReactionCount)
    local var4 = useSignalState(momentStore.getIndividualReactionCounts)
    local var5 = useSignalState(momentStore.getCommentCount)
    local var6 = useSignalState(momentStore.getShareCount)

    local mediaItem = React.useMemo(function()
        local var7 = toMediaItem({ kind = "moment", moment = moment })
        if var7 ~= nil then
            var7.cornerRadius = var1.Radius.Small
        end
        return var7
    end, { moment.momentId })

    local reactionCounts = React.useMemo(function()
        local tbl2 = {}
        for _, value in var4 do
            tbl2[value.reaction] = value.count
        end
        local result = {}
        for _, reactionType in tbl1 do
            table.insert(result, {
                reactionType = reactionType,
                countText = abbreviateCount(tbl2[reactionType] or 0, LocalizationService.RobloxLocaleId)
            })
        end
        return result
    end, { var4 })

    local var9 = usePostInsightsAnalytics(moment)
    local robloxLocaleId = LocalizationService.RobloxLocaleId

    local function logPageEvent(arg2, str1: string, num1: number?) -- Luacid: Inlined by compiler; 2 call sites recovered
        local recommendationMetadata = moment.recommendationMetadata
        local feedActionFields = makeFeedActionFields(
            moment.momentId,
            if recommendationMetadata == nil then nil else recommendationMetadata.feedItemId,
            if recommendationMetadata == nil then nil else recommendationMetadata.tracingId,
            str1
        )

        if feedActionFields == nil then
            return
        end

        if num1 ~= nil then
            feedActionFields.durationMs = tostring(num1)
        end

        MomentsCommon.Analytics.fireAnalyticsEvent(arg2, feedActionFields)
    end

    local bool1 = not (var9.viewsStatus == DataStatus.NotReady) and var9.lifetimeStatus ~= DataStatus.NotReady
    local var10 = React.useRef(false)
    React.useEffect(function()
        if not bool1 or var10.current then
            return
        end
        var10.current = true
        logPageEvent(EventNames.PostInsightsPageImpression, "post_insights_impression", nil)
    end, { bool1 })

    local var11 = React.useRef(os.clock())

    local onBack = React.useCallback(function()
        local num1 = math.round((os.clock() - var11.current) * 1000)
        logPageEvent(EventNames.PostInsightsBackButtonPressed, "post_insights_back", num1)
        callback()
    end, { callback, moment })

    local lifetimeViews = var9.lifetimeViews
    local var13 = nil
    local var14 = nil
    local var15 = nil
    if lifetimeViews ~= nil and lifetimeViews > 0 then
        if var9.lifetimeWatchTimeSeconds ~= nil then
            var13 = math.round(var9.lifetimeWatchTimeSeconds / lifetimeViews)
        end
        local playableSeconds = getPlayableSeconds(moment.metadata)
        if var9.lifetimeWatchTimeNoReplaySeconds ~= nil and playableSeconds ~= nil then
            var14 = math.min(var9.lifetimeWatchTimeNoReplaySeconds / lifetimeViews / playableSeconds, 1)
        end
        if var9.lifetimeJoins ~= nil then
            var15 = var9.lifetimeJoins / lifetimeViews
        end
    end

    local var16 = React.useMemo(function()
        return {
            averageWatchTime = {
                postInsightsStrings.DURATION_SECONDS_KEY,
                seconds = var13 or 0
            },
            averageCompletion = percentKey(var14 or 0, robloxLocaleId),
            gameJoinConversion = percentKey(var15 or 0, robloxLocaleId)
        }
    end, {
        var13 or false,
        var14 or false,
        var15 or false,
        robloxLocaleId
    })

    local var17 = useLocalization(var16)
    local isoDate = if moment.createdAt == nil then nil else DateTime.fromIsoDate(moment.createdAt)
    local date = if isoDate == nil then nil else isoDate:FormatLocalTime("L", robloxLocaleId)

    local var19 = React.useMemo(function()
        return {
            postedOn = {
                postInsightsStrings.POSTED_ON_DATE_KEY,
                date = date or ""
            }
        }
    end, { date or false })
    local var20 = useLocalization(var19)

    local isLoading = isAwaitingQueries({ var9.lifetimeViewsStatus, var9.lifetimeWatchTimeStatus })

    local bool2 = isAwaitingQueries({ var9.lifetimeViewsStatus, var9.lifetimeWatchTimeNoReplayStatus })
    local bool3 = isAwaitingQueries({ var9.lifetimeViewsStatus, var9.lifetimeJoinsStatus })
    local overviewMetrics = {
        {
            key = "averageWatchTime",
            label = var2.averageWatchTime,
            valueText = if var13 == nil then "—" else var17.averageWatchTime,
            isLoading = isLoading
        },
        {
            key = "averageCompletion",
            label = var2.averageCompletion,
            valueText = if var14 == nil then "—" else var17.averageCompletion,
            isLoading = bool2
        },
        {
            key = "gameJoinConversion",
            label = var2.gameJoinConversion,
            valueText = if var15 == nil then "—" else var17.gameJoinConversion,
            isLoading = bool3
        }
    }

    local viewsSeries = var9.viewsSeries
    local bool5 = not (var9.window == nil) and var9.window.granularity == CreatorAnalytics.MetricGranularity.OneHour

    local function formatTime(isoDate2: string): string -- Luacid: Inlined by compiler; 1 call site recovered
        local dateTime = DateTime.fromIsoDate(isoDate2)
        if dateTime == nil then
            return isoDate2
        elseif bool5 then
            return (dateTime:FormatLocalTime("LT", robloxLocaleId))
        end

        return (dateTime:FormatUniversalTime("MMM D", robloxLocaleId))
    end
    local isViewsChartLoading = var9.viewsStatus == DataStatus.NotReady
    local hasData = not (viewsSeries == nil) and viewsSeries.hasData
    local bool7 = var9.lifetimeViewsStatus == DataStatus.NotReady

    if not hasData and lifetimeViews == 0 then
        lifetimeViews = nil
    end

    local var21 = if lifetimeViews == nil then "—" else abbreviateCount(lifetimeViews, robloxLocaleId)
    if not (hasData or isViewsChartLoading) then
        table.insert(overviewMetrics, 1, { key = "totalViews", label = var2.totalViews, valueText = var21, isLoading = bool7 })
    end

    local viewsChart = {
        plotId = `views:{moment.momentId}`,
        series = viewsSeries ~= nil and {{
            id = "views",
            name = var2.totalViews,
            points = viewsSeries.points
        }} or nil,
        hasData = hasData,
        hideHeader = true,
        title = var2.totalViews,
        valueText = var21,
        isDeltaPositive = false,
        yAxisFormatter = function(tbl3)
            return abbreviateCount(tbl3.value, robloxLocaleId)
        end,
        xAxisFormatter = function(tbl3): string
            return formatTime(tbl3.value)
        end,
        tooltipFormatters = {
            formatXForPoint = formatTime,
            formatSeriesValueForPoint = function(tbl3)
                return NumberLocalization.localize(tbl3.y, robloxLocaleId)
            end
        },
        testId = "post-insights-views-chart"
    }

    local description = moment.metadata.description
    local bool8 = not (moment.comments == nil) and moment.comments.countIsCapped == true
    local tbl4 = {
        title = var2.title,
        overviewHeading = var2.overview,
        engagementHeading = var2.engagement,
        totalReactionsLabel = var2.totalReactions,
        onBack = onBack,
        mediaItem = mediaItem,
        caption = 0,
        postedOnText = 0,
        interactionCounts = 0,
        totalViewsLabel = 0,
        totalViewsText = 0,
        isTotalViewsLoading = 0,
        viewsChart = 0,
        isViewsChartLoading = 0,
        isViewsChartVisible = 0,
        overviewMetrics = 0,
        totalReactionsText = 0,
        reactionCounts = 0
    }

    if description == nil or description == "" then
        description = nil
    end

    tbl4.caption = description
    tbl4.postedOnText = if date == nil then nil else var20.postedOn
    tbl4.interactionCounts = {
        {
            key = "likes",
            icon = BuilderIcons.Icon.ThumbUp,
            countText = abbreviateCount(var3 or 0, LocalizationService.RobloxLocaleId)
        },
        {
            key = "comments",
            icon = BuilderIcons.Icon.SpeechBubbleAlignLeft,
            countText = abbreviateCount(var5 or 0, LocalizationService.RobloxLocaleId) .. (if bool8 then "+" else "")
        },
        {
            key = "shares",
            icon = BuilderIcons.Icon.ArrowThickToRight,
            countText = abbreviateCount(var6 or 0, LocalizationService.RobloxLocaleId)
        }
    }

    tbl4.totalViewsLabel = var2.totalViews
    tbl4.totalViewsText = var21
    tbl4.isTotalViewsLoading = bool7
    tbl4.viewsChart = viewsChart
    tbl4.isViewsChartLoading = isViewsChartLoading
    tbl4.isViewsChartVisible = hasData
    tbl4.overviewMetrics = overviewMetrics
    tbl4.totalReactionsText = abbreviateCount(var3 or 0, LocalizationService.RobloxLocaleId)
    tbl4.reactionCounts = reactionCounts
    return tbl4
end

return usePostInsightsPageViewModel
