-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T21:41:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local _calculateIntersectionRatio = require(script.Parent.calculateIntersectionRatio)
local _sponsoredAdViewabilityTypes = require(script.Parent.sponsoredAdViewabilityTypes)

local tbl1 = {
    0,
    25,
    50,
    75,
    100
}

local MilestoneLabels = {
    IabDisplayStandard = "IabDisplayStandard",
    IabDisplayLarge = "IabDisplayLarge",
    FullView = "FullView",
    IabVideoStandard = "IabVideoStandard",
    FullViewVideo = "FullViewVideo"
}

local function newBand(threshold: number, currentContinuousMs: number?): {cumulativeMs: number, currentContinuousMs: number, enteredAtMs: nil, maxContinuousMs: number, pendingContinuity: boolean, threshold: number} | {cumulativeMs: number, enteredAtMs: nil, maxContinuousMs: number, threshold: number}
    return if currentContinuousMs == nil then {
        threshold = threshold,
        enteredAtMs = nil,
        cumulativeMs = 0,
        maxContinuousMs = 0
    } else {
        threshold = threshold,
        enteredAtMs = nil,
        currentContinuousMs = currentContinuousMs,
        pendingContinuity = false,
        cumulativeMs = 0,
        maxContinuousMs = 0
    }
end

local function recordClosedWindow(tbl3, maxContinuousMs: number) -- Luacid: Inlined by compiler; 96 call sites recovered
    tbl3.cumulativeMs += maxContinuousMs
    if tbl3.maxContinuousMs < maxContinuousMs then
        tbl3.maxContinuousMs = maxContinuousMs
    end
    tbl3.enteredAtMs = nil
end

local function closeWindow(tbl3, num1: number?) -- Luacid: Inlined by compiler; 47 call sites recovered
    local enteredAtMs = tbl3.enteredAtMs
    local currentContinuousMs = tbl3.currentContinuousMs
    if currentContinuousMs == nil then
        if enteredAtMs ~= nil then
            recordClosedWindow(tbl3, assert(num1, "image band requires an end timestamp") - enteredAtMs)
        end

        return
    end

    if enteredAtMs == nil and not tbl3.pendingContinuity then
        return
    end

    recordClosedWindow(tbl3, currentContinuousMs)
    tbl3.currentContinuousMs = 0
    tbl3.pendingContinuity = false
end

local function updateBandTimer(tbl3, threshold: number, enteredAtMs: number) -- Luacid: Inlined by compiler; 3 call sites recovered
    if not (tbl3.threshold <= threshold) then
        closeWindow(tbl3, enteredAtMs)
        return
    end

    if tbl3.enteredAtMs == nil then
        tbl3.enteredAtMs = enteredAtMs
    end
end

local function durationAsOf(tbl3, num1: number?) -- Luacid: Inlined by compiler; 6 call sites recovered
    local cumulativeMs = tbl3.cumulativeMs
    local maxContinuousMs = tbl3.maxContinuousMs
    local enteredAtMs = tbl3.enteredAtMs
    local currentContinuousMs = tbl3.currentContinuousMs
    local var1 = nil
    if currentContinuousMs ~= nil then
        if enteredAtMs ~= nil or tbl3.pendingContinuity then
            var1 = currentContinuousMs
        end
    elseif enteredAtMs ~= nil then
        var1 = assert(num1, "image band requires the current timestamp") - enteredAtMs
    end
    if var1 ~= nil then
        cumulativeMs += var1
        if maxContinuousMs < var1 then
            maxContinuousMs = var1
        end
    end

    return cumulativeMs, maxContinuousMs
end

local function continuousVideoDurationAsOf(tbl3) -- Luacid: Inlined by compiler; 1 call site recovered
    return if tbl3.enteredAtMs == nil then 0 else tbl3.currentContinuousMs or 0
end

local function preserveVideoBandAcrossSourceChange(tbl3) -- Luacid: Inlined by compiler; 3 call sites recovered
    if tbl3.enteredAtMs ~= nil then
        tbl3.enteredAtMs = nil
        tbl3.pendingContinuity = true
    end
end

local function copyGeometry(tbl3)
    return {
        adSize = tbl3.adSize,
        viewportBounds = {
            min = tbl3.viewportBounds.min,
            max = tbl3.viewportBounds.max
        }
    }
end

local function audioOn(arg1) -- Luacid: Inlined by compiler; 3 call sites recovered
    return not (arg1 == nil) and arg1.isPlaying and arg1.audioLevel > 0
end

local function isNonnegativeInteger(arg1): boolean -- Luacid: Inlined by compiler; 2 call sites recovered
    return typeof(arg1) == "number" and arg1 >= 0 and arg1 % 1 == 0
end

local function isValidVideoPlaybackSnapshot(arg1): boolean
    local playbackPositionMs = arg1.playbackPositionMs
    local loopCount = arg1.loopCount
    local endedCount = arg1.endedCount
    local audioLevel = arg1.audioLevel
    local videoLengthMs = arg1.videoLengthMs
    local isPlaying = arg1.isPlaying
    local bool1

    if typeof(isPlaying) == "boolean" and typeof(playbackPositionMs) == "number" and playbackPositionMs >= 0 then
        bool1 = isNonnegativeInteger(loopCount) and (endedCount == nil or isNonnegativeInteger(endedCount))

        if bool1 then
            if typeof(audioLevel) == "number" and audioLevel >= 0 and audioLevel <= 1 then
                if videoLengthMs == nil then
                    bool1 = true
                elseif typeof(videoLengthMs) == "number" then
                    bool1 = videoLengthMs > 0
                else
                    bool1 = false
                end
            else
                bool1 = false
            end
        end
    else
        bool1 = false
    end

    return bool1
end

local function realEstateOf(num1: number, tbl3) -- Luacid: Inlined by compiler; 1 call site recovered
    if tbl3 == nil then
        return 0
    end
    local viewportBounds = tbl3.viewportBounds
    local var1 = (viewportBounds.max.X - viewportBounds.min.X) * (viewportBounds.max.Y - viewportBounds.min.Y)

    if var1 <= 0 then
        return 0
    end

    return num1 * tbl3.adSize.X * tbl3.adSize.Y / var1
end

local module = {}
module.__index = module

function module.new(startTimestampMs: number, bool1: boolean)
    local bool2 = bool1 == true
    return (setmetatable({
        startTimestampMs = startTimestampMs,
        _achieved = {},
        _band30 = newBand(0.3, if bool2 then 0 else nil),
        _band50 = newBand(0.5, if bool2 then 0 else nil),
        _band100 = newBand(1, if bool2 then 0 else nil),
        _inGridBand50 = bool2
            and {
                threshold = 0.5,
                enteredAtMs = nil,
                currentContinuousMs = 0,
                pendingContinuity = false,
                cumulativeMs = 0,
                maxContinuousMs = 0
            }
            or nil,
        _fullscreenBand50 = bool2
            and {
                threshold = 0.5,
                enteredAtMs = nil,
                currentContinuousMs = 0,
                pendingContinuity = false,
                cumulativeMs = 0,
                maxContinuousMs = 0
            }
            or nil,
        _displayLabel = nil,
        _lastSampleMs = nil,
        _lastRatio = 0,
        _lastRealEstate = 0,
        _percentWeightedSum = 0,
        _realEstateWeightedSum = 0,
        _visibleWeightedMs = 0,
        _minPercentSeen = nil,
        _maxPercentSeen = nil,
        _latchedGeometry = nil,
        _pausedAtMs = nil,
        _pausedDurationMs = 0,
        _video = bool2
            and {
                highestProgress = nil,
                lengthMs = nil,
                cumulativePlaytimeMs = 0,
                lastSampleMs = nil,
                lastSnapshot = nil,
                isFullscreen = false,
                cumulativeAudioPlaybackMs = 0,
                cumulative100PercentAudibleMs = 0,
                maxAudioLevel = 0,
                audioOnAtEvent = false
            }
            or nil,
        _finalized = false,
        _terminalSnapshot = nil
    }, module))
end

function module:_classifyDisplayOnce(vector2: Vector2)
    if self._displayLabel ~= nil then
        return
    end
    local var1 = vector2.X * vector2.Y
    if var1 <= 0 then
        return
    end
    self._displayLabel = if var1 > 242500 then MilestoneLabels.IabDisplayLarge else MilestoneLabels.IabDisplayStandard
end

function module:_tryFire(tbl3, milestoneLabel: string, num1: number, tbl4, tbl5, num2: number?)
    if self._achieved[milestoneLabel] then
        return
    end
    local _video = self._video
    local bool1

    if _video == nil then
        local enteredAtMs = tbl3.enteredAtMs
        if enteredAtMs == nil then
            bool1 = false
        else
            bool1 = num1 - enteredAtMs >= 1000
        end
    else
        bool1 = (num2 or 1000) <= continuousVideoDurationAsOf(tbl3)
    end
    if not bool1 then
        return
    end

    local cumulative30PercentInViewDurationMs, maxContinuous30PercentInViewDurationMs = durationAsOf(self._band30, num1)
    local cumulative50PercentInViewDurationMs, maxContinuous50PercentInViewDurationMs = durationAsOf(self._band50, num1)
    local cumulative100PercentInViewDurationMs, maxContinuous100PercentInViewDurationMs = durationAsOf(self._band100, num1)
    local tbl6 = {
        milestoneLabel = milestoneLabel,
        geometry = copyGeometry(tbl4),
        viewabilitySessionStartTimestampMs = self.startTimestampMs,
        cumulative30PercentInViewDurationMs = cumulative30PercentInViewDurationMs,
        cumulative50PercentInViewDurationMs = cumulative50PercentInViewDurationMs,
        cumulative100PercentInViewDurationMs = cumulative100PercentInViewDurationMs,
        maxContinuous30PercentInViewDurationMs = maxContinuous30PercentInViewDurationMs,
        maxContinuous50PercentInViewDurationMs = maxContinuous50PercentInViewDurationMs,
        maxContinuous100PercentInViewDurationMs = maxContinuous100PercentInViewDurationMs
    }
    if _video ~= nil then
        local _inGridBand50 = self._inGridBand50
        local _fullscreenBand50 = self._fullscreenBand50
        if _inGridBand50 == nil or _fullscreenBand50 == nil then
            return
        end
        tbl6.isFullScreen = _video.isFullscreen
        tbl6.videoLengthMs = _video.lengthMs
        tbl6.maxAudioLevel = _video.maxAudioLevel
        local cumulativeMs = _inGridBand50.cumulativeMs
        local maxContinuousMs = _inGridBand50.maxContinuousMs
        local enteredAtMs = _inGridBand50.enteredAtMs
        local currentContinuousMs = _inGridBand50.currentContinuousMs
        local var7 = nil
        if currentContinuousMs ~= nil then
            if enteredAtMs ~= nil or _inGridBand50.pendingContinuity then
                var7 = currentContinuousMs
            end
        elseif enteredAtMs ~= nil then
            var7 = assert(nil, "image band requires the current timestamp") - enteredAtMs
        end
        if var7 ~= nil then
            cumulativeMs += var7
            if maxContinuousMs < var7 then
            end
        end

        tbl6.cumulativeInGridViewDurationMs = cumulativeMs
        local cumulativeMs2 = _fullscreenBand50.cumulativeMs
        local maxContinuousMs2 = _fullscreenBand50.maxContinuousMs
        local enteredAtMs2 = _fullscreenBand50.enteredAtMs
        local currentContinuousMs2 = _fullscreenBand50.currentContinuousMs
        local var8 = nil
        if currentContinuousMs2 ~= nil then
            if enteredAtMs2 ~= nil or _fullscreenBand50.pendingContinuity then
                var8 = currentContinuousMs2
            end
        elseif enteredAtMs2 ~= nil then
            var8 = assert(nil, "image band requires the current timestamp") - enteredAtMs2
        end
        if var8 ~= nil then
            cumulativeMs2 += var8
            if maxContinuousMs2 < var8 then
            end
        end

        tbl6.cumulativeFullScreenViewDurationMs = cumulativeMs2
    end
    self._achieved[milestoneLabel] = true
    table.insert(tbl5, tbl6)
end

function module:_accumulate(_lastSampleMs: number, num1: number, tbl3)
    local _lastSampleMs2 = self._lastSampleMs
    if _lastSampleMs2 ~= nil and self._lastRatio > 0 then
        local var1 = _lastSampleMs - _lastSampleMs2
        if var1 > 0 then
            self._percentWeightedSum += self._lastRatio * var1
            self._realEstateWeightedSum += self._lastRealEstate * var1
            self._visibleWeightedMs += var1
        end
    end

    self._lastSampleMs = _lastSampleMs
    self._lastRatio = num1
    self._lastRealEstate = realEstateOf(num1, tbl3)

    if not (num1 > 0) then
        return
    end

    if self._minPercentSeen == nil or num1 < self._minPercentSeen then
        self._minPercentSeen = num1
    end
    if self._maxPercentSeen == nil or self._maxPercentSeen < num1 then
        self._maxPercentSeen = num1
    end
end

local function updateVideoBand(tbl3, bool1: boolean, bool2: boolean, threshold: number, threshold2: number, num1: number, enteredAtMs: number)
    if tbl3.pendingContinuity then
        if bool2 and tbl3.threshold <= threshold2 then
            tbl3.pendingContinuity = false
            tbl3.enteredAtMs = enteredAtMs
            local currentContinuousMs = tbl3.currentContinuousMs
            if bool1 and currentContinuousMs ~= nil then
                tbl3.currentContinuousMs = currentContinuousMs + num1
                return
            end

            return
        end

        closeWindow(tbl3, nil)
        return
    end

    if not bool1 or not (tbl3.threshold <= threshold2) then
        closeWindow(tbl3, nil)
        return
    end

    if threshold < tbl3.threshold then
        closeWindow(tbl3, nil)

        if bool2 then
            tbl3.enteredAtMs = enteredAtMs
        end
        return
    end
    if tbl3.enteredAtMs == nil then
        tbl3.enteredAtMs = enteredAtMs
    end
    local currentContinuousMs = tbl3.currentContinuousMs
    if currentContinuousMs == nil then
        tbl3.enteredAtMs = nil
        tbl3.pendingContinuity = false
        return
    end
    tbl3.currentContinuousMs = currentContinuousMs + num1
    if not bool2 then
        closeWindow(tbl3, nil)
    end
end

local function updateModeBand(tbl3, bool1: boolean, bool2: boolean, bool3: boolean, threshold: number, num1: number, num2: number, lastSampleMs: number) -- Luacid: Inlined by compiler; 2 call sites recovered
    local bool4 = bool1 or tbl3.pendingContinuity == true
    updateVideoBand(tbl3, bool2 and bool4, bool3 and bool4, threshold, num1, num2, lastSampleMs)
end

local function observedVideoMovementMs(num1: number?, playbackPositionMs: number?, num2: number?, loopCount: number?, lengthMs: number?): number -- Luacid: Inlined by compiler; 1 call site recovered
    if num1 == nil or playbackPositionMs == nil or num2 == nil or loopCount == nil then
        return 0
    end
    if loopCount < num2 then
        return 0
    end
    local num3 = loopCount - num2
    if num3 == 0 then
        return math.max(0, playbackPositionMs - num1)
    end

    if lengthMs == nil or lengthMs <= 0 then
        return 0
    end
    return math.max(0, num3 * lengthMs + playbackPositionMs - num1)
end

local function videoProgressPercent(bool1: boolean, lengthMs: number?, playbackPositionMs: number): number -- Luacid: Inlined by compiler; 1 call site recovered
    if bool1 then
        return 100
    end
    if lengthMs == nil or lengthMs <= 0 then
        return 0
    end
    return math.clamp(playbackPositionMs / lengthMs * 100, 0, 100)
end

function module:_buildVideoProgressMilestone(videoProgress: number, tbl3)
    local _video = self._video
    local _inGridBand50 = self._inGridBand50
    local _fullscreenBand50 = self._fullscreenBand50
    if _video == nil or _inGridBand50 == nil or _fullscreenBand50 == nil then
        return nil
    end
    local cumulative30PercentInViewDurationMs, maxContinuous30PercentInViewDurationMs = durationAsOf(self._band30, nil)
    local cumulative50PercentInViewDurationMs, maxContinuous50PercentInViewDurationMs = durationAsOf(self._band50, nil)
    local cumulative100PercentInViewDurationMs, maxContinuous100PercentInViewDurationMs = durationAsOf(self._band100, nil)
    local cumulativeMs = _inGridBand50.cumulativeMs
    local maxContinuousMs = _inGridBand50.maxContinuousMs
    local enteredAtMs = _inGridBand50.enteredAtMs
    local currentContinuousMs = _inGridBand50.currentContinuousMs
    local var7 = nil
    if currentContinuousMs ~= nil then
        if enteredAtMs ~= nil or _inGridBand50.pendingContinuity then
            var7 = currentContinuousMs
        end
    elseif enteredAtMs ~= nil then
        var7 = assert(nil, "image band requires the current timestamp") - enteredAtMs
    end
    if var7 ~= nil then
        cumulativeMs += var7
        if maxContinuousMs < var7 then
        end
    end

    local cumulativeMs2 = _fullscreenBand50.cumulativeMs
    local maxContinuousMs2 = _fullscreenBand50.maxContinuousMs
    local enteredAtMs2 = _fullscreenBand50.enteredAtMs
    local currentContinuousMs2 = _fullscreenBand50.currentContinuousMs
    local var8 = nil
    if currentContinuousMs2 ~= nil then
        if enteredAtMs2 ~= nil or _fullscreenBand50.pendingContinuity then
            var8 = currentContinuousMs2
        end
    elseif enteredAtMs2 ~= nil then
        var8 = assert(nil, "image band requires the current timestamp") - enteredAtMs2
    end
    if var8 ~= nil then
        cumulativeMs2 += var8
        if maxContinuousMs2 < var8 then
        end
    end

    return {
        geometry = copyGeometry(tbl3),
        viewabilitySessionStartTimestampMs = self.startTimestampMs,
        cumulative30PercentInViewDurationMs = cumulative30PercentInViewDurationMs,
        cumulative50PercentInViewDurationMs = cumulative50PercentInViewDurationMs,
        cumulative100PercentInViewDurationMs = cumulative100PercentInViewDurationMs,
        maxContinuous30PercentInViewDurationMs = maxContinuous30PercentInViewDurationMs,
        maxContinuous50PercentInViewDurationMs = maxContinuous50PercentInViewDurationMs,
        maxContinuous100PercentInViewDurationMs = maxContinuous100PercentInViewDurationMs,
        videoProgress = videoProgress,
        videoLengthMs = _video.lengthMs,
        videoCumulativePlaytimeMs = _video.cumulativePlaytimeMs,
        cumulativeAudioPlaybackDurationMs = _video.cumulativeAudioPlaybackMs,
        cumulative100PercentAudibleTimeMs = _video.cumulative100PercentAudibleMs,
        maxAudioLevel = _video.maxAudioLevel,
        audioOnAtEvent = _video.audioOnAtEvent,
        isFullScreen = _video.isFullscreen,
        cumulativeInGridViewDurationMs = cumulativeMs,
        cumulativeFullScreenViewDurationMs = cumulativeMs2
    }
end

function module:_advanceVideo(lastSampleMs: number, threshold: number, num1: number, tbl3, arg1, isFullscreen: boolean)
    local tbl4 = {}
    if self._video == nil or self._inGridBand50 == nil or self._fullscreenBand50 == nil then
        closeWindow(self._band30, nil)
        closeWindow(self._band50, nil)
        closeWindow(self._band100, nil)
        return tbl4, false, false
    end
    local _video = self._video
    local _inGridBand50 = self._inGridBand50
    local _fullscreenBand50 = self._fullscreenBand50
    local lastSampleMs2 = _video.lastSampleMs
    local lastSnapshot = _video.lastSnapshot

    if arg1 ~= nil and not isValidVideoPlaybackSnapshot(arg1) then
        arg1 = nil
    end

    _video.isFullscreen = isFullscreen
    _video.audioOnAtEvent = audioOn(arg1)
    if arg1 == nil then
        local _band30 = self._band30

        if _band30.pendingContinuity then
            closeWindow(_band30, nil)
        else
            closeWindow(_band30, nil)
        end

        local _band50 = self._band50

        if _band50.pendingContinuity then
            closeWindow(_band50, nil)
        else
            closeWindow(_band50, nil)
        end

        local _band100 = self._band100

        if _band100.pendingContinuity then
            closeWindow(_band100, nil)
        else
            closeWindow(_band100, nil)
        end

        if _inGridBand50.pendingContinuity then
            closeWindow(_inGridBand50, nil)
        else
            closeWindow(_inGridBand50, nil)
        end

        if _fullscreenBand50.pendingContinuity then
            closeWindow(_fullscreenBand50, nil)
        else
            closeWindow(_fullscreenBand50, nil)
        end

        _video.lastSampleMs = lastSampleMs
        _video.lastSnapshot = nil
        return tbl4, false, false
    end
    if arg1.videoLengthMs ~= nil then
        _video.lengthMs = arg1.videoLengthMs
    end
    local playbackPositionMs = arg1.playbackPositionMs
    local loopCount = arg1.loopCount
    local endedCount = arg1.endedCount or 0
    local endedCount2 = if lastSnapshot then lastSnapshot.endedCount or 0 else nil
    local playbackPositionMs2 = if lastSnapshot then lastSnapshot.playbackPositionMs else nil
    local loopCount2 = if lastSnapshot then lastSnapshot.loopCount else nil
    local num2 = observedVideoMovementMs(playbackPositionMs2, playbackPositionMs, loopCount2, loopCount, _video.lengthMs)
    local bool1 = not (lastSnapshot == nil) and lastSnapshot.loopCount < loopCount
    local bool2 = not (endedCount2 == nil) and endedCount < endedCount2
    local bool3 = not (endedCount2 == nil) and not bool2 and endedCount2 < endedCount
    local bool4 = bool1 or bool3
    local isPlaying = not (lastSnapshot == nil) and lastSnapshot.isPlaying
    local isPlaying2 = arg1.isPlaying
    if isPlaying then
        if num2 > 0 then
            isPlaying = not bool2 and (isPlaying2 or bool3)
        else
            isPlaying = false
        end
    end
    local var1 = isPlaying and isPlaying2 and not bool3

    local var2 = if lastSampleMs2 == nil then 0 else lastSampleMs - lastSampleMs2

    local num3 = if isPlaying then math.min(var2, num2) else 0
    local var3 = bool3 and isPlaying and tbl3 ~= nil
    local var4 = isPlaying2 or var3

    for _, value in { self._band30, self._band50, self._band100 } do
        updateVideoBand(value, isPlaying, var4, threshold, num1, num3, lastSampleMs)
    end

    updateModeBand(_inGridBand50, not isFullscreen, isPlaying, var4, threshold, num1, num3, lastSampleMs)
    updateModeBand(_fullscreenBand50, isFullscreen, isPlaying, var4, threshold, num1, num3, lastSampleMs)

    if isPlaying then
        _video.cumulativePlaytimeMs += num3

        if lastSnapshot ~= nil and audioOn(lastSnapshot) and (audioOn(arg1) or bool3) then
            _video.cumulativeAudioPlaybackMs += num3
            _video.maxAudioLevel = math.max(_video.maxAudioLevel, lastSnapshot.audioLevel, arg1.audioLevel)
            if threshold >= 1 and num1 >= 1 then
                _video.cumulative100PercentAudibleMs += num3
            end
        end
    end

    if (isPlaying or bool4) and tbl3 ~= nil then
        local num4 = videoProgressPercent(bool4, _video.lengthMs, playbackPositionMs)

        for _, highestProgress in tbl1 do
            if _video.highestProgress ~= nil and not (_video.highestProgress < highestProgress) or not (highestProgress <= num4) then
                continue
            end

            local var5 = self:_buildVideoProgressMilestone(highestProgress, tbl3)
            if var5 ~= nil then
                _video.highestProgress = highestProgress
                table.insert(tbl4, var5)
            end
        end
    end

    _video.lastSampleMs = lastSampleMs
    _video.lastSnapshot = arg1

    return tbl4, var1, var3
end

function module:transitionVideoSource(_lastSampleMs: number, bool1: boolean?)
    local _video = self._video
    local _inGridBand50 = self._inGridBand50
    local _fullscreenBand50 = self._fullscreenBand50
    if self._finalized or self._pausedAtMs ~= nil or _video == nil or _inGridBand50 == nil or _fullscreenBand50 == nil then
        return
    end
    _lastSampleMs = math.max(_lastSampleMs, _video.lastSampleMs or self.startTimestampMs)

    if bool1 then
        for _, value in { self._band30, self._band50, self._band100 } do
            preserveVideoBandAcrossSourceChange(value)
        end

        if _video.isFullscreen then
            closeWindow(_inGridBand50, nil)
            preserveVideoBandAcrossSourceChange(_fullscreenBand50)
        else
            preserveVideoBandAcrossSourceChange(_inGridBand50)
            closeWindow(_fullscreenBand50, nil)
        end
    else
        for _, value in { self._band30, self._band50, self._band100 } do
            closeWindow(value, nil)
        end

        closeWindow(_inGridBand50, nil)
        closeWindow(_fullscreenBand50, nil)
    end

    if not bool1 then
        _video.lastSampleMs = nil
        _video.lastSnapshot = nil
    end
    _video.audioOnAtEvent = false
    self._lastSampleMs = _lastSampleMs
    self._lastRatio = 0
    self._lastRealEstate = 0
end

function module:pause(_pausedAtMs: number)
    local bool1 = self._video ~= nil
    if bool1 then
        if self._finalized or self._pausedAtMs ~= nil then
            return
        end
        _pausedAtMs = math.max(_pausedAtMs, self._lastSampleMs or self.startTimestampMs)
    else
        assert(not self._finalized, "pause called after finalize")
        assert(self._pausedAtMs == nil, "pause called while already paused")
        assert((self._lastSampleMs or self.startTimestampMs) <= _pausedAtMs, "pause timestamp precedes the last sample")
    end

    self:_accumulate(_pausedAtMs, 0, nil)
    if bool1 then
        local _video = self._video
        closeWindow(self._band30, nil)
        closeWindow(self._band50, nil)
        closeWindow(self._band100, nil)
        local _inGridBand50 = self._inGridBand50
        local _fullscreenBand50 = self._fullscreenBand50
        if _inGridBand50 ~= nil then
            closeWindow(_inGridBand50, nil)
        end

        if _fullscreenBand50 ~= nil then
            closeWindow(_fullscreenBand50, nil)
        end

        _video.lastSampleMs = nil
        _video.lastSnapshot = nil
        _video.audioOnAtEvent = false
    else
        closeWindow(self._band30, _pausedAtMs)
        closeWindow(self._band50, _pausedAtMs)
        closeWindow(self._band100, _pausedAtMs)
    end
    self._pausedAtMs = _pausedAtMs
end

function module:resume(_lastSampleMs: number)
    local _pausedAtMs = self._pausedAtMs
    if self._video ~= nil then
        if self._finalized or _pausedAtMs == nil then
            return
        end
        _lastSampleMs = math.max(_lastSampleMs, _pausedAtMs)
    else
        assert(not self._finalized, "resume called after finalize")
        assert(_pausedAtMs ~= nil, "resume called while not paused")
        assert(_pausedAtMs <= _lastSampleMs, "resume timestamp precedes pause")
    end

    self._pausedDurationMs += _lastSampleMs - _pausedAtMs
    self._pausedAtMs = nil
    self._lastSampleMs = _lastSampleMs
    self._lastRatio = 0
    self._lastRealEstate = 0
end

function module:_advance_deprecated(enteredAtMs: number, threshold: number, _latchedGeometry)
    assert(not self._finalized, "advance called after finalize")
    assert(self._pausedAtMs == nil, "advance called while paused")
    local result = {}

    if _latchedGeometry ~= nil then
        self:_classifyDisplayOnce(_latchedGeometry.adSize)
        self._latchedGeometry = _latchedGeometry
    end

    self:_accumulate(enteredAtMs, threshold, _latchedGeometry)

    updateBandTimer(self._band30, threshold, enteredAtMs)
    updateBandTimer(self._band50, threshold, enteredAtMs)
    updateBandTimer(self._band100, threshold, enteredAtMs)

    if _latchedGeometry == nil then
        return result
    end

    local _displayLabel = self._displayLabel
    if _displayLabel ~= nil then
        local var1 = if _displayLabel == MilestoneLabels.IabDisplayLarge then self._band30 else self._band50
        self:_tryFire(var1, _displayLabel, enteredAtMs, _latchedGeometry, result)
    end
    self:_tryFire(self._band100, MilestoneLabels.FullView, enteredAtMs, _latchedGeometry, result)

    return result
end

function module:advance(num1: number, num2: number, _latchedGeometry, arg1, bool1: boolean?)
    if self._video == nil then
        return self:_advance_deprecated(num1, num2, _latchedGeometry)
    end

    local tbl3 = {}
    if self._finalized or self._pausedAtMs ~= nil or num1 < (self._lastSampleMs or self.startTimestampMs) then
        return tbl3, {}
    end

    if _latchedGeometry ~= nil then
        self._latchedGeometry = _latchedGeometry
    end

    local _lastRatio = self._lastRatio
    self:_accumulate(num1, num2, _latchedGeometry)

    local var1, var2, var3 = self:_advanceVideo(num1, _lastRatio, num2, _latchedGeometry, arg1, bool1 == true)

    if _latchedGeometry == nil then
        return tbl3, var1
    end

    if var2 or var3 then
        self:_tryFire(self._band50, MilestoneLabels.IabVideoStandard, num1, _latchedGeometry, tbl3, 2000)

        self:_tryFire(self._band100, MilestoneLabels.FullViewVideo, num1, _latchedGeometry, tbl3, 1000)
    end
    if var3 then
        closeWindow(self._band30, nil)
        closeWindow(self._band50, nil)
        closeWindow(self._band100, nil)
        local _inGridBand50 = self._inGridBand50
        local _fullscreenBand50 = self._fullscreenBand50
        if _inGridBand50 ~= nil then
            closeWindow(_inGridBand50, nil)
        end

        if _fullscreenBand50 ~= nil then
            closeWindow(_fullscreenBand50, nil)
            return tbl3, var1
        end
    end

    return tbl3, var1
end

function module:_finalize_deprecated(viewabilitySessionEndTimestampMs: number)
    assert(not self._finalized, "finalize called more than once on the same session")
    self._finalized = true

    self:_accumulate(viewabilitySessionEndTimestampMs, self._lastRatio, self._latchedGeometry)
    closeWindow(self._band30, viewabilitySessionEndTimestampMs)
    closeWindow(self._band50, viewabilitySessionEndTimestampMs)
    closeWindow(self._band100, viewabilitySessionEndTimestampMs)

    local _visibleWeightedMs = self._visibleWeightedMs
    local _latchedGeometry = self._latchedGeometry
    local _pausedDurationMs = self._pausedDurationMs
    local _pausedAtMs = self._pausedAtMs
    if _pausedAtMs ~= nil then
        assert(_pausedAtMs <= viewabilitySessionEndTimestampMs, "session end precedes pause")
        _pausedDurationMs += viewabilitySessionEndTimestampMs - _pausedAtMs
    end
    return {
        geometry = _latchedGeometry == nil and {
            adSize = Vector2.zero,
            viewportBounds = {
                min = Vector2.zero,
                max = Vector2.zero
            }
        }
            or {
                adSize = _latchedGeometry.adSize,
                viewportBounds = {
                    min = _latchedGeometry.viewportBounds.min,
                    max = _latchedGeometry.viewportBounds.max
                }
            },
        viewabilitySessionStartTimestampMs = self.startTimestampMs,
        viewabilitySessionEndTimestampMs = viewabilitySessionEndTimestampMs,
        dwellDurationMs = viewabilitySessionEndTimestampMs - self.startTimestampMs - _pausedDurationMs,
        cumulative30PercentInViewDurationMs = self._band30.cumulativeMs,
        cumulative50PercentInViewDurationMs = self._band50.cumulativeMs,
        cumulative100PercentInViewDurationMs = self._band100.cumulativeMs,
        maxContinuous30PercentInViewDurationMs = self._band30.maxContinuousMs,
        maxContinuous50PercentInViewDurationMs = self._band50.maxContinuousMs,
        maxContinuous100PercentInViewDurationMs = self._band100.maxContinuousMs,
        averagePercentSeen = if _visibleWeightedMs > 0 then self._percentWeightedSum / _visibleWeightedMs else 0,
        minPercentSeen = self._minPercentSeen or 0,
        maxPercentSeen = self._maxPercentSeen or 0,
        averageOnScreenRealEstate = if _visibleWeightedMs > 0 then self._realEstateWeightedSum / _visibleWeightedMs else 0
    }
end

function module:finalize(viewabilitySessionEndTimestampMs: number)
    if self._video == nil then
        return self:_finalize_deprecated(viewabilitySessionEndTimestampMs)
    end

    if self._finalized then
        return self._terminalSnapshot
    end
    local _video = self._video
    local _inGridBand50 = self._inGridBand50
    local _fullscreenBand50 = self._fullscreenBand50
    viewabilitySessionEndTimestampMs = math.max(
        viewabilitySessionEndTimestampMs,
        self.startTimestampMs,
        self._lastSampleMs or self.startTimestampMs,
        self._pausedAtMs or self.startTimestampMs
    )
    if _video == nil or _inGridBand50 == nil or _fullscreenBand50 == nil then
        local _terminalSnapshot = self:_finalize_deprecated(viewabilitySessionEndTimestampMs)
        self._terminalSnapshot = _terminalSnapshot
        return _terminalSnapshot
    end
    self._finalized = true

    self:_accumulate(viewabilitySessionEndTimestampMs, self._lastRatio, self._latchedGeometry)
    closeWindow(self._band30, nil)
    closeWindow(self._band50, nil)
    closeWindow(self._band100, nil)
    closeWindow(_inGridBand50, nil)
    closeWindow(_fullscreenBand50, nil)
    local _visibleWeightedMs = self._visibleWeightedMs
    local _latchedGeometry = self._latchedGeometry
    local _pausedDurationMs = self._pausedDurationMs
    local _pausedAtMs = self._pausedAtMs
    if _pausedAtMs ~= nil then
        _pausedDurationMs += viewabilitySessionEndTimestampMs - _pausedAtMs
    end
    local _terminalSnapshot = {
        geometry = _latchedGeometry == nil and {
            adSize = Vector2.zero,
            viewportBounds = {
                min = Vector2.zero,
                max = Vector2.zero
            }
        }
            or copyGeometry(_latchedGeometry),
        viewabilitySessionStartTimestampMs = self.startTimestampMs,
        viewabilitySessionEndTimestampMs = viewabilitySessionEndTimestampMs,
        dwellDurationMs = viewabilitySessionEndTimestampMs - self.startTimestampMs - _pausedDurationMs,
        cumulative30PercentInViewDurationMs = self._band30.cumulativeMs,
        cumulative50PercentInViewDurationMs = self._band50.cumulativeMs,
        cumulative100PercentInViewDurationMs = self._band100.cumulativeMs,
        maxContinuous30PercentInViewDurationMs = self._band30.maxContinuousMs,
        maxContinuous50PercentInViewDurationMs = self._band50.maxContinuousMs,
        maxContinuous100PercentInViewDurationMs = self._band100.maxContinuousMs,
        averagePercentSeen = if _visibleWeightedMs > 0 then self._percentWeightedSum / _visibleWeightedMs else 0,
        minPercentSeen = self._minPercentSeen or 0,
        maxPercentSeen = self._maxPercentSeen or 0,
        averageOnScreenRealEstate = if _visibleWeightedMs > 0 then self._realEstateWeightedSum / _visibleWeightedMs else 0,
        isFullScreen = _video.isFullscreen,
        videoProgress = _video.highestProgress,
        videoLengthMs = _video.lengthMs,
        videoCumulativePlaytimeMs = _video.cumulativePlaytimeMs,
        cumulativeAudioPlaybackDurationMs = _video.cumulativeAudioPlaybackMs,
        cumulative100PercentAudibleTimeMs = _video.cumulative100PercentAudibleMs,
        maxAudioLevel = _video.maxAudioLevel,
        audioOnAtEvent = if _video.highestProgress == nil then nil else _video.audioOnAtEvent,
        cumulativeInGridViewDurationMs = _inGridBand50.cumulativeMs,
        cumulativeFullScreenViewDurationMs = _fullscreenBand50.cumulativeMs
    }

    self._terminalSnapshot = _terminalSnapshot
    return _terminalSnapshot
end

module.MilestoneLabels = MilestoneLabels
module.MilestoneDurationMs = 1000

return module
