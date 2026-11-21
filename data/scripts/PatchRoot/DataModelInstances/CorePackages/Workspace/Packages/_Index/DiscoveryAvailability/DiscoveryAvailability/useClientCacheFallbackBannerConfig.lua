-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T10:50:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DiscoveryAvailability = script:FindFirstAncestor("DiscoveryAvailability")
local DiscoveryAvailabilityParent = DiscoveryAvailability.Parent
local React = require(DiscoveryAvailabilityParent.React)

local useSelector = require(DiscoveryAvailabilityParent.RoactUtils).Hooks.RoactRodux.useSelector
local useDispatch = require(DiscoveryAvailabilityParent.RoactUtils).Hooks.RoactRodux.useDispatch
local NavigationRodux = require(DiscoveryAvailabilityParent.NavigationRodux)
local selectCurrentRoactNavigationRoute = NavigationRodux.Selectors.selectCurrentRoactNavigationRoute
local GetLegacyNavigationStore = NavigationRodux.GetLegacyNavigationStore
local SharedFlags = require(DiscoveryAvailabilityParent.SharedFlags)
local FFlagSignalsNavP3fGameDetails = SharedFlags.FFlagSignalsNavP3fGameDetails
local FFlagUseSignalsForStartup = SharedFlags.FFlagUseSignalsForStartup
local FFlagLuaAppEnableSduiHomePage = SharedFlags.FFlagLuaAppEnableSduiHomePage
local GetStartupStore = if FFlagUseSignalsForStartup then require(DiscoveryAvailabilityParent.StartupStore).GetStartupStore else nil
local AppPage = require(DiscoveryAvailabilityParent.RobloxAppEnums).AppPage
local RetrievalStatus = require(DiscoveryAvailabilityParent.Http).Enum.RetrievalStatus
local RobloxAppHooks = require(DiscoveryAvailabilityParent.RobloxAppHooks)
local _LuauPolyfill = require(DiscoveryAvailabilityParent.LuauPolyfill)
local Promise = require(DiscoveryAvailabilityParent.Promise)
local SignalsReact = require(DiscoveryAvailabilityParent.SignalsReact)
local Signals = require(DiscoveryAvailabilityParent.Signals)
local Signals2 = require(DiscoveryAvailability.Signals)
local useRoactService = RobloxAppHooks.useRoactService
local RoactNetworking = require(DiscoveryAvailabilityParent.RoactServiceTags).RoactNetworking
local AppOmniRecommendationsRequest = require(DiscoveryAvailabilityParent.RoactServiceTags).AppOmniRecommendationsRequest
local AppLogging = require(DiscoveryAvailabilityParent.RoactServiceTags).AppLogging
local DiscoveryEventErrorLogger = require(DiscoveryAvailabilityParent.DiscoveryUtils).DiscoveryEventErrorLogger

local OmniFeedConstants = require(DiscoveryAvailabilityParent.DiscoveryTypes).OmniFeedConstants

local function useClientCacheFallbackBannerConfig(func1: (...any) -> (...any), func2: (...any) -> (...any))
    local var1 = useDispatch()
    local var2 = nil
    local var3 = nil
    if FFlagSignalsNavP3fGameDetails then
        local var4 = React.useMemo(function()
            return Signals.createComputed(function(arg1): boolean
                local var4 = GetLegacyNavigationStore(false).getCurrentRoute(arg1)
                local var5 = if var4 then var4.routeName else AppPage.Home
                local var6 = Signals2.getCacheStore().getHomePageDataSource(arg1)
                return var5 == AppPage.Home and var6 == "Cache"
            end)
        end, {})
        var3 = SignalsReact.useSignalState(var4)
    else
        local var4 = useSelector(selectCurrentRoactNavigationRoute)
        if var4 then
            var2 = var4.routeName
        else
            var2 = AppPage.Home
        end
    end
    local var4 = useRoactService(RoactNetworking)
    local var5 = useRoactService(AppOmniRecommendationsRequest)
    local var6 = useRoactService(AppLogging)

    local var7 = if FFlagUseSignalsForStartup then SignalsReact.useSignalState(GetStartupStore(false).getHomePageDataStatus) else useSelector(function(arg1)
        return arg1.Startup.HomePageDataStatus
    end)

    local var8 = SignalsReact.useSignalState(Signals2.getCacheStore().getHomePageDataSource)
    local var9

    if FFlagSignalsNavP3fGameDetails then
        var9 = var3 and var7 == RetrievalStatus.Done
    else
        local home = AppPage.Home

        if var2 == home and var7 == RetrievalStatus.Done then
            var9 = var8 == "Cache"
        else
            var9 = false
        end
    end
    local useCallback = React.useCallback
    local function func3()
        local bool1

        if FFlagSignalsNavP3fGameDetails then
            local var10 = GetLegacyNavigationStore(false).getCurrentRoute(false)

            bool1 = (if var10 then var10.routeName else AppPage.Home) == AppPage.Home
        else
            bool1 = var2 == AppPage.Home
        end
        if not bool1 then
            DiscoveryEventErrorLogger.reportError("ClientCacheFallbackBannerRefreshError", "Current page is not the home page")

            return Promise.reject()
        end

        if not FFlagLuaAppEnableSduiHomePage then
            return var1(func1(var4, var5, AppPage.Home, nil, nil, OmniFeedConstants.OmniRecommendationsRequestIntent.ManualRefresh, var6)):catch(
                function(arg1)
                    DiscoveryEventErrorLogger.reportError("ClientCacheFallbackBannerRefreshError", "Error refreshing omni recommendations")

                    return Promise.reject(arg1)
                end
            )
        end

        local var10 = func2()
        if var10 then
            return var10:catch(function(arg1)
                DiscoveryEventErrorLogger.reportError("ClientCacheFallbackBannerRefreshError", "Error refreshing SDUI home page")

                return Promise.reject(arg1)
            end)
        end
        return Promise.resolve()
    end

    local var10 = var2
    local var11 = if FFlagLuaAppEnableSduiHomePage then func1 else nil
    local var12 = if FFlagLuaAppEnableSduiHomePage then func2 else nil
    return {
        shouldShowBanner = var9,
        onRefreshButtonClick = useCallback(func3, { var1, var4, var5, var6, var10, var11, var12 })
    }
end

return useClientCacheFallbackBannerConfig
