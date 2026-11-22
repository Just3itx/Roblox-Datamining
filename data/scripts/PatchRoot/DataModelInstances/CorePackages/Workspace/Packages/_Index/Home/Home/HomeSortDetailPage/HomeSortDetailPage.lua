-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T00:30:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Home = script:FindFirstAncestor("Home")
local HomeParent = Home.Parent

local AppPage = require(HomeParent.RobloxAppEnums).AppPage
local LoggingProtocol = require(HomeParent.LoggingProtocol)
local _Navigation = require(HomeParent.Navigation)
local React = require(HomeParent.React)
local SduiSharedUtilities = require(HomeParent.SduiSharedUtilities)
local sortDeeplinkFailureCounter = require(HomeParent.DiscoveryAnalytics).Events.sortDeeplinkFailureCounter

local buildHomeSortDetailPageEntry = require(Home.HomeSortDetailPage.buildHomeSortDetailPageEntry)
local fetchHomeSortDetail = require(Home.HomeSortDetailPage.fetchHomeSortDetail)
local getHomeSortDetailPageKey = require(Home.HomeSortDetailPage.getHomeSortDetailPageKey)
local HomeConstants = require(Home.HomeConstants)
local HomeSortDetailConstants = require(Home.HomeSortDetailPage.HomeSortDetailConstants)
local HomeSortDetailScopeFields = require(Home.HomeSortDetailPage.HomeSortDetailScopeFields)
local fetchHomePage = require(Home.fetchHomePage)
local refreshHomePage = require(Home.refreshHomePage)

local SduiPageWrapperEntryPoint = SduiSharedUtilities.SduiPageWrapperEntryPoint
local SduiSurfaceLoadTimeTracker = SduiSharedUtilities.SduiSurfaceLoadTimeTracker
local UiStatus = SduiSharedUtilities.UiStatus
local useInputData = SduiSharedUtilities.useInputData
local usePageScopeRef = SduiSharedUtilities.usePageScopeRef
local useUiStatus = SduiSharedUtilities.useUiStatus

local FFlagLuaAppSduiHomeSortDetailPageContext = require(HomeParent.SharedFlags).FFlagLuaAppSduiHomeSortDetailPageContext
local FFlagAppThemeHalloween2026HomeBackground = require(HomeParent.SharedFlags).FFlagAppThemeHalloween2026HomeBackground

local function getFromPropsOrNavigationParams(tbl1, str1: string) -- Luacid: Inlined by compiler; 3 call sites recovered
    return tbl1[str1] or tbl1.navigation and tbl1.navigation.getParam(str1)
end

return React.memo(function(tbl1) -- name: HomeSortDetailPage
    local sortName = getFromPropsOrNavigationParams(tbl1, "sortId")
    local fromPropsOrNavigationParams2 = getFromPropsOrNavigationParams(tbl1, "sortIndex")
    local homeSortDetailPageKey = getHomeSortDetailPageKey(sortName, fromPropsOrNavigationParams2)
    local fromPropsOrNavigationParams3 = getFromPropsOrNavigationParams(tbl1, "pageTimer")
    local var1 = useInputData(HomeConstants.ConfigKey, HomeConstants.ContentIdentifier)
    local var2 = useUiStatus(HomeConstants.ConfigKey)
    local var3 = useUiStatus(homeSortDetailPageKey)
    local var4 = React.useRef(nil)
    local var5 = React.useRef(false)

    usePageScopeRef(homeSortDetailPageKey)

    React.useMemo(function()
        local sduiClientPageScope = SduiSharedUtilities.getSduiClientPageScope(homeSortDetailPageKey)
        sduiClientPageScope.set(HomeSortDetailScopeFields.SelectedSortId, sortName)
        sduiClientPageScope.set(HomeSortDetailScopeFields.SelectedSortIndex, fromPropsOrNavigationParams2)
    end, { homeSortDetailPageKey, sortName, fromPropsOrNavigationParams2 })

    local pageTimer = React.useMemo(function()
        local var6 = fromPropsOrNavigationParams3
            or SduiSurfaceLoadTimeTracker.createLoadTimerWithSurfaceLoadTime(
                HomeSortDetailConstants.SurfaceKey,
                {
                    eventName = HomeSortDetailConstants.SurfaceLoadTimeEventName,
                    metadata = { page = "mount" }
                }
            )

        SduiSharedUtilities.getSduiClientPageScope(homeSortDetailPageKey).set(
            SduiSurfaceLoadTimeTracker.SURFACE_LOAD_TIME_PAGE_SCOPE_KEY,
            var6
        )
        return var6
    end, { homeSortDetailPageKey, fromPropsOrNavigationParams3 })

    local var7 = React.useCallback(function(reason: string)
        if var5.current then
            return
        end
        var5.current = true
        LoggingProtocol.default:logRobloxTelemetryCounter(
            sortDeeplinkFailureCounter,
            1,
            { reason = reason, sortName = sortName, isOmni = true }
        )

        if tbl1.onSortUnavailable then
            tbl1.onSortUnavailable()
        end
    end, { tbl1.onSortUnavailable, sortName })

    React.useEffect(function()
        fetchHomePage(SduiSharedUtilities.SduiLoadTimer.createLoadTimer(HomeConstants.ConfigKey))
    end, {})

    React.useEffect(function()
        if sortName == nil then
            var7("InvalidSort")
            return
        end

        if var2 == UiStatus.Error then
            var7("SortTokenFetchFailed")
            return
        end

        if var2 ~= UiStatus.Resolved or var1 == nil then
            return
        end

        if buildHomeSortDetailPageEntry(sortName, fromPropsOrNavigationParams2) == nil then
            var7("InvalidSort")
            return
        end

        if var4.current == homeSortDetailPageKey then
            return
        end

        var4.current = homeSortDetailPageKey
        if fetchHomeSortDetail(sortName, fromPropsOrNavigationParams2, pageTimer) == nil then
            var7("SortTokenFetchFailed")
        end
    end, {
        homeSortDetailPageKey,
        var1,
        var2,
        pageTimer,
        var7,
        sortName,
        fromPropsOrNavigationParams2
    })

    React.useEffect(function()
        if var3 == UiStatus.Error then
            var7("SortTokenFetchFailed")
            return
        end

        if var3 ~= UiStatus.Resolved or var2 ~= UiStatus.Resolved or var1 == nil or sortName == nil then
            return
        end

        local homeSortDetailPageEntry = buildHomeSortDetailPageEntry(sortName, fromPropsOrNavigationParams2)
        local bool1 = SduiSharedUtilities.getSduiApiStore().getRootConfig(homeSortDetailPageKey, false) ~= nil
        if homeSortDetailPageEntry == nil or not bool1 then
            var7("InvalidSort")
        end
    end, {
        homeSortDetailPageKey,
        var3,
        var1,
        var2,
        var7,
        sortName,
        fromPropsOrNavigationParams2
    })

    local refresh = React.useCallback(function()
        if sortName == nil then
            return nil
        end

        local loadTimerWithSurfaceLoadTime = SduiSurfaceLoadTimeTracker.createLoadTimerWithSurfaceLoadTime(
            HomeSortDetailConstants.SurfaceKey,
            {
                eventName = HomeSortDetailConstants.SurfaceLoadTimeEventName,
                metadata = { page = "refresh" }
            }
        )

        loadTimerWithSurfaceLoadTime.start("refresh")

        local var8 = refreshHomePage()
        if var8 then
            return var8:finally(function()
                loadTimerWithSurfaceLoadTime.logRefreshComplete()
            end)
        end
        loadTimerWithSurfaceLoadTime.logRefreshComplete()
        return nil
    end, { sortName })

    if sortName == nil then
        return nil
    end

    return React.createElement(SduiPageWrapperEntryPoint, {
        appPage = if FFlagLuaAppSduiHomeSortDetailPageContext then tbl1.pageContext or AppPage.Home else AppPage.Home,
        routeName = AppPage.GamesList,
        configKey = homeSortDetailPageKey,
        contentIdentifier = HomeSortDetailConstants.Identifier,
        pageTimer = pageTimer,
        refresh = refresh,
        additionalAnalyticsData = {
            pageContext = tbl1.pageContext or AppPage.Home
        },
        pageTopPadding = tbl1.pageTopPadding,
        backgroundStyle = if FFlagAppThemeHalloween2026HomeBackground then tbl1.backgroundStyle else nil
    })
end)
