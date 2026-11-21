-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T06:30:37Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Charts = script:FindFirstAncestor("Charts")
local ChartsParent = Charts.Parent

local _Navigation = require(ChartsParent.Navigation)
local React = require(ChartsParent.React)
local AppPage = require(ChartsParent.RobloxAppEnums).AppPage
local SduiSharedUtilities = require(ChartsParent.SduiSharedUtilities)
local CompositionTags = require(ChartsParent.AppComposition).CompositionTags

local FFlagAppThemeHalloween2026HomeBackground = require(ChartsParent.SharedFlags).FFlagAppThemeHalloween2026HomeBackground

local SduiPageEntryPoint = SduiSharedUtilities.SduiPageEntryPoint
local SduiSurfaceLoadTimeTracker = SduiSharedUtilities.SduiSurfaceLoadTimeTracker
local getSduiClientPageScope = SduiSharedUtilities.getSduiClientPageScope
local usePageScopeRef = SduiSharedUtilities.usePageScopeRef
local fetchChartsPage = require(Charts.ChartsPage.fetchChartsPage)
local ChartsConstants = require(Charts.ChartsPage.ChartsConstants)

local function getFromPropsOrNavigationParams(tbl1, str1: string) -- Luacid: Inlined by compiler; 1 call site recovered
    return tbl1[str1] or tbl1.navigation and tbl1.navigation.getParam(str1)
end

return React.memo(function(tbl1) -- name: ChartsContentEntryPoint
    local configKey = ChartsConstants.ConfigKey
    local fromPropsOrNavigationParams = getFromPropsOrNavigationParams(tbl1, "pageTimer")
    usePageScopeRef(configKey)
    local pageTimer = React.useMemo(function()
        if fromPropsOrNavigationParams then
            getSduiClientPageScope(configKey).set(
                SduiSurfaceLoadTimeTracker.SURFACE_LOAD_TIME_PAGE_SCOPE_KEY,
                fromPropsOrNavigationParams
            )
            return fromPropsOrNavigationParams
        end
        local loadTimerWithSurfaceLoadTime = SduiSurfaceLoadTimeTracker.createLoadTimerWithSurfaceLoadTime(
            configKey,
            {
                eventName = ChartsConstants.SurfaceLoadTimeEventName,
                metadata = { page = "mount" }
            }
        )

        loadTimerWithSurfaceLoadTime.start("mount")
        getSduiClientPageScope(configKey).set(
            SduiSurfaceLoadTimeTracker.SURFACE_LOAD_TIME_PAGE_SCOPE_KEY,
            loadTimerWithSurfaceLoadTime
        )
        return loadTimerWithSurfaceLoadTime
    end, { configKey, fromPropsOrNavigationParams })

    React.useEffect(function()
        fetchChartsPage(pageTimer)
    end, { configKey, pageTimer })

    local refresh = React.useCallback(function()
        local loadTimerWithSurfaceLoadTime = SduiSurfaceLoadTimeTracker.createLoadTimerWithSurfaceLoadTime(
            configKey,
            {
                eventName = ChartsConstants.SurfaceLoadTimeEventName,
                metadata = { page = "refresh" }
            }
        )

        loadTimerWithSurfaceLoadTime.start("refresh")
        return fetchChartsPage(loadTimerWithSurfaceLoadTime, true)
    end, { configKey })

    return React.createElement(SduiPageEntryPoint, {
        appPage = AppPage.Games,
        configKey = configKey,
        pageTimer = pageTimer,
        refresh = refresh,
        includeNavigationHeaderBar = false,
        contentTag = CompositionTags.ContentRegion.Body,
        stickyContentTag = CompositionTags.ContentRegion.Header,
        scrollPerformanceIntervalName = ChartsConstants.ScrollPerformanceIntervalName,
        pageTopPadding = tbl1.pageTopPadding,
        feedTopMargin = tbl1.feedTopMargin,
        scrollAway = tbl1.scrollAway,
        backgroundStyle = if FFlagAppThemeHalloween2026HomeBackground then tbl1.backgroundStyle else nil,
        feedBackgroundStyle = if FFlagAppThemeHalloween2026HomeBackground then tbl1.backgroundStyle else nil
    })
end)
