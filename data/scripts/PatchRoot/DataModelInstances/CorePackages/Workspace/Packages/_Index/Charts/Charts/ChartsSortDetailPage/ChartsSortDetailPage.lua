-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T06:30:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Charts = script:FindFirstAncestor("Charts")
local ChartsParent = Charts.Parent

local _Navigation = require(ChartsParent.Navigation)
local React = require(ChartsParent.React)
local RobloxAppEnums = require(ChartsParent.RobloxAppEnums)
local SduiSharedUtilities = require(ChartsParent.SduiSharedUtilities)
local CompositionTags = require(ChartsParent.AppComposition).CompositionTags

local AppPage = RobloxAppEnums.AppPage
local FFlagAppThemeHalloween2026HomeBackground = require(ChartsParent.SharedFlags).FFlagAppThemeHalloween2026HomeBackground

local SduiPageEntryPoint = SduiSharedUtilities.SduiPageEntryPoint
local SduiSurfaceLoadTimeTracker = SduiSharedUtilities.SduiSurfaceLoadTimeTracker
local getSduiClientPageScope = SduiSharedUtilities.getSduiClientPageScope
local usePageScopeRef = SduiSharedUtilities.usePageScopeRef
local ChartsConstants = require(Charts.ChartsPage.ChartsConstants)
local ChartsPageScopeFields = require(Charts.ChartsPage.ChartsPageScopeFields)
local ChartsSortDetailConstants = require(Charts.ChartsSortDetailPage.ChartsSortDetailConstants)
local ChartsSortDetailScopeFields = require(Charts.ChartsSortDetailPage.ChartsSortDetailScopeFields)
local fetchChartsSortDetail = require(Charts.ChartsSortDetailPage.fetchChartsSortDetail)
local getChartsSortDetailPageKey = require(Charts.ChartsSortDetailPage.getChartsSortDetailPageKey)

local function getFromPropsOrNavigationParams(tbl1, str1: string) -- Luacid: Inlined by compiler; 2 call sites recovered
    return tbl1[str1] or tbl1.navigation and tbl1.navigation.getParam(str1)
end

return React.memo(function(tbl1) -- name: ChartsSortDetailPage
    local fromPropsOrNavigationParams = getFromPropsOrNavigationParams(tbl1, "sortId")

    local var1 = React.useMemo(function()
        return getSduiClientPageScope(ChartsConstants.ConfigKey).get(ChartsPageScopeFields.FilterSelections)
    end, {})
    local configKey = getChartsSortDetailPageKey(fromPropsOrNavigationParams, nil, var1)
    local fromPropsOrNavigationParams2 = getFromPropsOrNavigationParams(tbl1, "pageTimer")
    usePageScopeRef(configKey)
    React.useMemo(function()
        getSduiClientPageScope(configKey).set(ChartsSortDetailScopeFields.SelectedSortId, fromPropsOrNavigationParams)
    end, { configKey, fromPropsOrNavigationParams })

    local pageTimer = React.useMemo(function()
        local var2 = fromPropsOrNavigationParams2
            or SduiSurfaceLoadTimeTracker.createLoadTimerWithSurfaceLoadTime(
                configKey,
                {
                    eventName = ChartsSortDetailConstants.SurfaceLoadTimeEventName,
                    metadata = { page = "mount" }
                }
            )

        getSduiClientPageScope(configKey).set(SduiSurfaceLoadTimeTracker.SURFACE_LOAD_TIME_PAGE_SCOPE_KEY, var2)
        return var2
    end, { configKey, fromPropsOrNavigationParams2 })

    React.useEffect(function()
        if fromPropsOrNavigationParams then
            fetchChartsSortDetail(fromPropsOrNavigationParams, pageTimer)
        end
    end, { fromPropsOrNavigationParams, pageTimer })

    local refresh = React.useCallback(function()
        if not fromPropsOrNavigationParams then
            return
        end

        local loadTimerWithSurfaceLoadTime = SduiSurfaceLoadTimeTracker.createLoadTimerWithSurfaceLoadTime(
            configKey,
            {
                eventName = ChartsSortDetailConstants.SurfaceLoadTimeEventName,
                metadata = { page = "refresh" }
            }
        )

        loadTimerWithSurfaceLoadTime.start("refresh")
        fetchChartsSortDetail(fromPropsOrNavigationParams, loadTimerWithSurfaceLoadTime)
    end, { fromPropsOrNavigationParams, configKey })

    local additionalAnalyticsData = React.useMemo(function(): {pageContext: any}?
        return if tbl1.pageContext then {
            pageContext = tbl1.pageContext
        } else nil
    end, { tbl1.pageContext })

    if fromPropsOrNavigationParams == nil then
        return nil
    end

    return React.createElement(SduiPageEntryPoint, {
        appPage = tbl1.pageContext or AppPage.Games,
        routeName = AppPage.GamesList,
        configKey = configKey,
        pageTimer = pageTimer,
        includeNavigationHeaderBar = false,
        refresh = refresh,
        contentTag = CompositionTags.ContentRegion.Body,
        stickyContentTag = CompositionTags.ContentRegion.Header,
        additionalAnalyticsData = additionalAnalyticsData,
        pageTopPadding = tbl1.pageTopPadding,
        backgroundStyle = if FFlagAppThemeHalloween2026HomeBackground then tbl1.backgroundStyle else nil,
        feedBackgroundStyle = if FFlagAppThemeHalloween2026HomeBackground then tbl1.backgroundStyle else nil
    })
end)
