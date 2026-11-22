-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T02:30:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local IntervalPerformanceTracker = script:FindFirstAncestor("IntervalPerformanceTracker")
local IntervalPerformanceTrackerParent = IntervalPerformanceTracker.Parent

local default = require(IntervalPerformanceTrackerParent.LoggingProtocol).default
local MockableProxyServices = require(IntervalPerformanceTrackerParent.MockableProxyServices)
local RunService = MockableProxyServices.RunService

local var1 = require(IntervalPerformanceTracker.Logger):new(script.Name)
local IntervalPerformanceTrackerTelemetryConfig = require(script.Parent.IntervalPerformanceTrackerTelemetryConfig)
game:DefineFastFlag("DebugPrintIntervalPerformanceTrackerResults", false)
local sendFPSStat = require(script.Parent.sendFPSStat)
local sendScrollFrameCounters = require(script.Parent.sendScrollFrameCounters)
local bool1 = game:DefineFastFlag("AXFixAverageFPSCasing", false)

local bool2 = game:DefineFastFlag("AXIntervalPerformanceTrackerFPSStandardDeviation", false)

local bool3 = game:DefineFastFlag("AXIntervalPerformanceTrackerScrollFrameCounters", false)

local bool4 = game:DefineFastFlag("IntervalPerformanceTrackerScrollPositionSamples", false)

local bool5 = game:DefineFastFlag("IntervalPerformanceTrackerCancelOnAppHide", false)

local GetFIntIntervalPerformanceTrackerEventStream = require(IntervalPerformanceTrackerParent.SharedFlags).GetFIntIntervalPerformanceTrackerEventStream

local num1 = math.random(0, 1000)
local fIntIntervalPerformanceTrackerEventStream = GetFIntIntervalPerformanceTrackerEventStream()
local bool6 = num1 < fIntIntervalPerformanceTrackerEventStream

local function isSessionSampled(num2: number): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return num2 >= 1000 or num1 < math.max(num2, fIntIntervalPerformanceTrackerEventStream)
end

local _metricsTrackers = {
    averageFPS = {
        reducer = function(tbl1)
            return {
                framesCount = if tbl1.framesCount == nil then 0 else tbl1.framesCount + 1,
                startTime = tbl1.startTime or tick()
            }
        end,
        getResult = function(tbl1)
            local now = tick()

            if tbl1.framesCount == nil or tbl1.framesCount == 0 or tbl1.startTime == nil or now == tbl1.startTime then
                return nil
            end

            return tbl1.framesCount / (now - tbl1.startTime)
        end
    },
    framesCount = {
        reducer = function(tbl1)
            return {
                framesCount = if tbl1.framesCount == nil then 0 else tbl1.framesCount + 1
            }
        end,
        getResult = function(arg1)
            return arg1.framesCount
        end
    },
    longestFrameTime = {
        reducer = function(tbl1)
            local tbl2 = {
                framesCount = if tbl1.framesCount == nil then 0 else tbl1.framesCount + 1,
                longestFrameTime = if tbl1.longestFrameTime == nil or tbl1.previousTime == nil then 0 else math.max(tbl1.longestFrameTime, tick() - tbl1.previousTime),
                previousTime = tick()
            }
            return tbl2
        end,
        getResult = function(arg1)
            return if arg1.framesCount < 1 then nil else arg1.longestFrameTime
        end
    },
    duration = {
        reducer = function(tbl1)
            return {
                startTime = tbl1.startTime or tick()
            }
        end,
        getResult = function(arg1)
            return tick() - arg1.startTime
        end
    }
}

if bool2 then
    _metricsTrackers.standardDeviationFPS = {
        reducer = function(tbl2)
            local previousTime = tick()
            local framesCount = tbl2.framesCount or 0
            local sumFps = tbl2.sumFPS or 0
            local sumSquaredFps = tbl2.sumSquaredFPS or 0

            if tbl2.previousTime ~= nil and tbl2.previousTime < previousTime then
                local var2 = 1 / (previousTime - tbl2.previousTime)
                framesCount += 1
                sumFps += var2
                sumSquaredFps += var2 * var2
            end

            return {
                framesCount = framesCount,
                previousTime = previousTime,
                sumFPS = sumFps,
                sumSquaredFPS = sumSquaredFps
            }
        end,
        getResult = function(tbl2)
            if tbl2.framesCount == nil or tbl2.framesCount < 1 then
                return nil
            end

            local var2 = (tbl2.sumFPS or 0) / tbl2.framesCount
            return math.sqrt(math.max((tbl2.sumSquaredFPS or 0) / tbl2.framesCount - var2 * var2, 0))
        end
    }
end

local availableMetricsEnum = ({})
local tbl3 = {}
for value, _ in _metricsTrackers do
    availableMetricsEnum[value] = value
    table.insert(tbl3, value)
end

local var2 = not bool3 and {
    "under_16",
    "16_to_16_7",
    "16_7_to_17_5",
    "17_5_to_18",
    "18_to_21",
    "21_to_25",
    "over_25"
}
    or require(script.Parent.ScrollFrameBands).FRAME_BUCKET_KEYS

local tbl4 = { "rawFrameTimesMs", "rawScrollPositionSamplesCsv" }

local function bucketKeyForFrameTimeMs(num2: number): string -- Luacid: Inlined by compiler; 1 call site recovered
    if num2 < 16 then
        return "under_16"
    end

    if num2 < 50 / 3 then
        return "16_to_16_7"
    end

    if num2 < 17.5 then
        return "16_7_to_17_5"
    end

    if num2 < 18 then
        return "17_5_to_18"
    end

    if num2 < 21 then
        return "18_to_21"
    end

    if num2 < 25 then
        return "21_to_25"
    end

    return "over_25"
end

local function percentile(tbl5, num2: number) -- Luacid: unused: defined but never referenced
    local num3 = #tbl5
    local num4 = math.ceil(num2 / 100 * num3)
    if num4 < 1 then
        num3 = 1
    elseif not (num3 < num4) then
        num3 = num4
    end

    return tbl5[num3]
end

local function roundTo(num2: number, num3: number): number -- Luacid: unused: defined but never referenced
    local num4 = 10 ^ num3
    return math.round(num2 * num4) / num4
end

local function appendFrameSample(frames, previousTime: number?, previousTime2: number) -- Luacid: Inlined by compiler; 2 call sites recovered
    if previousTime ~= nil then
        table.insert(frames, (previousTime2 - previousTime) * 1000)
    end
end

local HttpService = game:GetService("HttpService")

_metricsTrackers.rawFrameTimesMs = {
    reducer = function(tbl5, previousTime: number)
        local frames = tbl5.frames or {}
        appendFrameSample(frames, tbl5.previousTime, previousTime)
        return { frames = frames, previousTime = previousTime }
    end,
    getResult = function(tbl5)
        if tbl5.frames == nil or #tbl5.frames < 1 then
            return nil
        end
        local input = {}
        for _, value in tbl5.frames do
            table.insert(input, math.round(value * 100) / 100)
        end
        return HttpService:JSONEncode(input)
    end
}

if bool4 then
    _metricsTrackers.rawScrollPositionSamplesCsv = {
        reducer = function(tbl5, num2: number, num3: number?)
            local timestampsMs = tbl5.timestampsMs or {}
            local positionsY = tbl5.positionsY or {}

            if tbl5.startTime ~= nil and num3 ~= nil then
                table.insert(timestampsMs, (num2 - tbl5.startTime) * 1000)
                table.insert(positionsY, num3)
            end
            return {
                timestampsMs = timestampsMs,
                positionsY = positionsY,
                startTime = tbl5.startTime or num2
            }
        end,
        getResult = function(tbl5)
            local timestampsMs = tbl5.timestampsMs
            local positionsY = tbl5.positionsY
            if timestampsMs == nil or positionsY == nil or #timestampsMs < 1 then
                return nil
            end
            local var3 = table.create(#timestampsMs)
            for k, timestampsM in timestampsMs do
                local num2 = math.round(timestampsM * 100) / 100
                local var4 = positionsY[k] * 100
                var3[k] = `{num2},{math.round(var4) / 100}`
            end
            return HttpService:JSONEncode(table.concat(var3, "\n"))
        end
    }
end

_metricsTrackers.frameTimeAvgMs = {
    reducer = function(tbl5, previousTime: number)
        local framesCount = tbl5.framesCount or 0
        local sumMs = tbl5.sumMs or 0
        if tbl5.previousTime ~= nil then
            framesCount += 1
            sumMs += (previousTime - tbl5.previousTime) * 1000
        end
        return { framesCount = framesCount, sumMs = sumMs, previousTime = previousTime }
    end,
    getResult = function(tbl5)
        if tbl5.framesCount == nil or tbl5.framesCount < 1 then
            return nil
        end

        return tbl5.sumMs / tbl5.framesCount
    end
}

_metricsTrackers.frameTimeStdDevMs = {
    reducer = function(tbl5, previousTime: number)
        local framesCount = tbl5.framesCount or 0
        local sumMs = tbl5.sumMs or 0
        local sumSquaredMs = tbl5.sumSquaredMs or 0
        if tbl5.previousTime ~= nil then
            local var3 = (previousTime - tbl5.previousTime) * 1000
            framesCount += 1
            sumMs += var3
            sumSquaredMs += var3 * var3
        end
        return {
            framesCount = framesCount,
            sumMs = sumMs,
            sumSquaredMs = sumSquaredMs,
            previousTime = previousTime
        }
    end,
    getResult = function(tbl5)
        if tbl5.framesCount == nil or tbl5.framesCount < 1 then
            return nil
        end
        local var3 = tbl5.sumMs / tbl5.framesCount
        return math.sqrt(math.max(tbl5.sumSquaredMs / tbl5.framesCount - var3 * var3, 0))
    end
}

_metricsTrackers.frameTimeDistributionMs = {
    reducer = function(tbl5, previousTime: number)
        local frames = tbl5.frames or {}
        appendFrameSample(frames, tbl5.previousTime, previousTime)
        return { frames = frames, previousTime = previousTime }
    end,
    getResult = function(tbl5)
        if tbl5.frames == nil or #tbl5.frames < 1 then
            return nil
        end
        local var3 = table.clone(tbl5.frames)
        table.sort(var3)
        local httpService = HttpService
        local input = { p50 = 0, p95 = 0, p99 = 0 }
        local num2 = #var3
        local num3 = math.ceil(num2 * 0.5)
        if num3 < 1 then
            num2 = 1
        elseif not (num2 < num3) then
            num2 = num3
        end

        input.p50 = math.round(var3[num2] * 100) / 100
        local num4 = #var3
        local num5 = math.ceil(num4 * 0.95)
        if num5 < 1 then
            num4 = 1
        elseif not (num4 < num5) then
            num4 = num5
        end

        input.p95 = math.round(var3[num4] * 100) / 100
        local num6 = #var3
        local num7 = math.ceil(num6 * 0.99)
        if num7 < 1 then
            num6 = 1
        elseif not (num6 < num7) then
            num6 = num7
        end

        input.p99 = math.round(var3[num6] * 100) / 100
        return httpService:JSONEncode(input)
    end
}

_metricsTrackers.frameBuckets = {
    reducer = function(tbl5, previousTime: number)
        local counts

        if tbl5.counts ~= nil then
            counts = tbl5.counts
        else
            counts = {}
            for _, value in var2 do
                counts[value] = 0
            end
        end
        if tbl5.previousTime ~= nil then
            local str1 = bucketKeyForFrameTimeMs((previousTime - tbl5.previousTime) * 1000)

            counts[str1] += 1
        end
        return { counts = counts, previousTime = previousTime }
    end,
    getResult = function(tbl5)
        if tbl5.counts == nil then
            return nil
        end
        return HttpService:JSONEncode(tbl5.counts)
    end
}

for _, value in {
    "rawFrameTimesMs",
    "frameTimeAvgMs",
    "frameTimeStdDevMs",
    "frameTimeDistributionMs",
    "frameBuckets"
} do
    availableMetricsEnum[value] = value
end
if bool4 then
    availableMetricsEnum.rawScrollPositionSamplesCsv = "rawScrollPositionSamplesCsv"
end

local tbl5 = {}
tbl5.__index = tbl5

function tbl5.new(_timeout: number?, _metricsToTrack, _countersEnabled: boolean?, _eventStreamEnabled: boolean?, _extraFields, _scrollFrame)
    local tbl6 = {
        _metricsData = {},
        _timeout = _timeout,
        _startTime = nil,
        _metricsToTrack = _metricsToTrack,
        _countersEnabled = _countersEnabled,
        _eventStreamEnabled = _eventStreamEnabled,
        _extraFields = _extraFields,
        _scrollFrame = _scrollFrame
    }
    setmetatable(tbl6, tbl5)
    return tbl6
end

function tbl5:getMetricsToTrack()
    return if self._metricsToTrack and #self._metricsToTrack > 0 then self._metricsToTrack else tbl3
end

function tbl5:hasReachedTimeout(): boolean
    return not (self._timeout == nil or self._startTime == nil) and tick() - self._startTime > self._timeout
end

function tbl5:updateMetrics()
    if self._startTime == nil then
        self._startTime = tick()
    end

    local now = tick()
    local canvasPositionY = if bool4 and self._scrollFrame then self._scrollFrame.CanvasPosition.Y else nil

    for _, value in (self:getMetricsToTrack()) do
        local var3 = _metricsTrackers[value]
        if not var3 then
            continue
        end

        if not self._metricsData[value] then
            self._metricsData[value] = {}
        end
        self._metricsData[value] = var3.reducer(self._metricsData[value], now, canvasPositionY)
    end
end

function tbl5:getResult()
    local result = ({})
    for _, value in (self:getMetricsToTrack()) do
        local var3 = _metricsTrackers[value]
        if var3 then
            result[value] = var3.getResult(self._metricsData[value])
        end
    end

    return result
end

local class = {}
class.__index = class

function class.new()
    local tbl7 = {
        _metricsTrackers = _metricsTrackers,
        _intervals = {},
        _renderSteppedConnection = nil,
        availableMetricsEnum = availableMetricsEnum
    }

    setmetatable(tbl7, class)

    if bool5 then
        local success, result = pcall(function()
            return MockableProxyServices.AppLifecycleObserverService
        end)
        if success and result then
            result.OnHide:Connect(function()
                table.clear(tbl7._intervals)
                tbl7:disconnectUnusedRenderStepped()
            end)
        end
    end

    return tbl7
end

function class:_updateIntervals()
    for k, _interval in self._intervals do
        _interval:updateMetrics()
        if _interval:hasReachedTimeout() then
            self:stopAndLogTracking(k)
        end
    end
end

function class:startTracking(str1: string, num2: number?, tbl7, bool7: boolean?, bool8: boolean?, tbl8, arg1, num3: number?)
    if num3 ~= nil then
        if not isSessionSampled(num3) then
            return
        end
    elseif not bool6 then
        return
    end

    if not self._intervals[str1] then
        local var3 = tbl5.new(num2, tbl7, bool7, bool8, tbl8, arg1)
        self._intervals[str1] = var3

        var3:updateMetrics()
    end

    if not self._renderSteppedConnection then
        self._renderSteppedConnection = RunService.RenderStepped:Connect(function()
            self:_updateIntervals()
        end)
    end
end

function class:_fireStatsTracking(tbl7)
    local averageFps = tbl7.averageFPS
    local framesCount = tbl7.framesCount
    local longestFrameTime = tbl7.longestFrameTime
    local intervalName = tbl7.intervalName

    local _interval = self._intervals[intervalName]

    if not _interval then
        var1:warning(`Missing interval {intervalName}`)
        return
    end

    local _countersEnabled = _interval._countersEnabled
    local _eventStreamEnabled = _interval._eventStreamEnabled

    local function makeStatName(str1: string, intervalName2: string): string -- Luacid: Inlined by compiler; 3 call sites recovered
        return "IntervalPerformanceTracker_" .. str1 .. "_" .. intervalName2
    end

    local function cloneWithoutBulkSamples() -- Luacid: Inlined by compiler; 3 call sites recovered
        local var3 = table.clone(tbl7)
        for _, value in tbl4 do
            var3[value] = nil
        end
        return var3
    end

    if not ((_countersEnabled or _eventStreamEnabled) and intervalName) then
        return
    end

    if averageFps then
        local statName = makeStatName("AverageFPS", intervalName)
        local metaData = if bool4 then cloneWithoutBulkSamples() else table.clone(tbl7)
        metaData.duration = averageFps
        metaData.averageFps = if bool1 then averageFps else nil
        sendFPSStat({
            statName = statName,
            eventStreamName = intervalName,
            metaData = metaData,
            interval = averageFps,
            excludeCounters = not _countersEnabled,
            excludeEventStream = not _eventStreamEnabled
        })
    end

    if framesCount and _countersEnabled then
        local statName = makeStatName("FramesCount", intervalName)
        local metaData = if bool4 then cloneWithoutBulkSamples() else table.clone(tbl7)
        metaData.duration = framesCount
        sendFPSStat({ statName = statName, metaData = metaData, interval = framesCount })
    end

    if longestFrameTime and _interval._countersEnabled then
        local statName = makeStatName("LongestFrameTime", intervalName)
        local metaData = if bool4 then cloneWithoutBulkSamples() else table.clone(tbl7)
        metaData.duration = longestFrameTime
        sendFPSStat({ statName = statName, metaData = metaData, interval = longestFrameTime })
    end

    if not bool3 or not _countersEnabled then
        return
    end

    local frameBuckets = tbl7.frameBuckets
    if not frameBuckets then
        return
    end

    sendScrollFrameCounters({ intervalName = intervalName, scrollType = tbl7.scroll_type, frameBucketsJson = frameBuckets })
end

function class:stopAndLogTracking(intervalName: string)
    if not (bool6 or self._intervals[intervalName]) then
        return
    end

    local _interval = self._intervals[intervalName]
    if _interval then
        local result = _interval:getResult()

        local tbl7 = { intervalName = intervalName }

        if _interval._extraFields then
            for k, _extraField in _interval._extraFields do
                tbl7[k] = _extraField
            end
        end

        local num2 = 0
        for value, value2 in result do
            if value2 ~= nil then
                num2 += 1
            end
            tbl7[value] = value2
        end

        if num2 > 0 then
            default:logRobloxTelemetryEvent(IntervalPerformanceTrackerTelemetryConfig, nil, tbl7)
            if game:GetFastFlag("DebugPrintIntervalPerformanceTrackerResults") then
                print("IntervalPerformanceTracker:" .. tostring(intervalName) .. " logged with results:")
                for value, value2 in tbl7 do
                    print("\t" .. tostring(value) .. " = " .. tostring(value2))
                end
            end
        end

        self:_fireStatsTracking(tbl7)

        self._intervals[intervalName] = nil
    end

    self:disconnectUnusedRenderStepped()
end

function class:cancelTracking(str1: string)
    if not (bool6 or self._intervals[str1]) then
        return
    end

    self._intervals[str1] = nil

    self:disconnectUnusedRenderStepped()
end

function class:disconnectUnusedRenderStepped()
    if not next(self._intervals) and self._renderSteppedConnection then
        self._renderSteppedConnection:Disconnect()
        self._renderSteppedConnection = nil
    end
end

class.class = class
return class.new()
