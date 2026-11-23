-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T10:30:40Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local var1 = require(AppChat.Logger):new("AppChatPerf")
local IntervalPerformanceTracker = require(AppChatParent.IntervalPerformanceTracker).IntervalPerformanceTracker

local AppChatPerfEvent = require(AppChat.Telemetry.AppChatPerfEvent)
local AppChatPerfEventInfo = require(AppChat.Telemetry.AppChatPerfEventInfo)
local AppChatTTITracker = require(AppChat.Telemetry.AppChatTTITracker)

local tbl1 = { "duration", "averageFPS", "longestFrameTime" }
local tbl2 = {
    "duration",
    "averageFPS",
    "framesCount",
    "longestFrameTime",
    "frameTimeAvgMs",
    "frameTimeStdDevMs",
    "frameTimeDistributionMs",
    "frameBuckets",
    "rawFrameTimesMs",
    "rawScrollPositionSamplesCsv"
}

local tbl3 = ({})

local function canStartInterval(arg1)
    local parentTti = AppChatPerfEventInfo.getParentTTI(arg1)
    local tTiPage = AppChatPerfEventInfo.getTTIPage(parentTti)

    if not AppChatTTITracker.isInteractive(parentTti) then
        return false, tTiPage .. "_not_interactive"
    end

    local interactiveTimestamp = AppChatTTITracker.getInteractiveTimestamp(parentTti)
    if interactiveTimestamp and os.clock() - interactiveTimestamp < 0.5 then
        return false, tTiPage .. "_interactive_settling_delay"
    end

    return true, nil
end

local function getMetricsToTrack(arg1): {any} -- Luacid: Inlined by compiler; 1 call site recovered
    return if arg1 == AppChatPerfEvent.ScrollConversationList or arg1 == AppChatPerfEvent.ScrollMessageList then tbl2 else tbl1
end

local module = {}

function module.start(arg1, _, arg2): boolean
    local intervalName = AppChatPerfEventInfo.getIntervalName(arg1)

    local bool1, var2 = canStartInterval(arg1)
    if not bool1 then
        var1:debug("Perf start ignored: {} (reason={})", arg1, var2 or "unknown")
        return false
    end

    var1:debug("Interval Start: {}", intervalName)
    local var3 = IntervalPerformanceTracker
    local metricsToTrack = getMetricsToTrack(arg1)
    local var4 = nil
    var3:startTracking(intervalName, var4, metricsToTrack, true, true, nil, arg2)

    tbl3[arg1] = true
    return true
end

function module.finish(arg1): boolean
    local intervalName = AppChatPerfEventInfo.getIntervalName(arg1)
    if not tbl3[arg1] then
        return false
    end
    var1:debug("Interval Stop: {}", intervalName)
    IntervalPerformanceTracker:stopAndLogTracking(intervalName)
    tbl3[arg1] = false
    return true
end

function module.cancel(arg1): boolean
    local intervalName = AppChatPerfEventInfo.getIntervalName(arg1)
    if not tbl3[arg1] then
        return false
    end
    var1:debug("Interval Cancel: {}", intervalName)
    IntervalPerformanceTracker:cancelTracking(intervalName)
    tbl3[arg1] = false
    return true
end

function module.isActive(arg1): boolean
    return tbl3[arg1] == true
end

function module.cancelIntervalsForTTI(arg1, str1: string)
    for _, value in (AppChatPerfEventInfo.getIntervalsForTTI(arg1)) do
        if tbl3[value] then
            local intervalName = AppChatPerfEventInfo.getIntervalName(value)
            var1:debug("Canceling interval ({}): {}", str1, intervalName)
            IntervalPerformanceTracker:cancelTracking(intervalName)
            tbl3[value] = false
        end
    end
end

AppChatTTITracker.setOnConversationSwitch(function(arg1)
    module.cancelIntervalsForTTI(arg1, "conversation_switch")
end)

return module
