-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T23:41:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local EventIngestService = game:GetService("EventIngestService")
local HttpService = game:GetService("HttpService")
local SessionService = game:GetService("SessionService")

local React = require(CorePackages.Packages.React)
local Foundation = require(CorePackages.Packages.Foundation)
local Signals = require(CorePackages.Packages.Signals)
local Analytics = require(CorePackages.Workspace.Packages.Analytics).Analytics
local EventIngest = require(CorePackages.Workspace.Packages.Analytics).AnalyticsReporters.EventIngest
local requestInternalWrapper = require(CorePackages.Workspace.Packages.Http).NetworkLayers.requestInternalWrapper
local LinkingProtocol = require(CorePackages.Workspace.Packages.LinkingProtocol).LinkingProtocol
local LocalizationRoactContext = require(CorePackages.Workspace.Packages.Localization).LocalizationRoactContext
local ServiceProvider = require(CorePackages.Workspace.Packages.RoactServices).RoactServices.ServiceProvider
local RoactServiceTags = require(CorePackages.Workspace.Packages.RoactServiceTags)
local StoreContext = require(CorePackages.Packages.RoactRodux).StoreContext

local FeedbackManagerInjectionContext = require(CorePackages.Packages.UIBlox).Core.Control.FeedbackManagerInjectionContext
local GetAppPolicyStore = require(CorePackages.Workspace.Packages.UniversalAppPolicy).GetAppPolicyStore

local SduiCoreSystem = require(CorePackages.Workspace.Packages.SduiCoreSystem)
local SduiInstrumentation = SduiCoreSystem.SduiInstrumentation
local SduiLogger = SduiCoreSystem.SduiLogger

local var1 = nil

local function getServices()
    if var1 == nil then
        var1 = {
            appAnalytics = Analytics.new(),
            eventIngest = EventIngest.new(EventIngestService),
            networking = requestInternalWrapper(HttpService),
            sessionService = SessionService
        }
    end
    return var1
end

local function reportRoduxUnavailable(arg1)
    SduiLogger.reportError(
        SduiCoreSystem.SduiErrors.SduiErrorType.RoduxUnavailable,
        {
            message = "Dispatched without a Rodux store",
            name = if typeof(arg1) == "table" then arg1.type else typeof(arg1)
        },
        "unknown"
    )
end

local function createUnavailableDependency(arg1, str1: string)
    return (setmetatable({}, {
        __index = function(_, arg2): () -> nil
            return function()
                SduiLogger.reportError(
                    arg1,
                    {
                        message = `{str1} is unavailable in experience`,
                        name = tostring(arg2)
                    },
                    "unknown"
                )
                return nil
            end
        end
    }))
end

local unavailableDependency = createUnavailableDependency(SduiCoreSystem.SduiErrors.SduiErrorType.NavigationUnavailable, "Navigation")

local gameAnalytics = createUnavailableDependency(SduiCoreSystem.SduiErrors.SduiErrorType.GameAnalyticsUnavailable, "GameAnalytics")

local function getNavigation()
    return unavailableDependency
end

local function useTriggerFeedback()
    local current = React.useContext(FeedbackManagerInjectionContext)
    local var3 = React.useRef(current)
    var3.current = current
    return React.useCallback(function(str1: string, arg1, str2: string?, tbl1)
        return var3.current(str1, arg1, str2, tbl1)
    end, { var3 })
end

local function useGlobalDependencies()
    local instrumentation = React.useMemo(function()
        return SduiInstrumentation.new()
    end, {})
    local localization = React.useContext(LocalizationRoactContext)
    local tileCursor = Foundation.Hooks.useCursor(Foundation.Enums.CursorType.RoundedRect)
    local triggerFeedback = useTriggerFeedback()

    return React.useMemo(function()
        local services = getServices()
        return {
            dispatch = reportRoduxUnavailable,
            getNavigation = getNavigation,
            appAnalytics = services.appAnalytics,
            gameAnalytics = gameAnalytics,
            eventIngest = services.eventIngest,
            sessionService = services.sessionService,
            linkingProtocol = LinkingProtocol.default,
            logger = SduiLogger,
            cursors = { tileCursor = tileCursor },
            instrumentation = instrumentation,
            localization = localization,
            networking = services.networking,
            triggerFeedback = triggerFeedback
        }
    end, {
        instrumentation,
        localization,
        tileCursor,
        triggerFeedback
    })
end

local function useScopedDependencies()
    local var2 = React.useContext(StoreContext)
    local dispatch = React.useCallback(function(arg1)
        if var2 then
            var2:dispatch(arg1)
            return
        end
        reportRoduxUnavailable(arg1)
    end, { var2 })

    return React.useMemo(function()
        return { dispatch = dispatch }
    end, { dispatch })
end

return React.memo(function(tbl1) -- name: SduiInExperienceHost
    local var2 = useGlobalDependencies()
    local var3 = useScopedDependencies()

    local var4, var5 = React.useState(false)
    React.useLayoutEffect(function()
        local sduiServiceDependenciesStore = SduiCoreSystem.getSduiServiceDependenciesStore()
        sduiServiceDependenciesStore.setDependencies(var2)
        local var6 = sduiServiceDependenciesStore.setScopedDependencies(tbl1.surfaceKey, var3)
        var5(true)
        return var6
    end, { var2, var3, tbl1.surfaceKey })

    local var6 = Foundation.Hooks.useTokens()
    React.useEffect(function()
        SduiCoreSystem.getSduiTokensStore().setTokens(var6)
    end, { var6 })

    React.useEffect(function()
        local getAppPolicy = GetAppPolicyStore(false).getAppPolicy
        return Signals.createEffect(function(arg1)
            SduiCoreSystem.getSduiPolicyStore().setAppPolicy(getAppPolicy(arg1))
        end)
    end, {})

    if not var4 then
        return nil
    end
    local services = getServices()

    return React.createElement(ServiceProvider, {
        services = {
            [RoactServiceTags.RoactNetworking] = services.networking,
            [RoactServiceTags.AppEventIngestService] = services.eventIngest,
            [RoactServiceTags.RoactAnalytics] = services.appAnalytics,
            [RoactServiceTags.AppSessionService] = services.sessionService
        }
    }, {
        Children = React.createElement(React.Fragment, nil, tbl1.children)
    })
end)
