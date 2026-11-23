-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:20:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local React = require(BuildExperienceParent.React)
local FocusNavigationUtils = require(BuildExperienceParent.FocusNavigationUtils)
local Responsive = require(BuildExperienceParent.Responsive)
local WebViewUtils = require(BuildExperienceParent.WebViewUtils)
local useOpenWebView = WebViewUtils.useOpenWebView
local openWebViewSession = WebViewUtils.openWebViewSession
local useLocalization = require(BuildExperienceParent.Localization).Hooks.useLocalization

local FFlagBuildAnalyticsCreatorHubWindowFix = require(BuildExperience.Flags.FFlagBuildAnalyticsCreatorHubWindowFix)
local FFlagBuildAnalyticsGoals = require(BuildExperience.Flags.FFlagBuildAnalyticsGoals)
local FFlagBuildCheckGamePermissions = require(BuildExperience.Flags.FFlagBuildCheckGamePermissions)

local LocalizationStrings = require(BuildExperience.LocalizationStrings)
local AnalyticsKeys = require(BuildExperience.Analytics.AnalyticsKeys)
local AnalyticsMetric = require(BuildExperience.Analytics.AnalyticsMetric)
local _AnalyticsWindow = require(BuildExperience.Analytics.AnalyticsWindow)
local _CreatorAnalytics = require(BuildExperienceParent.DataHydration.CreatorAnalytics)
local GameConfigurationActions = require(BuildExperience.utils.GameConfigurationActions)
local _MetricDetailSheetView = require(script.Parent.MetricDetailSheetView)
local useClosableFocusRoot = require(BuildExperience.utils.useClosableFocusRoot)

local function useMetricDetailSheetViewModel(tbl1)
    local var1, bool1

    if FFlagBuildAnalyticsGoals then
        var1 = useClosableFocusRoot({
            surfaceIdentifier = FocusNavigationUtils.FocusNavigableSurfaceIdentifierEnum.PopUp,
            isOpen = true,
            onClose = tbl1.onClose
        })
        if Responsive.usePreferredInput() == Responsive.Input.Directional then
            bool1 = false
        else
            bool1 = true
        end
    else
        var1 = nil
        bool1 = true
    end

    local var2 = if tbl1.metricId ~= nil then AnalyticsMetric.MetricById[tbl1.metricId] or AnalyticsMetric.DailyActiveUsers else AnalyticsMetric.DailyActiveUsers
    local latestAvailableTime = tbl1.latestAvailableTime
    local var3 = nil
    if FFlagBuildAnalyticsGoals then
        local var4, var5 = React.useState(1)
        local metrics = tbl1.metrics
        local count = if metrics == nil then 0 else #metrics
        local index = math.clamp(var4, 1, math.max(1, count))
        React.useEffect(function()
            var5(1)
        end, { metrics })
        if metrics ~= nil and count > 0 then
            var2 = metrics[index]
            if tbl1.latestByMetric == nil then
                latestAvailableTime = nil
            else
                latestAvailableTime = tbl1.latestByMetric[var2.id]
            end
        end

        if count > 1 then
            var3 = {
                index = index,
                count = count,
                onPrevious = function()
                    var5(math.max(1, index - 1))
                end,
                onNext = function()
                    var5(math.min(count, index + 1))
                end
            }
        end
    end
    local var4 = useOpenWebView()

    local tbl2 = {
        analyze = if FFlagBuildAnalyticsGoals then AnalyticsKeys.ANALYTICS_SHEET_ASK_ABOUT_THIS else AnalyticsKeys.ANALYTICS_SHEET_ANALYZE,
        viewInOverview = if FFlagBuildAnalyticsGoals then AnalyticsKeys.ANALYTICS_SHEET_VIEW_MORE_STATS else AnalyticsKeys.ANALYTICS_SHEET_VIEW_IN_OVERVIEW,
        title = if FFlagBuildAnalyticsGoals then tbl1.titleKey or var2.titleKey else var2.titleKey,
        summary = var2.summaryKey,
        description = var2.descriptionKey,
        analyzeName = var2.analyzeNameKey
    }
    local improvementKey = if FFlagBuildAnalyticsGoals then var2.improvementKey else nil

    if improvementKey ~= nil then
        tbl2.howToImprove = AnalyticsKeys.ANALYTICS_HOW_TO_IMPROVE
        tbl2.improvement = improvementKey
    end
    local var5 = useLocalization(tbl2)
    local function copy(str1: string) -- Luacid: Inlined by compiler; 8 call sites recovered
        return if tbl2[str1] == nil then "" else var5[str1]
    end

    local onClose = tbl1.onClose
    local analyzeName = copy("analyzeName")
    local analyzePrompt = useLocalization({
        analyzePrompt = {
            AnalyticsKeys.ANALYTICS_ANALYZE_CHAT_PROMPT,
            analyzeName = analyzeName,
            days = tostring(tbl1.window.days)
        }
    }).analyzePrompt
    local onOpenChat = tbl1.onOpenChat
    local onAnalyze = React.useCallback(function()
        if onOpenChat ~= nil and analyzeName ~= "" then
            onOpenChat(analyzePrompt)
        end
        onClose()
    end, {
        onOpenChat,
        analyzePrompt,
        analyzeName,
        onClose
    })

    local creatorHub = useLocalization({ creatorHub = LocalizationStrings.GAME_CONFIGURATION_CREATOR_HUB }).creatorHub
    local overviewPath = var2.overviewPath
    local universeId = tbl1.universeId
    local creatorHubRangeType = if FFlagBuildAnalyticsCreatorHubWindowFix then tbl1.window.creatorHubRangeType else nil

    local onViewInOverview = React.useCallback(function()
        if overviewPath ~= nil then
            local creatorHubAnalyticsUrl = GameConfigurationActions.getCreatorHubAnalyticsUrl(universeId, overviewPath, creatorHubRangeType)
            if FFlagBuildAnalyticsGoals then
                openWebViewSession(creatorHubAnalyticsUrl, creatorHub)
            else
                var4(creatorHubAnalyticsUrl, creatorHub)
            end
        end
        onClose()
    end, {
        var4,
        overviewPath,
        universeId,
        creatorHubRangeType,
        creatorHub,
        onClose
    })
    return {
        focusRootRef = var1,
        showCloseButton = bool1,
        metric = var2,
        universeId = tbl1.universeId,
        window = tbl1.window,
        latestAvailableTime = latestAvailableTime,
        navigation = var3,
        metadataStatus = tbl1.metadataStatus,
        titleText = copy("title"),
        summaryText = copy("summary"),
        descriptionText = copy("description"),
        improvementTitleText = copy("howToImprove"),
        improvementText = copy("improvement"),
        analyzeText = copy("analyze"),
        viewInOverviewText = copy("viewInOverview"),
        onAnalyze = onAnalyze,
        isAnalyzeDisabled = FFlagBuildCheckGamePermissions and onOpenChat == nil,
        onViewInOverview = onViewInOverview,
        onClose = tbl1.onClose,
        testId = tbl1.testId
    }
end

return useMetricDetailSheetViewModel
