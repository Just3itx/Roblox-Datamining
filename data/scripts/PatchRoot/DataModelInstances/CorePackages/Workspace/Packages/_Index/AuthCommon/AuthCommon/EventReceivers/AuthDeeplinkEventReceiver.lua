-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T00:30:37Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AuthCommon = script:FindFirstAncestor("AuthCommon")
local AuthCommonParent = AuthCommon.Parent

local React = require(AuthCommonParent.React)
local useSignalState = require(AuthCommonParent.SignalsReact).useSignalState
local useRoactService = require(AuthCommonParent.RobloxAppHooks).useRoactService
local useSelector = require(AuthCommonParent.RoactUtils).Hooks.RoactRodux.useSelector
local useDispatch = require(AuthCommonParent.RoactUtils).Hooks.RoactRodux.useDispatch
local useAppPolicy = require(AuthCommonParent.UniversalAppPolicy).useAppPolicy

local RoactServiceTags = require(AuthCommonParent.RoactServiceTags)
local RoactNetworking = RoactServiceTags.RoactNetworking
local RoactAnalytics = RoactServiceTags.RoactAnalytics
local AppLinking = RoactServiceTags.AppLinking
local AppOmniRecommendationsRequest = RoactServiceTags.AppOmniRecommendationsRequest

local DeepLink = require(AuthCommonParent.DeepLink)
local LoginStatus = require(AuthCommonParent.RobloxAppEnums).LoginStatus
local RetrievalStatus = require(AuthCommonParent.Http).Enum.RetrievalStatus

local useEffect = React.useEffect
local useCallback = React.useCallback
local useState = React.useState

local SharedFlags = require(AuthCommonParent.SharedFlags)
local FFlagEnableDeepLinkHistoryWithModalAPI = SharedFlags.FFlagEnableDeepLinkHistoryWithModalAPI
local FFlagUseSignalsForAuthenticationStatus = SharedFlags.FFlagUseSignalsForAuthenticationStatus
local GetAuthenticationStatusStore = if FFlagUseSignalsForAuthenticationStatus then require(AuthCommonParent.AuthenticationStatus).GetAuthenticationStatusStore else nil
local FFlagUseSignalsForStartup = SharedFlags.FFlagUseSignalsForStartup
local GetStartupStore = if FFlagUseSignalsForStartup then require(AuthCommonParent.StartupStore).GetStartupStore else nil
local PostAuthDeepLinkAvailableSignal = require(script.Parent.PostAuthDeepLinkAvailableSignal)
local PostAuthPendingLuaUrlAvailableSignal = require(script.Parent.PostAuthPendingLuaUrlAvailableSignal)
local PreAuthDeepLinkHandler = require(script.Parent.PreAuthDeepLinkHandler)

local PreAuthDeepLinkUrlStore = require(AuthCommon.Stores).PreAuthDeepLinkUrlStore

local FFlagEnablePreAuthDeepLinkHandler = require(AuthCommon.Flags.FFlagEnablePreAuthDeepLinkHandler)

return function(arg1)
    local var1 = useRoactService(AppLinking)

    local monoDeps = arg1.monoDeps
    local launchApp = monoDeps.LaunchApp
    local resetAppState = monoDeps.ResetAppState

    local tbl1 = {
        networking = useRoactService(RoactNetworking),
        launchApp = launchApp,
        dispatch = useDispatch(),
        omniRecommendationsRequest = useRoactService(AppOmniRecommendationsRequest),
        analytics = useRoactService(RoactAnalytics),
        appPolicy = useAppPolicy(function<T>(arg2: T): T
            return arg2
        end),
        resetAppState = resetAppState
    }

    local var2, var3 = useState({ url = nil, attributionUrl = nil })

    local var4, var5 = useState({ hasPendingUrl = false, attributionUrl = nil, url = nil })

    local bool1 = if FFlagUseSignalsForAuthenticationStatus then useSignalState(GetAuthenticationStatusStore(false).getStatus) == LoginStatus.LOGGED_OUT else useSelector(function(arg2): boolean
        return arg2.AuthenticationStatus.status == LoginStatus.LOGGED_OUT
    end)

    local var6 = if FFlagUseSignalsForStartup then useSignalState(GetStartupStore(false).getAppLoadingStarted) else useSelector(function(arg2): boolean
        return arg2.Startup.AppDataStatus ~= RetrievalStatus.NotStarted
    end)

    local var7 = if FFlagEnableDeepLinkHistoryWithModalAPI then DeepLink.DeepLinkLuaReceiverStatusStore(false) else nil

    local var8 = useCallback(function()
        if not var1 then
            return
        end

        local var8 = not bool1 and var6

        if var8 then
            PreAuthDeepLinkUrlStore.setUrl(nil)

            if FFlagEnableDeepLinkHistoryWithModalAPI then
                var7.setDeepLinkLuaPostAuthReceiverStatus(DeepLink.DeepLinkLuaPostAuthReceiverStatus.Ready, var2 and var2.url)
            end

            if var2 and var2.url then
                PostAuthDeepLinkAvailableSignal:fire(var2)

                var3({ url = nil, attributionUrl = nil })
            end

            if var4 and var4.hasPendingUrl then
                PostAuthPendingLuaUrlAvailableSignal:fire(var4)
                var5({ hasPendingUrl = false, attributionUrl = nil, url = nil })
            end
        elseif FFlagEnableDeepLinkHistoryWithModalAPI then
            var7.setDeepLinkLuaPostAuthReceiverStatus(DeepLink.DeepLinkLuaPostAuthReceiverStatus.Disconnected, nil)
        end

        var1:getAndClearLastPendingURL():andThen(function(tbl2)
            if not (tbl2 and tbl2.hasPendingUrl) then
                return
            end

            if not var8 then
                PreAuthDeepLinkUrlStore.setUrl(tbl2.url)
                var5(tbl2)
            else
                PostAuthPendingLuaUrlAvailableSignal:fire(tbl2)
            end
        end)

        var1:listenForLuaURLs(function(url, attributionUrl)
            if FFlagEnablePreAuthDeepLinkHandler and PreAuthDeepLinkHandler.isPreauthDeeplink(url) then
                PreAuthDeepLinkHandler.firePreauthDeeplink(url, tbl1)
                return
            end

            if not var8 then
                PreAuthDeepLinkUrlStore.setUrl(url)
                var3({ url = url, attributionUrl = attributionUrl })
            else
                PostAuthDeepLinkAvailableSignal:fire({ url = url, attributionUrl = attributionUrl })
            end
        end)
    end, {
        var1,
        bool1,
        var6,
        PostAuthDeepLinkAvailableSignal,
        var2,
        var4
    })

    useEffect(function()
        var8()

        return function()
            if var1 then
                var1:stopListeningForLuaURLs()
            end
        end
    end, { var8 })
    return nil
end
