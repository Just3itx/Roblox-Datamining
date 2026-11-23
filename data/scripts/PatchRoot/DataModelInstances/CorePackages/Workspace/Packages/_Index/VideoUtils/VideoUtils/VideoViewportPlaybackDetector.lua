-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T04:11:32Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExperienceService = game:GetService("ExperienceService")
local AppLifecycleObserverService = game:GetService("AppLifecycleObserverService")
local VideoUtils = script:FindFirstAncestor("VideoUtils")

local VideoUtilsParent = VideoUtils.Parent
local React = require(VideoUtilsParent.React)
local Signals = require(VideoUtilsParent.Signals)
local SignalsReact = require(VideoUtilsParent.SignalsReact)
local useSelector = require(VideoUtilsParent.RoactUtils).Hooks.RoactRodux.useSelector
local useNavigationFocus = require(VideoUtilsParent.Navigation).useNavigationFocus

local VideoEndReason = require(VideoUtils.Analytics.Enums).VideoEndReason
local _VideoPlaybackCoordinator = require(VideoUtils.VideoPlaybackCoordinator)
local _ViewportVideoAutoplayController = require(VideoUtils.ViewportVideoAutoplayController)
local useTargetedWinner = require(VideoUtils.useTargetedWinner)

local FFlagLuaAppOneByTwoHoverIdleAutoplay = require(VideoUtilsParent.SharedFlags).FFlagLuaAppOneByTwoHoverIdleAutoplay
local FFlagLuaAppEdpMediaGalleryFullScreen = require(VideoUtilsParent.SharedFlags).FFlagLuaAppEdpMediaGalleryFullScreen

local FFlagLuaAppVideoAutoplayOneByTwoConcurrentPlayback = require(VideoUtilsParent.SharedFlags).FFlagLuaAppVideoAutoplayOneByTwoConcurrentPlayback

local FIntVideoPlaybackDetectorScanDebounceInMilliseconds = require(VideoUtilsParent.SharedFlags).FIntVideoPlaybackDetectorScanDebounceInMilliseconds
local FFlagEnableOnScreenAPIIntegration = require(VideoUtilsParent.SharedFlags).FFlagEnableOnScreenAPIIntegration
local useIsRouteOnScreen = if FFlagEnableOnScreenAPIIntegration then require(VideoUtilsParent.RobloxAppNavigation).useIsRouteOnScreen else nil
local FFlagLuaAppVideoViewportTargetedWinnerSubscription = require(VideoUtilsParent.SharedFlags).FFlagLuaAppVideoViewportTargetedWinnerSubscription

local tbl1 = {
    instance = nil,
    shouldUseDwell = true,
    isUserIntentWinner = not FFlagLuaAppOneByTwoHoverIdleAutoplay and nil
}
local signal = Signals.createSignal(tbl1)

local var1 = FIntVideoPlaybackDetectorScanDebounceInMilliseconds / 1000

local function VideoViewportPlaybackDetector(tbl2)
    local var2 = if FFlagEnableOnScreenAPIIntegration then useIsRouteOnScreen() else useNavigationFocus()

    local var3 = useSelector(function(arg1)
        return arg1.ScreenSize
    end)

    local y = useSelector(function(arg1)
        return arg1.TopBar.topBarHeight
    end)

    local var4 = useSelector(function(arg1)
        return arg1.GlobalGuiInset
    end)

    local var5 = React.useMemo(function()
        return {
            min = Vector2.new(0, y),
            max = Vector2.new(var3.X, var3.Y - var4.bottom)
        }
    end, { y, var3, var4 })

    local bool1 = if FFlagLuaAppVideoAutoplayOneByTwoConcurrentPlayback then not (tbl2.viewportVideoAutoplayController == nil)
        and tbl2.viewportVideoAutoplayController:getAdsPlaybackCoordinator() == tbl2.videoPlaybackCoordinator else nil

    if FFlagLuaAppVideoViewportTargetedWinnerSubscription then
        useTargetedWinner(tbl2, var2, bool1)
    end

    local var6 = SignalsReact.useSignalState(
        if FFlagLuaAppVideoAutoplayOneByTwoConcurrentPlayback
            and tbl2.viewportVideoAutoplayController
            and not FFlagLuaAppVideoViewportTargetedWinnerSubscription then tbl2.viewportVideoAutoplayController:getWinnerStateForCoordinator(tbl2.videoPlaybackCoordinator) elseif tbl2.viewportVideoAutoplayController and not FFlagLuaAppVideoViewportTargetedWinnerSubscription then tbl2.viewportVideoAutoplayController.getWinnerState else signal
    )

    if FFlagLuaAppOneByTwoHoverIdleAutoplay then
        React.useEffect(function()
            local viewportVideoAutoplayController = tbl2.viewportVideoAutoplayController
            local current = tbl2.itemFrameRef.current
            if viewportVideoAutoplayController and viewportVideoAutoplayController:isUserIntentWithSelectiveAutoplay() and current then
                viewportVideoAutoplayController:setCandidateUserIntent(current, tbl2.hasVideoPlaybackUserIntent == true)

                return function()
                    viewportVideoAutoplayController:setCandidateUserIntent(current, false)
                end
            end
        end, { tbl2.viewportVideoAutoplayController, tbl2.itemFrameRef, tbl2.hasVideoPlaybackUserIntent })
    end

    local useEffect = React.useEffect
    local function func1()
        local viewportVideoAutoplayController = tbl2.viewportVideoAutoplayController
        if FFlagLuaAppVideoViewportTargetedWinnerSubscription or not viewportVideoAutoplayController then
            return
        end

        local current = tbl2.itemFrameRef.current

        if current == nil or var6.instance ~= current then
            if FFlagLuaAppOneByTwoHoverIdleAutoplay
                and viewportVideoAutoplayController:isUserIntentWithSelectiveAutoplay()
                and tbl2.videoPlaybackCoordinator.playingVideoKey == tbl2.videoKey
            then
                tbl2.cancelVideoPlayback(VideoEndReason.ExitViewport)
            end
            return
        end

        if not tbl2.videoPlaybackCoordinator:isPlaybackAllowed(
            var2,
            if FFlagLuaAppEdpMediaGalleryFullScreen then tbl2.isItemOccluded else nil
        ) then
            tbl2.cancelVideoPlayback(VideoEndReason.ExitViewport)
            return
        end

        if FFlagLuaAppVideoAutoplayOneByTwoConcurrentPlayback and bool1 then
            tbl2.requestVideoPlayback(var6.shouldUseDwell)
        elseif FFlagLuaAppOneByTwoHoverIdleAutoplay then
            viewportVideoAutoplayController:requestWinnerPlayback(current, tbl2.requestVideoPlayback)
        else
            tbl2.requestVideoPlayback(var6.shouldUseDwell)
        end
    end

    local viewportVideoAutoplayController = tbl2.viewportVideoAutoplayController
    local itemFrameRef = tbl2.itemFrameRef
    local requestVideoPlayback = tbl2.requestVideoPlayback
    local cancelVideoPlayback = tbl2.cancelVideoPlayback
    local videoPlaybackCoordinator = tbl2.videoPlaybackCoordinator
    local var7 = if FFlagLuaAppVideoAutoplayOneByTwoConcurrentPlayback then bool1 else nil
    local videoKey = if FFlagLuaAppOneByTwoHoverIdleAutoplay then tbl2.videoKey else nil
    local isItemOccluded = if FFlagLuaAppEdpMediaGalleryFullScreen then tbl2.isItemOccluded else nil
    useEffect(func1, {
        viewportVideoAutoplayController,
        itemFrameRef,
        requestVideoPlayback,
        cancelVideoPlayback,
        videoPlaybackCoordinator,
        var7,
        videoKey,
        var2,
        var6,
        isItemOccluded
    })

    React.useEffect(function()
        local viewportVideoAutoplayController2 = tbl2.viewportVideoAutoplayController
        if not viewportVideoAutoplayController2 then
            return
        end

        local connection = AppLifecycleObserverService.OnUnhide:Connect(function()
            viewportVideoAutoplayController2:scheduleUpdateWinner("Y", nil, true)
        end)

        local connection2 = ExperienceService:RegisterForExperienceLeave(function()
            viewportVideoAutoplayController2:scheduleUpdateWinner("Y", nil, true)
        end)

        return function()
            connection:Disconnect()
            connection2:Disconnect()
        end
    end, { tbl2.viewportVideoAutoplayController })

    React.useEffect(function()
        if tbl2.viewportVideoAutoplayController ~= nil then
            return
        end

        local tbl3 = {}
        local var8 = nil

        if tbl2.itemFrameRef.current ~= nil then
            local current = tbl2.itemFrameRef.current
            local var9 = nil
            local var10 = nil

            local function requestPlaybackIfEligible()
                var9 = tick()

                if tbl2.videoPlaybackCoordinator:isPlaybackCandidate(
                    var2,
                    if FFlagLuaAppEdpMediaGalleryFullScreen then tbl2.isItemOccluded else nil,
                    tbl2.itemFrameRef,
                    var5,
                    tbl2.videoVisiblePercent
                ) then
                    tbl2.requestVideoPlayback(true)
                    return
                end
                tbl2.cancelVideoPlayback(VideoEndReason.ExitViewport)
            end

            local function onItemFrameLayoutChange()
                if var10 ~= nil then
                    return
                end

                local var11

                if var9 == nil then
                    var11 = 0
                else
                    var10 = var9 + var1
                    var11 = var10 - tick()
                end

                if var11 > 0 then
                    var8 = task.delay(var11, function()
                        var10 = nil
                        requestPlaybackIfEligible()
                    end)

                    return
                end
                var10 = nil
                requestPlaybackIfEligible()
            end

            requestPlaybackIfEligible()

            local connection = AppLifecycleObserverService.OnUnhide:Connect(function()
                requestPlaybackIfEligible()
            end)

            local connection2 = ExperienceService:RegisterForExperienceLeave(function()
                requestPlaybackIfEligible()
            end)

            tbl3 = { current:GetPropertyChangedSignal("AbsolutePosition"):Connect(onItemFrameLayoutChange), current:GetPropertyChangedSignal("AbsoluteSize"):Connect(onItemFrameLayoutChange) }

            table.insert(tbl3, connection)
            table.insert(tbl3, connection2)
        end

        return function()
            if var8 then
                task.cancel(var8)
                var8 = nil
            end

            for _, value in tbl3 do
                value:Disconnect()
            end
        end
    end, {
        if FFlagLuaAppEdpMediaGalleryFullScreen then tbl2.isItemOccluded else nil,
        tbl2.itemFrameRef,
        tbl2.videoVisiblePercent,
        var2,
        var5,
        tbl2.videoPlaybackCoordinator,
        tbl2.requestVideoPlayback,
        tbl2.cancelVideoPlayback,
        tbl2.viewportVideoAutoplayController
    })

    return nil
end

return VideoViewportPlaybackDetector
