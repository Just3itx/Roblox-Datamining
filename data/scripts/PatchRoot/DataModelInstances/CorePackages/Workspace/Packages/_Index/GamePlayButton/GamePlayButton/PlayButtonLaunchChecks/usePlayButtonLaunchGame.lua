-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T20:51:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GamePlayButton = script:FindFirstAncestor("GamePlayButton")
local _PlayButtonTypes = require(GamePlayButton.PlayButtonTypes)

local GamePlayButtonParent = GamePlayButton.Parent
local React = require(GamePlayButtonParent.React)
local useRoactService = require(GamePlayButtonParent.RobloxAppHooks).useRoactService
local RoactServiceTags = require(GamePlayButtonParent.RoactServiceTags)
local RoactAnalytics = RoactServiceTags.RoactAnalytics
local AppEventIngestService = RoactServiceTags.AppEventIngestService
local AppGame = RoactServiceTags.AppGame
local RoactUtils = require(GamePlayButtonParent.RoactUtils)
local useSelector = RoactUtils.Hooks.RoactRodux.useSelector
local useDispatch = RoactUtils.Hooks.RoactRodux.useDispatch
local DiscoveryAnalytics = require(GamePlayButtonParent.DiscoveryAnalytics)
local gamePlayIntent = DiscoveryAnalytics.Events.gamePlayIntent
local joinGamePlayButton = DiscoveryAnalytics.Points.joinGamePlayButton
local GameVotesRodux = require(GamePlayButtonParent.GameVotesRodux)
local ReasonForNotVoteable = GameVotesRodux.Enums.ReasonForNotVoteable
local ClearUserGameVotes = GameVotesRodux.UserGameVotes.ClearUserGameVotes
local IsVRAppBuild = require(GamePlayButtonParent.AppCommonLib).IsVRAppBuild
local SplashScreenManager = require(GamePlayButtonParent.SplashScreenManager).SplashScreenManager
local LaunchGame = require(GamePlayButtonParent.GameLaunch).LaunchGame
local FFlagDeferInExperienceRbxmDownload = require(GamePlayButtonParent.SharedFlags).FFlagDeferInExperienceRbxmDownload
local Dash = require(GamePlayButtonParent.Dash)

local GetFFlagLuaAppEnableVirtualEventPlaceId = require(GamePlayButtonParent.SharedFlags).GetFFlagLuaAppEnableVirtualEventPlaceId

local FFlagLuaAppEnableStratusStreamingTestOnly = require(GamePlayButtonParent.SharedFlags).FFlagLuaAppEnableStratusStreamingTestOnly
local FFlagLuaAppStratusPassUniverseId = require(GamePlayButtonParent.SharedFlags).FFlagLuaAppStratusPassUniverseId

local NavigateToRoute = require(GamePlayButtonParent.NavigationRodux).Thunks.NavigateToRoute
local AppPage = require(GamePlayButtonParent.RobloxAppEnums).AppPage
local FFlagSignalsNavP3Dispatch = require(GamePlayButtonParent.SharedFlags).FFlagSignalsNavP3Dispatch
local NavigationCommands = if FFlagSignalsNavP3Dispatch then require(GamePlayButtonParent.RobloxAppNavigation).NavigationCommands else nil
local FFlagLuaAppEnablePlayButtonThrottle = require(GamePlayButtonParent.SharedFlags).FFlagLuaAppEnablePlayButtonThrottle
local FIntLuaAppPlayButtonThrottleTimeSeconds = require(GamePlayButtonParent.SharedFlags).FIntLuaAppPlayButtonThrottleTimeSeconds
local FFlagLuaAppFixLaunchGameSourceParam = require(GamePlayButtonParent.SharedFlags).FFlagLuaAppFixLaunchGameSourceParam
local FFlagLuaAppEnableStratusStreamingCheck = require(GamePlayButtonParent.SharedFlags).FFlagLuaAppEnableStratusStreamingCheck
local FFlagLuaAppDemoModePlayButtonTelemetry = require(GamePlayButtonParent.SharedFlags).FFlagLuaAppDemoModePlayButtonTelemetry
local FFlagLuaAppCloudClientPlayButtonOffer = require(GamePlayButtonParent.SharedFlags).FFlagLuaAppCloudClientPlayButtonOffer

local VideoService = game:GetService("VideoService")

return function(universeId, arg2, arg3, referralSource, ctx, launchSource, extraParams)
    local var1 = useRoactService(RoactAnalytics)
    local var2 = useRoactService(AppEventIngestService)
    local var3 = useRoactService(AppGame)

    local var4 = useSelector(function(arg6)
        return arg6.UserGameVotes[universeId]
    end)
    local var5 = useDispatch()
    local var6 = if FFlagLuaAppEnablePlayButtonThrottle then React.useRef(0) else nil
    local useCallback = React.useCallback
    local function func1(callback: ((...any) -> (...any))?, actionType: string?, arg6)
        if FFlagLuaAppEnablePlayButtonThrottle then
            local current = tick()
            if current - var6.current < FIntLuaAppPlayButtonThrottleTimeSeconds then
                return
            end
            var6.current = current
        end

        if GetFFlagLuaAppEnableVirtualEventPlaceId() and not (arg2 and arg3)
            or not (GetFFlagLuaAppEnableVirtualEventPlaceId() or arg3)
        then
            return
        end

        if callback == nil then
            gamePlayIntent(var2, "PlayButton", {
                placeId = if GetFFlagLuaAppEnableVirtualEventPlaceId() then arg2 else arg3,
                rootPlaceId = tonumber(arg3),
                referralSource = referralSource,
                universeId = universeId,
                launchData = if extraParams and extraParams.launchData then extraParams.launchData else nil,
                tileType = if extraParams then extraParams.tileType else nil,
                nativeAdData = if extraParams then extraParams.nativeAdData else nil,
                actionType = if FFlagLuaAppDemoModePlayButtonTelemetry then actionType else nil
            })
        elseif FFlagLuaAppDemoModePlayButtonTelemetry then
            callback(actionType)
        else
            callback()
        end

        local var7 = joinGamePlayButton
        local influxDb = var1.InfluxDb
        local str2 = "gamePlayIntent"
        local tbl2 = {
            isUniversalApp = true,
            referralSource = referralSource,
            placeId = if GetFFlagLuaAppEnableVirtualEventPlaceId() then arg2 else arg3,
            ctx = ctx,
            actionType = 0
        }

        if not FFlagLuaAppDemoModePlayButtonTelemetry then
            actionType = nil
        end

        tbl2.actionType = actionType
        var7(influxDb, str2, tbl2)
        local cloudClientReservation = if FFlagLuaAppCloudClientPlayButtonOffer and arg6 then arg6.cloudClientReservation else nil

        if cloudClientReservation ~= nil then
            local tbl3 = {{
                name = AppPage.VideoServer,
                placeId = if GetFFlagLuaAppEnableVirtualEventPlaceId() then arg2 else arg3,
                universeId = if FFlagLuaAppStratusPassUniverseId then universeId else nil,
                launchSource = launchSource,
                extraParams = extraParams,
                reservationToken = cloudClientReservation.reservationToken,
                offerKind = cloudClientReservation.offerKind
            }}

            if FFlagSignalsNavP3Dispatch then
                NavigationCommands.to(NavigationCommands.fromLegacyPage(tbl3[#tbl3]))
                return
            end
            var5(NavigateToRoute(tbl3))

            return
        end

        if FFlagLuaAppEnableStratusStreamingTestOnly then
            if not FFlagLuaAppEnableStratusStreamingCheck then
                local tbl3 = {{
                    name = AppPage.VideoServer,
                    placeId = if GetFFlagLuaAppEnableVirtualEventPlaceId() then arg2 else arg3,
                    universeId = if FFlagLuaAppStratusPassUniverseId then universeId else nil,
                    launchSource = launchSource,
                    extraParams = extraParams
                }}

                if FFlagSignalsNavP3Dispatch then
                    NavigationCommands.to(NavigationCommands.fromLegacyPage(tbl3[#tbl3]))
                    return
                end
                var5(NavigateToRoute(tbl3))

                return
            end

            if VideoService:GameStreamingEnabled() then
                local tbl3 = {{
                    name = AppPage.VideoServer,
                    placeId = if GetFFlagLuaAppEnableVirtualEventPlaceId() then arg2 else arg3,
                    universeId = if FFlagLuaAppStratusPassUniverseId then universeId else nil,
                    launchSource = launchSource,
                    extraParams = extraParams
                }}

                if FFlagSignalsNavP3Dispatch then
                    NavigationCommands.to(NavigationCommands.fromLegacyPage(tbl3[#tbl3]))
                    return
                end
                var5(NavigateToRoute(tbl3))

                return
            end
        end

        if IsVRAppBuild() then
            SplashScreenManager.initialize(36)
            wait(0.3)
        end

        if FFlagDeferInExperienceRbxmDownload then
            extraParams = Dash.join(extraParams or {}, { universeId = universeId })
        end

        if FFlagLuaAppFixLaunchGameSourceParam then
            LaunchGame(
                if GetFFlagLuaAppEnableVirtualEventPlaceId() then arg2 else arg3,
                referralSource,
                extraParams,
                var3,
                launchSource
            )
        else
            LaunchGame(if GetFFlagLuaAppEnableVirtualEventPlaceId() then arg2 else arg3, launchSource, extraParams, var3)
        end

        if var4 and var4.reasonForNotVoteable == ReasonForNotVoteable.PlayGame then
            var5(ClearUserGameVotes(universeId))
        end
    end

    local var7 = if GetFFlagLuaAppEnableVirtualEventPlaceId() then arg2 else nil
    local var8 = extraParams
    local var9 = if FFlagLuaAppDemoModePlayButtonTelemetry then var5 else nil
    local var10 = if FFlagLuaAppDemoModePlayButtonTelemetry then launchSource else nil
    return (useCallback(func1, { var2, var1, var3, var4, universeId, var7, arg3, referralSource, ctx, var8, var9, var10 }))
end
