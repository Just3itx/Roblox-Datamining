-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T21:41:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CollectionService = game:GetService("CollectionService")

local Constants = require(script.Parent.Constants)
local calculateIntersectionRatio = require(script.Parent.calculateIntersectionRatio)
local sponsoredAdViewabilityRegistry = require(script.Parent.sponsoredAdViewabilityRegistry)
local sponsoredAdViewabilityState = require(script.Parent.sponsoredAdViewabilityState)
local _sponsoredAdViewabilityTypes = require(script.Parent.sponsoredAdViewabilityTypes)

local TerminalReason = { SurfaceTeardown = "SurfaceTeardown", FeedRefresh = "FeedRefresh" }

local function invokeCallback(str1: string, callback: (...any) -> (...any), ...)
    local var1 = nil
    if not xpcall(callback, function(arg1)
        var1 = arg1
    end, ...) then
        warn(`SponsoredAdViewability {str1} failed`, var1)
    end
end

local var1 = table.freeze({})

local module = {}
module.__index = module

function module.new(_callbacks)
    return (setmetatable({
        _callbacks = _callbacks,
        _surfaceScope = nil,
        _viewportBounds = nil,
        _sessions = {},
        _running = false,
        _paused = false,
        _scanThread = nil
    }, module))
end

local function isVideoMetadata(arg1): boolean -- Luacid: Inlined by compiler; 6 call sites recovered
    return arg1.mediaType == "video"
end

local function readVideoPlaybackState(metadata) -- Luacid: Inlined by compiler; 1 call site recovered
    if not isVideoMetadata(metadata) then
        return nil
    end
    local videoPlaybackStateRef = metadata.videoPlaybackStateRef
    local current = if videoPlaybackStateRef then videoPlaybackStateRef.current else nil

    if current == nil then
        return nil
    end
    local success, result = pcall(current)
    return if success then result else nil
end

local function getLayerCollectorAndVisibility(arg1)
    local bool1 = true

    while arg1 do
        if arg1:IsA("GuiObject") and not arg1.Visible then
            bool1 = false
        end

        if arg1:IsA("LayerCollector") then
            return arg1, bool1 and arg1.Enabled
        end
        arg1 = arg1.Parent
    end
    return nil, false
end

local function getRegisteredTile(arg1, _surfaceScope)
    if not arg1:IsA("GuiObject") then
        return nil, nil, nil
    end
    local var2 = arg1:GetAttribute(Constants.ViewabilityTargetIdAttribute)
    if typeof(var2) ~= "string" then
        return nil, nil, nil
    end
    local var3 = sponsoredAdViewabilityRegistry.get(var2)
    if var3 == nil or var3.isFullscreen ~= true and not arg1:IsDescendantOf(_surfaceScope) then
        return nil, nil, nil
    end

    return arg1, var2, var3
end

local function measureRegisteredTile(registeredTile, viewabilityTargetId: string, metadata, _viewportBounds): {geometry: {adSize: any, viewportBounds: any}, isFullscreen: boolean, metadata: any, ratio: any, videoStateSnapshot: any, viewabilityTargetId: string}?
    local isFullscreen = metadata.isFullscreen == true
    local absolutePosition = nil
    local absoluteSize = nil
    local tbl2 = _viewportBounds
    return if pcall(function()
        if isFullscreen then
            local var2, var3 = getLayerCollectorAndVisibility(registeredTile)
            if var2 == nil or not var3 then
                return
            end
            tbl2 = {
                min = var2.AbsolutePosition,
                max = var2.AbsolutePosition + var2.AbsoluteSize
            }
        end
        absolutePosition = registeredTile.AbsolutePosition
        absoluteSize = registeredTile.AbsoluteSize
    end) and absolutePosition ~= nil and absoluteSize ~= nil then {
        metadata = metadata,
        geometry = { adSize = absoluteSize, viewportBounds = tbl2 },
        ratio = calculateIntersectionRatio(absolutePosition, absoluteSize, tbl2),
        viewabilityTargetId = viewabilityTargetId,
        videoStateSnapshot = readVideoPlaybackState(metadata),
        isFullscreen = isFullscreen
    } else nil
end

local function shouldReplaceCandidate(tbl2, tbl3)
    if tbl2.isFullscreen ~= tbl3.isFullscreen then
        return if tbl2.videoStateSnapshot ~= nil == (tbl3.videoStateSnapshot ~= nil) then tbl3.isFullscreen else tbl3.videoStateSnapshot ~= nil
    end
    if tbl2.ratio ~= tbl3.ratio then
        return tbl3.ratio > tbl2.ratio
    end
    if tbl2.videoStateSnapshot ~= nil ~= (tbl3.videoStateSnapshot ~= nil) then
        return tbl3.videoStateSnapshot ~= nil
    end

    local var2 = tonumber(tbl3.viewabilityTargetId)
    local var3 = tonumber(tbl2.viewabilityTargetId)
    return if var2 == nil or var3 == nil then var2 ~= nil else var3 < var2
end

local function selectBetterMeasurement(tbl2, tbl3) -- Luacid: Inlined by compiler; 2 call sites recovered
    local encryptedAdTrackingData = tbl3.metadata.encryptedAdTrackingData
    local var2 = tbl2[encryptedAdTrackingData]
    if var2 ~= nil and var2.metadata.mediaType ~= tbl3.metadata.mediaType then
        return
    end
    if var2 == nil or shouldReplaceCandidate(var2, tbl3) then
        tbl2[encryptedAdTrackingData] = tbl3
    end
end

local function canStartOrContinueSession(tbl2, _session): boolean -- Luacid: Inlined by compiler; 2 call sites recovered
    local bool1 = not tbl2.isFullscreen
    return bool1 or _session ~= nil and _session.video ~= nil
end

local function canMeasureViewport(_viewportBounds): boolean -- Luacid: Inlined by compiler; 2 call sites recovered
    return _viewportBounds.max.X > _viewportBounds.min.X and _viewportBounds.max.Y > _viewportBounds.min.Y
end

local function hasVideoSession(_sessions) -- Luacid: Inlined by compiler; 1 call site recovered
    for _, _session in _sessions do
        if _session.video ~= nil then
            return true
        end
    end
    return false
end

function module:_advanceSession(tbl2, num1: number, num2: number, arg1, arg2, bool1: boolean, arg3)
    local var2, var3 = tbl2.state:advance(num1, num2, arg1, arg2, bool1)
    local var4 = arg3 or tbl2.metadata
    for _, value in var2 do
        invokeCallback("onMilestone", self._callbacks.onMilestone, var4, value)
    end
    local onVideoProgress = self._callbacks.onVideoProgress
    if onVideoProgress == nil or var3 == nil then
        return
    end

    for _, value in var3 do
        invokeCallback("onVideoProgress", onVideoProgress, var4, value)
    end
end

function module:_processMeasurement(str1: string, tbl2, num1: number)
    local metadata = tbl2.metadata
    local bool1 = not not isVideoMetadata(metadata)

    local _session = self._sessions[str1]
    if not _session then
        _session = {
            state = sponsoredAdViewabilityState.new(num1, bool1),
            metadata = metadata,
            video = bool1 and {
                viewabilityTargetId = tbl2.viewabilityTargetId,
                isFullscreen = tbl2.isFullscreen
            } or nil
        }

        self._sessions[str1] = _session
        invokeCallback("onSessionStart", self._callbacks.onSessionStart, metadata, tbl2.geometry, num1, tbl2.videoStateSnapshot)
    end

    if bool1 then
        self:_applySelectedVideoMeasurement(_session, tbl2, num1)
    elseif _session.video == nil then
        self:_advanceSession(_session, num1, tbl2.ratio, tbl2.geometry, nil, false, metadata)
    end
end

function module:_applySelectedVideoMeasurement(tbl2, tbl3, num1: number)
    local video = tbl2.video
    if video == nil then
        return
    end

    if tbl3 == nil then
        self:_advanceSession(tbl2, num1, 0, nil, nil, video.isFullscreen)
        return
    end

    local metadata = tbl3.metadata

    if not isVideoMetadata(metadata) then
        return
    end
    if video.viewabilityTargetId ~= tbl3.viewabilityTargetId then
        local bool1 = video.isFullscreen ~= tbl3.isFullscreen
        tbl2.state:transitionVideoSource(num1, bool1)
    end

    tbl2.metadata = metadata
    video.viewabilityTargetId = tbl3.viewabilityTargetId
    video.isFullscreen = tbl3.isFullscreen
    self:_advanceSession(tbl2, num1, tbl3.ratio, tbl3.geometry, tbl3.videoStateSnapshot, tbl3.isFullscreen)
end

function module:_collectCurrentVideoMeasurements()
    if not hasVideoSession(self._sessions) then
        return var1
    end

    local result = {}
    local _surfaceScope = self._surfaceScope
    local _viewportBounds = self._viewportBounds

    if _surfaceScope == nil or _viewportBounds == nil or not canMeasureViewport(_viewportBounds) then
        return result
    end

    for _, value in CollectionService:GetTagged(Constants.CandidateTag) do
        local var2, var3, var4 = getRegisteredTile(value, _surfaceScope)

        if var2 == nil or var3 == nil or var4 == nil or not isVideoMetadata(var4) then
            continue
        end

        local var5 = measureRegisteredTile(var2, var3, var4, _viewportBounds)

        if var5 ~= nil and canStartOrContinueSession(var5, self._sessions[var4.encryptedAdTrackingData]) then
            selectBetterMeasurement(result, var5)
        end
    end

    return result
end

function module:setSurfaceScope(_surfaceScope)
    self._surfaceScope = _surfaceScope
end

function module:setViewportBounds(_viewportBounds)
    self._viewportBounds = _viewportBounds
end

function module:start()
    if self._running then
        return
    end
    self._running = true
    if not self._paused then
        self:_scheduleNextScan()
    end
end

function module:_cancelScheduledScan()
    local _scanThread = self._scanThread
    if _scanThread ~= nil and coroutine.status(_scanThread) == "suspended" then
        task.cancel(_scanThread)
    end
    self._scanThread = nil
end

function module:_scheduleNextScan()
    if self._scanThread ~= nil then
        return
    end
    self._scanThread = task.delay(0.2, function()
        self._scanThread = nil
        if not self._running or self._paused then
            return
        end
        local success, result = pcall(self._scanTick, self, DateTime.now().UnixTimestampMillis)
        if not success then
            warn("SponsoredAdViewability scan failed; disabling detector", result)

            self._running = false
            self._sessions = {}
            return
        end

        if self._running and not self._paused then
            self:_scheduleNextScan()
        end
    end)
end

function module:_scanTick(num1: number)
    local _surfaceScope = self._surfaceScope
    local _viewportBounds = self._viewportBounds
    if _surfaceScope == nil or _viewportBounds == nil or not canMeasureViewport(_viewportBounds) then
        return
    end

    local tbl2 = ({})
    local tbl3 = ({})
    local tbl4 = {}
    for _, value in CollectionService:GetTagged(Constants.CandidateTag) do
        local var2, var3, var4 = getRegisteredTile(value, _surfaceScope)
        if var2 == nil or var3 == nil or var4 == nil then
            continue
        end

        local encryptedAdTrackingData = var4.encryptedAdTrackingData
        local var5 = measureRegisteredTile(var2, var3, var4, _viewportBounds)
        if var5 == nil then
            local _session = self._sessions[encryptedAdTrackingData]

            if var4.isFullscreen == true and isVideoMetadata(var4) and _session ~= nil and _session.video ~= nil then
                tbl3[encryptedAdTrackingData] = true
            end
        elseif canStartOrContinueSession(var5, self._sessions[encryptedAdTrackingData]) then
            tbl2[encryptedAdTrackingData] = true
            selectBetterMeasurement(tbl4, var5)
        end
    end

    for value, value2 in tbl4 do
        if not tbl3[value] or value2.isFullscreen then
            self:_processMeasurement(value, value2, num1)
        end
    end

    for k, _session in self._sessions do
        if tbl2[k] or tbl3[k] then
            continue
        end

        local video = _session.video
        local num2 = 0
        local var2 = nil
        local var3 = nil
        local isFullscreen = not (video == nil) and video.isFullscreen
        self:_advanceSession(_session, num1, num2, var2, var3, isFullscreen)
    end
end

function module:pause(num1: number?)
    if self._paused then
        return
    end
    local num2 = num1 or DateTime.now().UnixTimestampMillis
    local var2 = self:_collectCurrentVideoMeasurements()
    for k, _session in self._sessions do
        if _session.video ~= nil then
            self:_applySelectedVideoMeasurement(_session, var2[k], num2)
        end
        _session.state:pause(num2)
    end
    self._paused = true
    self:_cancelScheduledScan()
end

function module:resume(num1: number?)
    if not self._paused then
        return
    end
    local num2 = num1 or DateTime.now().UnixTimestampMillis
    for _, _session in self._sessions do
        _session.state:resume(num2)
    end
    self._paused = false
    if self._running then
        self:_scheduleNextScan()
    end
end

function module:_terminateAllSessions(num1: number, str1: string)
    local _sessions = self._sessions
    local var2 = self._paused and {} or self:_collectCurrentVideoMeasurements()
    self._sessions = {}
    for k, _session in _sessions do
        if not self._paused and _session.video ~= nil then
            self:_applySelectedVideoMeasurement(_session, var2[k], num1)
        end
        local var3 = _session.state:finalize(num1)
        invokeCallback("onUnload", self._callbacks.onUnload, _session.metadata, var3, str1)
    end
end

function module.onFeedRefresh(arg1, num1: number?)
    arg1:_terminateAllSessions(num1 or DateTime.now().UnixTimestampMillis, TerminalReason.FeedRefresh)
end

function module:reset(num1: number?)
    self._running = false
    self:_cancelScheduledScan()

    self:_terminateAllSessions(num1 or DateTime.now().UnixTimestampMillis, TerminalReason.SurfaceTeardown)
end

module.TerminalReason = TerminalReason

return module
