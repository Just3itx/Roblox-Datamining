-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T04:11:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local VideoUtils = script:FindFirstAncestor("VideoUtils")
local VideoUtilsParent = VideoUtils.Parent

local React = require(VideoUtilsParent.React)
local Signals = require(VideoUtilsParent.Signals)
local SignalsReact = require(VideoUtilsParent.SignalsReact)

local VideoEndReason = require(VideoUtils.Analytics.Enums).VideoEndReason
local _VideoPlaybackCoordinator = require(VideoUtils.VideoPlaybackCoordinator)
local _ViewportVideoAutoplayController = require(VideoUtils.ViewportVideoAutoplayController)

local FFlagLuaAppEdpMediaGalleryFullScreen = require(VideoUtilsParent.SharedFlags).FFlagLuaAppEdpMediaGalleryFullScreen
local FFlagLuaAppOneByTwoHoverIdleAutoplay = require(VideoUtilsParent.SharedFlags).FFlagLuaAppOneByTwoHoverIdleAutoplay

local FFlagLuaAppVideoAutoplayOneByTwoConcurrentPlayback = require(VideoUtilsParent.SharedFlags).FFlagLuaAppVideoAutoplayOneByTwoConcurrentPlayback

local var1 = table.freeze({ isWinner = false, shouldUseDwell = false })
local signal = Signals.createSignal(var1)

local function verdictEquals(tbl1, tbl2): boolean
    return tbl1.isWinner == tbl2.isWinner
        and tbl1.shouldUseDwell == tbl2.shouldUseDwell
        and tbl1.isUserIntentWinner == tbl2.isUserIntentWinner
end

local function useTargetedWinner(tbl1, bool1: boolean, bool2: boolean)
    local var2 = React.useMemo(function()
        local get, set = Signals.createSignal(nil)
        return { get = get, set = set }
    end, {})

    React.useEffect(function()
        if var2.get(false) ~= tbl1.itemFrameRef.current then
            var2.set(tbl1.itemFrameRef.current)
        end
    end)

    local useMemo = React.useMemo
    local function func1()
        local viewportVideoAutoplayController = tbl1.viewportVideoAutoplayController
        if not viewportVideoAutoplayController then
            return signal
        end

        local var3 = if FFlagLuaAppVideoAutoplayOneByTwoConcurrentPlayback then viewportVideoAutoplayController:getWinnerStateForCoordinator(tbl1.videoPlaybackCoordinator) else viewportVideoAutoplayController.getWinnerState

        return Signals.createComputed(function(arg1)
            local var4 = var3(arg1)
            local var5 = var2.get(arg1)
            if var5 == nil or var4.instance ~= var5 then
                return var1
            end

            return {
                isWinner = true,
                shouldUseDwell = var4.shouldUseDwell,
                isUserIntentWinner = if FFlagLuaAppOneByTwoHoverIdleAutoplay then var4.isUserIntentWinner else nil
            }
        end, verdictEquals)
    end

    local viewportVideoAutoplayController = tbl1.viewportVideoAutoplayController
    local videoPlaybackCoordinator = if FFlagLuaAppVideoAutoplayOneByTwoConcurrentPlayback then tbl1.videoPlaybackCoordinator else nil
    local var3 = if FFlagLuaAppVideoAutoplayOneByTwoConcurrentPlayback then bool2 else nil
    local var4 = useMemo(func1, { viewportVideoAutoplayController, var2, videoPlaybackCoordinator, var3 })

    local var5 = SignalsReact.useSignalState(var4)

    local useEffect = React.useEffect
    local function func2()
        local viewportVideoAutoplayController2 = tbl1.viewportVideoAutoplayController
        if not viewportVideoAutoplayController2 then
            return
        end

        if not var5.isWinner then
            if FFlagLuaAppOneByTwoHoverIdleAutoplay
                and viewportVideoAutoplayController2:isUserIntentWithSelectiveAutoplay()
                and tbl1.videoPlaybackCoordinator.playingVideoKey == tbl1.videoKey
            then
                tbl1.cancelVideoPlayback(VideoEndReason.ExitViewport)
            end

            return
        end

        if not tbl1.videoPlaybackCoordinator:isPlaybackAllowed(
            bool1,
            if FFlagLuaAppEdpMediaGalleryFullScreen then tbl1.isItemOccluded else nil
        ) then
            tbl1.cancelVideoPlayback(VideoEndReason.ExitViewport)
        elseif FFlagLuaAppVideoAutoplayOneByTwoConcurrentPlayback and bool2 then
            tbl1.requestVideoPlayback(var5.shouldUseDwell)
        elseif FFlagLuaAppOneByTwoHoverIdleAutoplay then
            viewportVideoAutoplayController2:requestWinnerPlayback(var2.get(false), tbl1.requestVideoPlayback)
        else
            tbl1.requestVideoPlayback(var5.shouldUseDwell)
        end
    end

    local viewportVideoAutoplayController2 = tbl1.viewportVideoAutoplayController
    local videoPlaybackCoordinator2 = tbl1.videoPlaybackCoordinator
    local requestVideoPlayback = tbl1.requestVideoPlayback
    local cancelVideoPlayback = tbl1.cancelVideoPlayback
    local var6 = if FFlagLuaAppVideoAutoplayOneByTwoConcurrentPlayback then bool2 else nil
    local videoKey = if FFlagLuaAppOneByTwoHoverIdleAutoplay then tbl1.videoKey else nil
    local isItemOccluded = if FFlagLuaAppEdpMediaGalleryFullScreen then tbl1.isItemOccluded else nil
    useEffect(func2, {
        viewportVideoAutoplayController2,
        videoPlaybackCoordinator2,
        requestVideoPlayback,
        cancelVideoPlayback,
        var6,
        videoKey,
        var2,
        bool1,
        var5,
        isItemOccluded
    })
end

return useTargetedWinner
