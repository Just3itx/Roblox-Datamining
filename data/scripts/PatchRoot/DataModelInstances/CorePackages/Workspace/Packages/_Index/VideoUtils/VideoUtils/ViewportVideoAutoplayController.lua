-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T04:20:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CollectionService = game:GetService("CollectionService")

local VideoUtils = script:FindFirstAncestor("VideoUtils")
local VideoUtilsParent = VideoUtils.Parent

local Signals = require(VideoUtilsParent.Signals)
local DiscoveryEventErrorLogger = require(VideoUtilsParent.DiscoveryUtils).DiscoveryEventErrorLogger

local ViewportVideoAutoplayMode = require(VideoUtils.ViewportVideoAutoplayMode)
local ViewportAutoplayVideoKeyAttribute = require(VideoUtils.ViewportAutoplayVideoKeyAttribute)
local UserIntentModeAutoplayCandidateTag = require(VideoUtils.UserIntentModeAutoplayCandidateTag)
local _VideoPlaybackCoordinator = require(VideoUtils.VideoPlaybackCoordinator)
local VideoEndReason = require(VideoUtils.Analytics.Enums).VideoEndReason
local getIsInstanceVisible = require(VideoUtils.getIsInstanceVisible)
local ViewportAutoplayCandidateTag = require(VideoUtils.ViewportAutoplayCandidateTag)
local ViewportAutoplayHelpers = require(VideoUtils.ViewportAutoplayHelpers)
local getTileRowSpan = ViewportAutoplayHelpers.getTileRowSpan
local resolveOneByOneHeight = ViewportAutoplayHelpers.resolveOneByOneHeight
local getReadingOrderPositions = ViewportAutoplayHelpers.getReadingOrderPositions
local isTilePinnedLeft = ViewportAutoplayHelpers.isTilePinnedLeft
local computeRowAnchorOverrides = ViewportAutoplayHelpers.computeRowAnchorOverrides

local FIntLuaAppGameTileVideoVisiblePercent = require(VideoUtilsParent.SharedFlags).FIntLuaAppGameTileVideoVisiblePercent

local FIntLuaAppOneByTwoTileVideoVisiblePercent = require(VideoUtilsParent.SharedFlags).FIntLuaAppOneByTwoTileVideoVisiblePercent
local FFlagLuaAppOneByTwoHoverIdleAutoplay = require(VideoUtilsParent.SharedFlags).FFlagLuaAppOneByTwoHoverIdleAutoplay
local FFlagLuaAppHoverIdleAutoplayDuringScroll = require(VideoUtilsParent.SharedFlags).FFlagLuaAppHoverIdleAutoplayDuringScroll

local FFlagLuaAppSuppressVideoDetectorDuringScroll = require(VideoUtilsParent.SharedFlags).FFlagLuaAppSuppressVideoDetectorDuringScroll

local FFlagLuaAppSuppressOneByTwoVideoDetectorDuringScroll = require(VideoUtilsParent.SharedFlags).FFlagLuaAppSuppressOneByTwoVideoDetectorDuringScroll

local FFlagLuaAppSduiSuppressVideoDetectorDuringScroll = require(VideoUtilsParent.SharedFlags).FFlagLuaAppSduiSuppressVideoDetectorDuringScroll
local FFlagLuaAppTileVideoKeepPlayingOnScroll = require(VideoUtilsParent.SharedFlags).FFlagLuaAppTileVideoKeepPlayingOnScroll
local FFlagLuaAppVideoAutoplayFeedElection = require(VideoUtilsParent.SharedFlags).FFlagLuaAppVideoAutoplayFeedElection
local FFlagMobileGameJoinCardVideo = require(VideoUtilsParent.SharedFlags).FFlagMobileGameJoinCardVideo

local FFlagLuaAppVideoAutoplayOneByTwoConcurrentPlayback = require(VideoUtilsParent.SharedFlags).FFlagLuaAppVideoAutoplayOneByTwoConcurrentPlayback
local FFlagLuaAppVideoAutoplayElectOnNewCandidate = require(script.Parent.FFlagLuaAppVideoAutoplayElectOnNewCandidate)

local num1 = game:DefineFastInt("LuaAppVideoAutoplayMaxDistanceToWinnerLinePercent", 50)

local num2 = game:DefineFastInt("LuaAppVideoAutoplayScrollUpdateIntervalMs", 100)

local tbl1 = {
    instance = nil,
    shouldUseDwell = true,
    isUserIntentWinner = not FFlagLuaAppOneByTwoHoverIdleAutoplay and nil
}

local function winnerStateEquals(tbl2, tbl3): boolean
    return tbl2.instance == tbl3.instance
        and tbl2.shouldUseDwell == tbl3.shouldUseDwell
        and (not FFlagLuaAppOneByTwoHoverIdleAutoplay or tbl2.isUserIntentWinner == tbl3.isUserIntentWinner)
end

local function shouldSuppressReelection(str1: string?) -- Luacid: Inlined by compiler; 1 call site recovered
    return str1 == VideoEndReason.TileClicked
        or str1 == VideoEndReason.ExperienceLaunched
        or str1 == VideoEndReason.AppBackgrounded
        or FFlagMobileGameJoinCardVideo and str1 == VideoEndReason.OverlayTakeover
end

local function reportCandidateOverlap(arg1, arg2, absolutePositionX: number)
    DiscoveryEventErrorLogger.reportError(
        "ViewportAutoplayCandidateOverlap",
        "Two visible autoplay candidates share identical reading-order position and AbsolutePosition.X",
        {
            candidateA = arg1.Name,
            candidateB = arg2.Name,
            absolutePositionX = absolutePositionX,
            absolutePositionY = arg2.AbsolutePosition.Y,
            absoluteSizeX = arg2.AbsoluteSize.X,
            absoluteSizeY = arg2.AbsoluteSize.Y
        }
    )
end

local module = {}
module.__index = module

function module.new(coordinator, bool1: boolean?, bool2: boolean?, userIntentWithSelectiveAutoplay)
    local getWinnerState, setWinnerState = Signals.createSignal(tbl1, winnerStateEquals)
    local var3, var4

    if FFlagLuaAppSduiSuppressVideoDetectorDuringScroll then
        var3, var4 = Signals.createSignal(false)
    else
        var3 = nil
        var4 = nil
    end

    local tbl2 = {
        coordinator = coordinator,
        mode = if FFlagLuaAppOneByTwoHoverIdleAutoplay then userIntentWithSelectiveAutoplay else nil,
        isScrolling = false,
        pendingUpdateTask = nil,
        pendingAdsUpdateTask = nil,
        viewPortBounds = nil,
        feedScopeRef = nil,
        winnerLineOffsetFromTopBarPx = 0,
        preferTallestWinner = if FFlagLuaAppVideoAutoplayFeedElection then bool1 == true else false,
        electOnNewCandidate = if FFlagLuaAppVideoAutoplayFeedElection then bool2 == true else false,
        playedVideoKeys = FFlagLuaAppOneByTwoHoverIdleAutoplay and {} or nil,
        suppressDetectorsDuringScroll = not FFlagLuaAppSuppressVideoDetectorDuringScroll and not FFlagLuaAppSduiSuppressVideoDetectorDuringScroll and nil,
        getWinnerState = getWinnerState,
        setWinnerState = setWinnerState,
        adsPlaybackCoordinatorInfo = nil,
        isResettingPairedPlayback = not FFlagLuaAppVideoAutoplayOneByTwoConcurrentPlayback and nil,
        getDetectorsUnmounted = 0,
        setDetectorsUnmounted = 0
    }

    if not FFlagLuaAppSduiSuppressVideoDetectorDuringScroll then
        var3 = nil
    end

    tbl2.getDetectorsUnmounted = var3

    if not FFlagLuaAppSduiSuppressVideoDetectorDuringScroll then
        var4 = nil
    end

    tbl2.setDetectorsUnmounted = var4
    local self = setmetatable(tbl2, module)

    if FFlagLuaAppVideoAutoplayOneByTwoConcurrentPlayback then
        function coordinator.onPlaybackReset(str1: string, str2: string?)
            self:_resetPairedPlayback(coordinator, str1, str2)
        end
    end

    if FFlagLuaAppOneByTwoHoverIdleAutoplay
        and userIntentWithSelectiveAutoplay == ViewportVideoAutoplayMode.UserIntentWithSelectiveAutoplay
    then
        self.playbackChangedConnection = coordinator.changed:connect(function(str1: string?, str2: string?)
            local instance = self.getWinnerState(false).instance
            local var5 = if instance then instance:GetAttribute(ViewportAutoplayVideoKeyAttribute) else nil

            if str1 ~= nil then
                if var5 ~= str1 then
                    self.setWinnerState(tbl1)
                end
                return
            end

            if instance ~= nil then
                self.setWinnerState(tbl1)
            end

            if shouldSuppressReelection(str2) then
                self:_cancelPendingUpdate()
                self:_cancelScrollUpdate()
                return
            end
            self:scheduleUpdateWinner("Y", nil, false)
        end)
    end

    return self
end

function module:isUserIntentWithSelectiveAutoplay(): boolean
    return self.mode == ViewportVideoAutoplayMode.UserIntentWithSelectiveAutoplay
end

function module:setCandidateUserIntent(currentUserIntentCandidate, bool1: boolean)
    if not self:isUserIntentWithSelectiveAutoplay() then
        return
    end

    if bool1 then
        if self.currentUserIntentCandidate == currentUserIntentCandidate then
            return
        end
        self.currentUserIntentCandidate = currentUserIntentCandidate
    else
        if self.currentUserIntentCandidate ~= currentUserIntentCandidate then
            return
        end

        self.currentUserIntentCandidate = nil
    end

    if self.isScrolling and not FFlagLuaAppHoverIdleAutoplayDuringScroll then
        self:_scheduleScrollUpdate()
        return
    end
    self:scheduleUpdateWinner("Y", nil, false)
end

function module.clearUserIntentCandidate(arg1)
    arg1.currentUserIntentCandidate = nil
end

function module:requestWinnerPlayback(instance, callback: (...any) -> (...any))
    local winnerState = self.getWinnerState(false)
    if winnerState.instance ~= instance then
        return
    end

    if not self:isUserIntentWithSelectiveAutoplay() then
        callback(winnerState.shouldUseDwell)
        return
    end

    if winnerState.isUserIntentWinner then
        callback(false)
        return
    end

    local var1 = instance:GetAttribute(ViewportAutoplayVideoKeyAttribute)
    if typeof(var1) ~= "string" or self.playedVideoKeys[var1] or self.coordinator.playingVideoKey ~= nil then
        return
    end

    callback(false)
end

function module:onVideoCompleted(currentUserIntentCandidate)
    if not self:isUserIntentWithSelectiveAutoplay() then
        return
    end

    local var1 = currentUserIntentCandidate:GetAttribute(ViewportAutoplayVideoKeyAttribute)

    if typeof(var1) ~= "string"
        or self.coordinator.playingVideoKey ~= var1
        or self.currentUserIntentCandidate == currentUserIntentCandidate
    then
        return
    end

    self.playedVideoKeys[var1] = true
    self.coordinator:reset(VideoEndReason.Completed)
end

function module:getAdsPlaybackCoordinator()
    local adsPlaybackCoordinatorInfo = self.adsPlaybackCoordinatorInfo
    return if adsPlaybackCoordinatorInfo then adsPlaybackCoordinatorInfo.coordinator else nil
end

function module:getWinnerStateForCoordinator(coordinator)
    local adsPlaybackCoordinatorInfo = self.adsPlaybackCoordinatorInfo
    return if adsPlaybackCoordinatorInfo and adsPlaybackCoordinatorInfo.coordinator == coordinator then adsPlaybackCoordinatorInfo.getWinnerState else self.getWinnerState
end

function module:completeAdsPlayback(instance, str1: string)
    local adsPlaybackCoordinatorInfo = self.adsPlaybackCoordinatorInfo
    if not adsPlaybackCoordinatorInfo then
        return
    end

    adsPlaybackCoordinatorInfo.completedVideoKeys[str1] = true
    adsPlaybackCoordinatorInfo.handedOffInstances[instance] = true
    if adsPlaybackCoordinatorInfo.getWinnerState(false).instance ~= instance then
        return
    end

    adsPlaybackCoordinatorInfo.coordinator:reset(VideoEndReason.Completed)
    adsPlaybackCoordinatorInfo.setWinnerState({ instance = nil, shouldUseDwell = false })
end

function module:_consumeAdsHandoff(arg1): boolean
    local adsPlaybackCoordinatorInfo = self.adsPlaybackCoordinatorInfo
    if not (adsPlaybackCoordinatorInfo and adsPlaybackCoordinatorInfo.handedOffInstances[arg1]) then
        return false
    end

    adsPlaybackCoordinatorInfo.handedOffInstances[arg1] = nil
    return true
end

function module:hasCompletedAdsPlayback(str1: string): boolean
    local adsPlaybackCoordinatorInfo = self.adsPlaybackCoordinatorInfo
    return not (adsPlaybackCoordinatorInfo == nil) and adsPlaybackCoordinatorInfo.completedVideoKeys[str1] == true
end

function module:attachAdsPlaybackCoordinator(coordinator, candidateTag: string)
    if self.adsPlaybackCoordinatorInfo then
        return
    end

    local getWinnerState, setWinnerState = Signals.createSignal(tbl1, winnerStateEquals)
    self.adsPlaybackCoordinatorInfo = {
        coordinator = coordinator,
        candidateTag = candidateTag,
        getWinnerState = getWinnerState,
        setWinnerState = setWinnerState,
        completedVideoKeys = {},
        handedOffInstances = setmetatable({}, { __mode = "k" })
    }
    function coordinator.onPlaybackReset(str1: string, str2: string?)
        self:_resetPairedPlayback(coordinator, str1, str2)
    end
end

function module:_hasUsableViewportBounds(): boolean
    if not self.viewPortBounds then
        return false
    end

    return self.viewPortBounds.max.X > self.viewPortBounds.min.X and self.viewPortBounds.max.Y > self.viewPortBounds.min.Y
end

function module:_maybeScheduleInitialWinnerUpdate()
    if self.getWinnerState(false).instance ~= nil or self.isScrolling then
        return
    end

    if not self:_hasUsableViewportBounds() then
        return
    end

    if FFlagLuaAppVideoAutoplayFeedElection then
        self:scheduleUpdateWinner("Y", nil, true, true)
    else
        self:scheduleUpdateWinner("Y", nil, true)
    end
end

function module:onCandidateRegistered(arg1)
    if FFlagLuaAppVideoAutoplayOneByTwoConcurrentPlayback and self:_consumeAdsHandoff(arg1) then
        return
    end

    local current = if self.feedScopeRef then self.feedScopeRef.current else nil

    if not (current and arg1:IsDescendantOf(current)) then
        return
    end

    if self.isScrolling then
        return
    end

    if not self:_hasUsableViewportBounds() then
        return
    end

    if FFlagLuaAppOneByTwoHoverIdleAutoplay and self:isUserIntentWithSelectiveAutoplay() then
        self:scheduleUpdateWinner("Y", nil, false)
        return
    end

    if self.coordinator.playingVideoKey ~= nil then
        return
    end

    if not FFlagLuaAppVideoAutoplayFeedElection then
        self:scheduleUpdateWinner("Y", nil, true)
        return
    end

    if self.getWinnerState(false).instance == nil then
        self:_maybeScheduleInitialWinnerUpdate()
        return
    end

    if self.pendingUpdateTask ~= nil then
        return
    end

    self.pendingUpdateTask = task.defer(function()
        self.pendingUpdateTask = nil
        if not self.isScrolling and self.coordinator.playingVideoKey == nil then
            self:_updateWinner("Y", nil, true)
        end
    end)
end

function module.forceScheduleInitialWinnerUpdate(arg1)
    arg1:_cancelPendingUpdate()
    if FFlagLuaAppVideoAutoplayFeedElection then
        arg1:scheduleUpdateWinner("Y", nil, true, true)
        return
    end
    arg1:scheduleUpdateWinner("Y", nil, true)
end

function module:setViewPortBounds(viewPortBounds)
    self.viewPortBounds = viewPortBounds

    self:_maybeScheduleInitialWinnerUpdate()

    local winnerState = self.getWinnerState(false)
    local instance = winnerState.instance
    if instance ~= nil and not self.isScrolling and self:_hasUsableViewportBounds() then
        self:_cancelPendingUpdate()

        local var1 = nil
        local var2

        if FFlagLuaAppOneByTwoHoverIdleAutoplay and self:isUserIntentWithSelectiveAutoplay() then
            var2, var1 = self:_selectUserIntentOrAutoplayWinner("Y", nil)
        else
            var2 = self:_selectWinner("Y", nil)
        end
        local shouldUseDwell = winnerState.shouldUseDwell
        if var2 ~= instance then
            self.coordinator:reset(VideoEndReason.ViewportResized)
            shouldUseDwell = true
        end

        local setWinnerState = self.setWinnerState
        local tbl2 = { instance = var2, shouldUseDwell = shouldUseDwell, isUserIntentWinner = 0 }
        if not (FFlagLuaAppOneByTwoHoverIdleAutoplay and self:isUserIntentWithSelectiveAutoplay()) then
            var1 = nil
        end

        tbl2.isUserIntentWinner = var1
        setWinnerState(tbl2)
    end

    if FFlagLuaAppVideoAutoplayOneByTwoConcurrentPlayback then
        self:_refreshAdsWinnerForViewportChange()
    end
end

function module:setWinnerLineOffsetFromTopBarPx(winnerLineOffsetFromTopBarPx: number)
    self.winnerLineOffsetFromTopBarPx = winnerLineOffsetFromTopBarPx
end

function module:setSuppressDetectorsDuringScroll(suppressDetectorsDuringScroll: boolean)
    self.suppressDetectorsDuringScroll = suppressDetectorsDuringScroll
end

function module:setFeedScopeRef(feedScopeRef)
    self.feedScopeRef = feedScopeRef

    self:_maybeScheduleInitialWinnerUpdate()
end

function module:_cancelPendingUpdate()
    if self.pendingUpdateTask ~= nil then
        task.cancel(self.pendingUpdateTask)
        self.pendingUpdateTask = nil
    end
end

function module:_cancelPendingAdsUpdate()
    if self.pendingAdsUpdateTask ~= nil then
        task.cancel(self.pendingAdsUpdateTask)
        self.pendingAdsUpdateTask = nil
    end
end

function module:_deferApplyAdsWinner()
    self:_cancelPendingAdsUpdate()
    self.pendingAdsUpdateTask = task.defer(function()
        self.pendingAdsUpdateTask = nil
        if self.isScrolling or not self.adsPlaybackCoordinatorInfo then
            return
        end

        self:_applyAdsWinner(true, VideoEndReason.ExitViewport)
    end)
end

function module:_cancelScrollUpdate()
    if self.scrollUpdateTask ~= nil then
        task.cancel(self.scrollUpdateTask)
        self.scrollUpdateTask = nil
    end
end

function module:_scheduleScrollUpdate()
    if self.scrollUpdateTask ~= nil or not (self.isScrolling and self:isUserIntentWithSelectiveAutoplay()) then
        return
    end

    self.scrollUpdateTask = task.delay(num2 / 1000, function()
        self.scrollUpdateTask = nil
        if not self.isScrolling then
            return
        end

        self:_updateWinner("Y", nil, false)
        if FFlagLuaAppHoverIdleAutoplayDuringScroll then
            self:_scheduleScrollUpdate()
        end
    end)
end

function module:onScrollStart()
    self:_cancelPendingUpdate()
    self.isScrolling = true

    if FFlagLuaAppOneByTwoHoverIdleAutoplay and self:isUserIntentWithSelectiveAutoplay() then
        if FFlagLuaAppHoverIdleAutoplayDuringScroll then
            self:_scheduleScrollUpdate()
        end
        return
    end

    if not (FFlagLuaAppTileVideoKeepPlayingOnScroll
        or (FFlagLuaAppSuppressVideoDetectorDuringScroll or FFlagLuaAppSduiSuppressVideoDetectorDuringScroll)
            and self.suppressDetectorsDuringScroll) then
        self.coordinator:reset(VideoEndReason.ScrollStart)
        self.setWinnerState({ instance = nil, shouldUseDwell = false })
        if FFlagLuaAppVideoAutoplayOneByTwoConcurrentPlayback then
            self:_resetAdsPlayback(VideoEndReason.ScrollStart)
        end
    elseif (FFlagLuaAppSuppressVideoDetectorDuringScroll or FFlagLuaAppSduiSuppressVideoDetectorDuringScroll)
        and self.suppressDetectorsDuringScroll
    then
        self.coordinator:cancelPendingDwells()
        local adsPlaybackCoordinatorInfo = self.adsPlaybackCoordinatorInfo

        if FFlagLuaAppVideoAutoplayOneByTwoConcurrentPlayback
            and FFlagLuaAppSuppressOneByTwoVideoDetectorDuringScroll
            and adsPlaybackCoordinatorInfo
        then
            adsPlaybackCoordinatorInfo.coordinator:cancelPendingDwells()
        end
    end
end

function module:onScrollSettled(str1: string, _: number, tbl2)
    self:_cancelPendingUpdate()
    self.isScrolling = false
    if FFlagLuaAppOneByTwoHoverIdleAutoplay then
        self:_cancelScrollUpdate()
    end

    if FFlagLuaAppOneByTwoHoverIdleAutoplay and self:isUserIntentWithSelectiveAutoplay() then
        self:_updateWinner(str1, tbl2, false)
        return
    end

    if not FFlagLuaAppTileVideoKeepPlayingOnScroll
        and (not FFlagLuaAppSuppressVideoDetectorDuringScroll and not FFlagLuaAppSduiSuppressVideoDetectorDuringScroll
            or not self.suppressDetectorsDuringScroll)
    then
        self:_updateWinner(str1, tbl2, false)
        return
    end

    local instance = self.getWinnerState(false).instance
    local var1 = self:_selectWinner(str1, tbl2)

    if not FFlagLuaAppSuppressVideoDetectorDuringScroll and not FFlagLuaAppSduiSuppressVideoDetectorDuringScroll
        or not self.suppressDetectorsDuringScroll
        or var1 ~= nil
        or instance == nil
    then
        if instance ~= var1 and instance ~= nil then
            self.coordinator:reset(VideoEndReason.ScrollSettled)
        end

        self.setWinnerState({ instance = var1, shouldUseDwell = false })
        if FFlagLuaAppVideoAutoplayOneByTwoConcurrentPlayback then
            self:_applyAdsWinner(false, VideoEndReason.ScrollSettled)
        end

        return
    end

    self.pendingUpdateTask = task.defer(function()
        self.pendingUpdateTask = nil
        if self.isScrolling then
            return
        end
        local var2 = self:_selectWinner(str1, tbl2)
        local instance2 = self.getWinnerState(false).instance
        if var2 ~= instance2 and instance2 ~= nil then
            self.coordinator:reset(VideoEndReason.ScrollSettled)
        end
        self.setWinnerState({ instance = var2, shouldUseDwell = false })
        if FFlagLuaAppVideoAutoplayOneByTwoConcurrentPlayback then
            self:_applyAdsWinner(false, VideoEndReason.ScrollSettled)
        end
    end)
end

function module:_resetPairedPlayback(coordinator, str1: string, str2: string?)
    if self.isResettingPairedPlayback
        or str1 ~= VideoEndReason.TileClicked
            and str1 ~= VideoEndReason.ExperienceLaunched
            and (not FFlagMobileGameJoinCardVideo or str1 ~= VideoEndReason.OverlayTakeover)
    then
        return
    end

    self.isResettingPairedPlayback = true
    self:_cancelPendingUpdate()
    self:_cancelPendingAdsUpdate()
    if coordinator == self.coordinator then
        local adsPlaybackCoordinatorInfo = self.adsPlaybackCoordinatorInfo
        if adsPlaybackCoordinatorInfo then
            adsPlaybackCoordinatorInfo.coordinator:reset(str1, nil, str2, nil)
        end
    else
        self.coordinator:reset(str1, nil, str2, nil)
    end
    self.isResettingPairedPlayback = false
end

function module:reset(str1: string)
    if FFlagLuaAppVideoAutoplayOneByTwoConcurrentPlayback then
        self:_resetOrganicPlayback(str1)
        self:_cancelPendingAdsUpdate()
        self:_resetAdsPlayback(str1)
        return
    end
    self:_cancelPendingUpdate()
    if FFlagLuaAppOneByTwoHoverIdleAutoplay then
        self:_cancelScrollUpdate()
    end
    self.isScrolling = false
    if FFlagLuaAppSduiSuppressVideoDetectorDuringScroll then
        self.setDetectorsUnmounted(false)
    end
    self.coordinator:reset(str1)
    self.setWinnerState({
        instance = nil,
        shouldUseDwell = false,
        isUserIntentWinner = not (FFlagLuaAppOneByTwoHoverIdleAutoplay and self:isUserIntentWithSelectiveAutoplay()) and nil
    })
end

function module:_resetOrganicPlayback(str1: string)
    self:_cancelPendingUpdate()
    if FFlagLuaAppOneByTwoHoverIdleAutoplay then
        self:_cancelScrollUpdate()
    end
    self.isScrolling = false
    if FFlagLuaAppSduiSuppressVideoDetectorDuringScroll then
        self.setDetectorsUnmounted(false)
    end
    self.coordinator:reset(str1)
    self.setWinnerState({
        instance = nil,
        shouldUseDwell = false,
        isUserIntentWinner = not (FFlagLuaAppOneByTwoHoverIdleAutoplay and self:isUserIntentWithSelectiveAutoplay()) and nil
    })
end

function module:resetIfActiveInstance(instance, str1: string)
    if self.getWinnerState(false).instance == instance then
        if FFlagLuaAppVideoAutoplayOneByTwoConcurrentPlayback then
            self:_resetOrganicPlayback(str1)
        else
            self:reset(str1)
        end

        self:_maybeScheduleInitialWinnerUpdate()
        return
    end

    if not FFlagLuaAppVideoAutoplayOneByTwoConcurrentPlayback then
        return
    end

    local adsPlaybackCoordinatorInfo = self.adsPlaybackCoordinatorInfo
    if not adsPlaybackCoordinatorInfo or adsPlaybackCoordinatorInfo.getWinnerState(false).instance ~= instance then
        return
    end

    self:_resetAdsPlayback(str1)
    if not self.isScrolling and self:_hasUsableViewportBounds() then
        self:_deferApplyAdsWinner()
    end
end

function module:onAdsCandidateRegistered(arg1)
    if not self.adsPlaybackCoordinatorInfo then
        return
    end

    local current = if self.feedScopeRef then self.feedScopeRef.current else nil

    if current and arg1:IsDescendantOf(current) and not self.isScrolling and self:_hasUsableViewportBounds() then
        self:_deferApplyAdsWinner()
    end
end

function module:scheduleUpdateWinner(str1: string, tbl2, bool1: boolean, bool2: boolean?)
    if self.pendingUpdateTask ~= nil then
        return
    end

    self.pendingUpdateTask = task.defer(function()
        self.pendingUpdateTask = nil

        if self.isScrolling then
            return
        end

        self:_updateWinner(str1, tbl2, bool1, if FFlagLuaAppVideoAutoplayFeedElection then bool2 else nil)
    end)
end

function module:_updateWinner(str1: string, tbl2, shouldUseDwell: boolean, bool1: boolean?)
    if FFlagLuaAppOneByTwoHoverIdleAutoplay and self:isUserIntentWithSelectiveAutoplay() then
        local winnerState = self.getWinnerState(false)
        local instance = winnerState.instance
        local var1, isUserIntentWinner = self:_selectUserIntentOrAutoplayWinner(str1, tbl2, bool1)
        if var1 == instance and isUserIntentWinner == winnerState.isUserIntentWinner then
            return
        end

        local playingVideoKey = self.coordinator.playingVideoKey
        local var3 = if var1 then var1:GetAttribute(ViewportAutoplayVideoKeyAttribute) else nil
        local var4 = if instance then instance:GetAttribute(ViewportAutoplayVideoKeyAttribute) else nil

        if playingVideoKey ~= nil and var3 ~= playingVideoKey and (isUserIntentWinner or var4 == playingVideoKey) then
            local hasTag = not (instance == nil) and CollectionService:HasTag(instance, UserIntentModeAutoplayCandidateTag)
            local var5 = if isUserIntentWinner then VideoEndReason.HoverTakeover elseif instance and (not hasTag or typeof(var4) == "string" and self.playedVideoKeys[var4]) then VideoEndReason.Unhovered else VideoEndReason.ExitViewport
            self.coordinator:reset(var5)
        end

        self.setWinnerState({ instance = var1, shouldUseDwell = false, isUserIntentWinner = isUserIntentWinner })
        return
    end

    if not FFlagLuaAppVideoAutoplayFeedElection then
        local instance = self:_selectWinner(str1, tbl2)
        self.setWinnerState({ instance = instance, shouldUseDwell = shouldUseDwell })
        if FFlagLuaAppVideoAutoplayOneByTwoConcurrentPlayback then
            self:_applyAdsWinner(shouldUseDwell, VideoEndReason.ExitViewport)
        end

        return
    end

    local instance = self.getWinnerState(false).instance

    local var1 = self:_selectWinner(str1, tbl2, bool1)

    if (self.electOnNewCandidate or FFlagLuaAppVideoAutoplayElectOnNewCandidate) and instance ~= nil and var1 ~= instance then
        self.coordinator:reset(VideoEndReason.ExitViewport)
    end

    self.setWinnerState({ instance = var1, shouldUseDwell = shouldUseDwell })
    if FFlagLuaAppVideoAutoplayOneByTwoConcurrentPlayback then
        self:_applyAdsWinner(shouldUseDwell, VideoEndReason.ExitViewport)
    end
end

function module:_resetAdsPlayback(str1: string)
    local adsPlaybackCoordinatorInfo = self.adsPlaybackCoordinatorInfo
    if not adsPlaybackCoordinatorInfo then
        return
    end

    adsPlaybackCoordinatorInfo.coordinator:reset(str1)
    adsPlaybackCoordinatorInfo.setWinnerState({ instance = nil, shouldUseDwell = false })
end

function module:_refreshAdsWinnerForViewportChange()
    local adsPlaybackCoordinatorInfo = self.adsPlaybackCoordinatorInfo
    if not adsPlaybackCoordinatorInfo or self.isScrolling or not self:_hasUsableViewportBounds() then
        return
    end

    local winnerState = adsPlaybackCoordinatorInfo.getWinnerState(false)
    local instance = self:_selectAdsWinner()
    local shouldUseDwell = winnerState.shouldUseDwell
    if instance ~= winnerState.instance and winnerState.instance ~= nil then
        adsPlaybackCoordinatorInfo.coordinator:reset(VideoEndReason.ViewportResized)
        shouldUseDwell = true
    end

    adsPlaybackCoordinatorInfo.setWinnerState({ instance = instance, shouldUseDwell = shouldUseDwell })
end

function module:_applyAdsWinner(shouldUseDwell: boolean, str1: string)
    local adsPlaybackCoordinatorInfo = self.adsPlaybackCoordinatorInfo
    if not adsPlaybackCoordinatorInfo then
        return
    end

    local instance = adsPlaybackCoordinatorInfo.getWinnerState(false).instance
    local var1 = self:_selectAdsWinner()
    if var1 ~= instance and instance ~= nil then
        adsPlaybackCoordinatorInfo.coordinator:reset(str1)
    end

    adsPlaybackCoordinatorInfo.setWinnerState({ instance = var1, shouldUseDwell = shouldUseDwell })
end

function module:_selectAdsWinner()
    local adsPlaybackCoordinatorInfo = self.adsPlaybackCoordinatorInfo
    local viewPortBounds = self.viewPortBounds
    local current = if self.feedScopeRef then self.feedScopeRef.current else nil

    if not (adsPlaybackCoordinatorInfo and viewPortBounds and current) then
        return nil
    end

    local var1 = viewPortBounds.min.Y + self.winnerLineOffsetFromTopBarPx
    local num3 = math.max(viewPortBounds.max.X - viewPortBounds.min.X, 1)
    local var2 = nil
    local huge = math.huge
    local huge2 = math.huge
    local bool1 = false

    for _, value in CollectionService:GetTagged(adsPlaybackCoordinatorInfo.candidateTag) do
        if not (value:IsA("GuiObject")
            and value:IsDescendantOf(current)
            and getIsInstanceVisible(value, viewPortBounds, FIntLuaAppOneByTwoTileVideoVisiblePercent)) then
            continue
        end

        local absolutePositionX = value.AbsolutePosition.X
        local num4 = math.abs(value.AbsolutePosition.Y + absolutePositionX / num3 * value.AbsoluteSize.Y - var1)
        local bool2 = false
        if num4 < huge or num4 == huge and absolutePositionX < huge2 then
            bool2 = true
        elseif num4 == huge and absolutePositionX == huge2 and not bool1 and var2 then
            reportCandidateOverlap(var2, value, absolutePositionX)
            bool1 = true
        end

        if bool2 then
            var2 = value
            huge2 = absolutePositionX
            huge = num4
        end
    end

    return var2
end

function module:_selectUserIntentOrAutoplayWinner(str1: string, tbl2, bool1: boolean?)
    local var1 = self:_selectUserIntentWinner()
    if var1 then
        return var1, true
    end

    local playingVideoKey = self.coordinator.playingVideoKey
    if playingVideoKey ~= nil then
        return self:_selectCurrentIdleWinner(playingVideoKey), false
    elseif not self.isScrolling or FFlagLuaAppHoverIdleAutoplayDuringScroll then
        return self:_selectWinner(str1, tbl2, bool1, UserIntentModeAutoplayCandidateTag, true), false
    end

    return nil, false
end

function module:_selectUserIntentWinner()
    local currentUserIntentCandidate = self.currentUserIntentCandidate
    local current = if self.feedScopeRef then self.feedScopeRef.current else nil
    return if currentUserIntentCandidate == nil
        or current == nil
        or not (currentUserIntentCandidate:IsDescendantOf(current)
            and CollectionService:HasTag(currentUserIntentCandidate, ViewportAutoplayCandidateTag)) then nil else currentUserIntentCandidate
end

function module:_selectCurrentIdleWinner(str1: string)
    local current = if self.feedScopeRef then self.feedScopeRef.current else nil
    local viewPortBounds = self.viewPortBounds
    if current == nil or viewPortBounds == nil then
        return nil
    end

    for _, value in CollectionService:GetTagged(UserIntentModeAutoplayCandidateTag) do
        if not value:IsA("GuiObject")
            or value:GetAttribute(ViewportAutoplayVideoKeyAttribute) ~= str1
            or self.playedVideoKeys[str1]
            or not value:IsDescendantOf(current)
        then
            continue
        end

        local var1 = if getTileRowSpan(value) == 2 and not self.preferTallestWinner then FIntLuaAppOneByTwoTileVideoVisiblePercent else FIntLuaAppGameTileVideoVisiblePercent

        if getIsInstanceVisible(value, viewPortBounds, var1) then
            return value
        end
    end

    return nil
end

function module:_isCandidateEligibleForSelection(arg1, bool1: boolean?): boolean
    if not bool1 then
        return true
    end

    local var1 = arg1:GetAttribute(ViewportAutoplayVideoKeyAttribute)
    return typeof(var1) == "string" and not self.playedVideoKeys[var1]
end

function module:_selectWinner(str1: string, tbl2, bool1: boolean?, str2: string?, bool2: boolean?)
    local viewPortBounds = self.viewPortBounds
    if not viewPortBounds then
        return nil
    end

    local current = nil
    if str1 == "X" and tbl2 then
        current = tbl2.current
    elseif self.feedScopeRef then
        current = self.feedScopeRef.current
    end

    if not current then
        return nil
    end

    local var1 = viewPortBounds.min.Y + self.winnerLineOffsetFromTopBarPx
    local num3 = math.max(viewPortBounds.max.X - viewPortBounds.min.X, 1)

    local var2 = (viewPortBounds.max.Y - viewPortBounds.min.Y) * (num1 / 100)

    local var3 = nil
    local huge = math.huge
    local huge2 = math.huge
    local bool3 = false
    local var4, huge3

    if self.preferTallestWinner then
        var4 = -1
        huge3 = math.huge
    else
        var4 = nil
        huge3 = nil
    end

    local function shouldReplaceByLeftmostX(absolutePositionX: number, arg1: Instance): boolean -- Luacid: Inlined by compiler; 6 call sites recovered
        if absolutePositionX < huge2 then
            return true
        end

        if absolutePositionX == huge2 and not bool3 and var3 then
            bool3 = true
            reportCandidateOverlap(var3, arg1, absolutePositionX)
        end
        return false
    end

    local function considerFoldXCandidate(arg1: Instance, absolutePositionX: number, num4: number) -- Luacid: Inlined by compiler; 3 call sites recovered
        local num5 = math.abs(num4 - var1)
        if num5 < huge or num5 == huge and shouldReplaceByLeftmostX(absolutePositionX, arg1) then
            huge = num5
            huge2 = absolutePositionX
            var3 = arg1
        end
    end

    local tagged = CollectionService:GetTagged(FFlagLuaAppOneByTwoHoverIdleAutoplay and str2 or ViewportAutoplayCandidateTag)

    local tbl3 = {}
    for _, value in tagged do
        if value:IsA("GuiObject")
            and value:IsDescendantOf(current)
            and (not FFlagLuaAppOneByTwoHoverIdleAutoplay or self:_isCandidateEligibleForSelection(value, bool2))
        then
            table.insert(tbl3, value)
        end
    end

    local var5 = computeRowAnchorOverrides(tbl3, num3)

    for _, value in tagged do
        if not value:IsA("GuiObject")
            or not value:IsDescendantOf(current)
            or FFlagLuaAppOneByTwoHoverIdleAutoplay and not self:_isCandidateEligibleForSelection(value, bool2)
        then
            continue
        end

        local var6 = if getTileRowSpan(value) == 2 and not self.preferTallestWinner then FIntLuaAppOneByTwoTileVideoVisiblePercent else FIntLuaAppGameTileVideoVisiblePercent

        if not getIsInstanceVisible(value, viewPortBounds, var6) then
            continue
        end

        local absolutePositionX = value.AbsolutePosition.X

        if FFlagLuaAppVideoAutoplayFeedElection and self.preferTallestWinner then
            local absolutePositionY = value.AbsolutePosition.Y
            local var7 = value.AbsolutePosition.Y + value.AbsoluteSize.Y
            local num4 = math.abs(math.clamp(var1, absolutePositionY, var7) - var1)

            local absoluteSizeY = value.AbsoluteSize.Y
            local num5 = math.abs(value.AbsolutePosition.Y + absolutePositionX / num3 * absoluteSizeY - var1)
            local bool4 = false
            if num4 < huge then
                bool4 = true
            elseif num4 == huge then
                if var4 < absoluteSizeY then
                    bool4 = true
                elseif absoluteSizeY == var4 then
                    if bool1 then
                        if shouldReplaceByLeftmostX(absolutePositionX, value) then
                            bool4 = true
                        end
                    elseif num5 < huge3 or num5 == huge3 and shouldReplaceByLeftmostX(absolutePositionX, value) then
                        bool4 = true
                    end
                end
            end

            if bool4 then
                huge = num4

                huge2 = absolutePositionX
                var3 = value
                huge3 = num5
                var4 = absoluteSizeY
            end
        else
            local tileRowSpan = getTileRowSpan(value)
            local var7 = var5[value]
            if tileRowSpan == 2 then
                local var8 = resolveOneByOneHeight(value, tileRowSpan)
                local readingOrderPositions = getReadingOrderPositions(value, absolutePositionX, num3, tileRowSpan, var8)
                if var7 ~= nil then
                    readingOrderPositions[if isTilePinnedLeft(value) then 1 else tileRowSpan] = var7
                end
                for _, readingOrderPosition in readingOrderPositions do
                    considerFoldXCandidate(value, absolutePositionX, readingOrderPosition)
                end
            elseif var7 ~= nil then
                considerFoldXCandidate(value, absolutePositionX, var7)
            else
                considerFoldXCandidate(
                    value,
                    absolutePositionX,
                    value.AbsolutePosition.Y + absolutePositionX / num3 * value.AbsoluteSize.Y
                )
            end
        end
    end

    return if var2 < huge then nil else var3
end

return module
