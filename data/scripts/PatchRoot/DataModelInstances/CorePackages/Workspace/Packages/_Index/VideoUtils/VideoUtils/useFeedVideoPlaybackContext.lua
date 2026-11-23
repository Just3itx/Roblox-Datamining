-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T04:11:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExperienceService = game:GetService("ExperienceService")
local AppLifecycleObserverService = game:GetService("AppLifecycleObserverService")

local VideoUtils = script:FindFirstAncestor("VideoUtils")
local VideoUtilsParent = VideoUtils.Parent

local React = require(VideoUtilsParent.React)
local Responsive = require(VideoUtilsParent.Responsive)
local useNavigationFocus = require(VideoUtilsParent.Navigation).useNavigationFocus

local VideoEndReason = require(VideoUtils.Analytics.Enums).VideoEndReason
local FeedVideoPlaybackContext = require(script.Parent.FeedVideoPlaybackContext)
local _VideoPlaybackDetectionMethod = require(script.Parent.VideoPlaybackDetectionMethod)

local FFlagLuaAppSearchResultsPageGameTileVideo = require(VideoUtilsParent.SharedFlags).FFlagLuaAppSearchResultsPageGameTileVideo

local FFlagLuaAppSuppressVideoDetectorDuringScroll = require(VideoUtilsParent.SharedFlags).FFlagLuaAppSuppressVideoDetectorDuringScroll
local FFlagLuaAppVideoAutoplayFeedElection = require(VideoUtilsParent.SharedFlags).FFlagLuaAppVideoAutoplayFeedElection
local FFlagLuaAppOneByTwoHoverIdleAutoplay = require(VideoUtilsParent.SharedFlags).FFlagLuaAppOneByTwoHoverIdleAutoplay
local FFlagEnableOnScreenAPIIntegration = require(VideoUtilsParent.SharedFlags).FFlagEnableOnScreenAPIIntegration
local useIsRouteOnScreen = if FFlagEnableOnScreenAPIIntegration then require(VideoUtilsParent.RobloxAppNavigation).useIsRouteOnScreen else nil

local function useFeedVideoPlaybackContext(bool1: boolean?, bool2: boolean?, bool3: boolean?, bool4: boolean?, arg1)
    local var1 = if FFlagEnableOnScreenAPIIntegration then useIsRouteOnScreen() else useNavigationFocus()
    local bool5 = if FFlagLuaAppSuppressVideoDetectorDuringScroll then Responsive.usePreferredInput() == Responsive.Input.Touch else nil
    local var2 = nil
    local var3 = nil
    if FFlagLuaAppSuppressVideoDetectorDuringScroll then
        local var4
        var2, var4 = React.useState(false)
        var3 = var4
    end
    local bool6 = if FFlagLuaAppSearchResultsPageGameTileVideo and bool2 == true then true else not var1

    local var4 = FFlagLuaAppSuppressVideoDetectorDuringScroll and var2 == true

    local var5 = React.useMemo(function()
        return FeedVideoPlaybackContext.new(
            if FFlagLuaAppOneByTwoHoverIdleAutoplay then nil else bool1,
            if FFlagLuaAppVideoAutoplayFeedElection then bool3 else nil,
            if FFlagLuaAppVideoAutoplayFeedElection then bool4 else nil,
            if FFlagLuaAppOneByTwoHoverIdleAutoplay then arg1 else nil
        )
    end, { if FFlagLuaAppOneByTwoHoverIdleAutoplay then arg1 else bool1, if FFlagLuaAppVideoAutoplayFeedElection then bool3 else nil, if FFlagLuaAppVideoAutoplayFeedElection then bool4 else nil })

    local useMemo = React.useMemo
    local function func1()
        if not (bool6 or FFlagLuaAppSuppressVideoDetectorDuringScroll and var4) then
            return var5
        end

        return (setmetatable({
            videoPlaybackCoordinator = var5.videoPlaybackCoordinator,
            viewportVideoAutoplayController = var5.viewportVideoAutoplayController,
            disablePlayback = if not FFlagLuaAppSuppressVideoDetectorDuringScroll or bool6 then true else nil,
            disableDetectors = if FFlagLuaAppSuppressVideoDetectorDuringScroll and var4 then true else nil
        }, FeedVideoPlaybackContext))
    end

    local var6 = if FFlagLuaAppSuppressVideoDetectorDuringScroll then var4 else nil
    local var7 = useMemo(func1, { var5, bool6, var6 })

    if FFlagLuaAppOneByTwoHoverIdleAutoplay then
        React.useEffect(function()
            local viewportVideoAutoplayController = var5.viewportVideoAutoplayController
            if var1 and viewportVideoAutoplayController and viewportVideoAutoplayController:isUserIntentWithSelectiveAutoplay() then
                viewportVideoAutoplayController:scheduleUpdateWinner("Y", nil, true)
            end
        end, { var5.viewportVideoAutoplayController, var1 })
    end

    local var8 = React.useCallback(function()
        if var7.viewportVideoAutoplayController then
            if FFlagLuaAppSuppressVideoDetectorDuringScroll then
                var7.viewportVideoAutoplayController:setSuppressDetectorsDuringScroll(bool5 == true)
            end

            var7.viewportVideoAutoplayController:onScrollStart()
        end
        if FFlagLuaAppSuppressVideoDetectorDuringScroll and bool5 and var3 then
            var3(true)
        end
    end, { var7.viewportVideoAutoplayController, if FFlagLuaAppSuppressVideoDetectorDuringScroll then bool5 else nil })

    local var9 = React.useCallback(function(num1: number)
        if FFlagLuaAppSuppressVideoDetectorDuringScroll and var3 then
            var3(false)
        end
        if var7.viewportVideoAutoplayController then
            var7.viewportVideoAutoplayController:onScrollSettled("Y", num1, nil)
        end
    end, { var7.viewportVideoAutoplayController })

    if FFlagLuaAppSuppressVideoDetectorDuringScroll then
        React.useEffect(function()
            local viewportVideoAutoplayController = var7.viewportVideoAutoplayController
            if not viewportVideoAutoplayController or not bool5 then
                return
            end

            local connection = AppLifecycleObserverService.OnHide:Connect(function()
                viewportVideoAutoplayController:reset(VideoEndReason.AppBackgrounded)
            end)
            local connection2 = ExperienceService:RegisterForExperienceJoin(function()
                viewportVideoAutoplayController:reset(VideoEndReason.ExperienceLaunched)
            end)

            return function()
                connection:Disconnect()
                connection2:Disconnect()
            end
        end, { var7.viewportVideoAutoplayController, bool5 })
    end

    return var7, var8, var9
end

return useFeedVideoPlaybackContext
