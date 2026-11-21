-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T07:21:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ChatUIPrimitivesParent = script:FindFirstAncestor("ChatUIPrimitives").Parent

local TimeToInteractiveTracker = require(ChatUIPrimitivesParent.TimeToInteractiveTracker).TimeToInteractiveTracker
local IntervalPerformanceTracker = require(ChatUIPrimitivesParent.IntervalPerformanceTracker).IntervalPerformanceTracker

local tbl1 = { "duration", "averageFPS", "longestFrameTime" }

local bool1 = game:DefineFastFlag("TextChannelWindowPerfTrackingEnabled", false)
local var1 = nil

local tbl2 = ({})
local tbl3 = ({})

local module = {}

local function isEnabled() -- Luacid: Inlined by compiler; 6 call sites recovered
    return if var1 == nil then bool1 else var1
end

function module.withTrackers(arg1, arg2)
    TimeToInteractiveTracker = arg1
    IntervalPerformanceTracker = arg2
end

function module._setEnabledForTesting(bool2: boolean?)
    var1 = bool2
end

function module.startMountTTI(str1: string)
    if not isEnabled() then
        return
    end
    TimeToInteractiveTracker.trackStart("TextChannelWindow_MountTTI_" .. str1)
end

function module.finishMountTTI(str1: string)
    if not isEnabled() then
        return
    end
    TimeToInteractiveTracker.trackEnd("TextChannelWindow_MountTTI_" .. str1)
end

local function sendIntervalName(str1: string): string -- Luacid: Inlined by compiler; 4 call sites recovered
    return "TextChannelWindow_MessageSendToRenderInterval_" .. str1
end

local function receiveIntervalName(str1: string): string -- Luacid: Inlined by compiler; 4 call sites recovered
    return "TextChannelWindow_MessageReceiveToRenderInterval_" .. str1
end

function module.startSendInterval(id: string, str2: string)
    if not isEnabled() then
        return
    end
    local var2 = tbl2[str2]
    local var3 = if var2 == nil then 0 else var2.timestamp or 0
    if var2 ~= nil and var2.id ~= nil and var3 + 5 > os.clock() then
        return
    end
    tbl2[str2] = {
        id = id,
        timestamp = os.clock()
    }
    local str3 = sendIntervalName(str2)
    IntervalPerformanceTracker:cancelTracking(str3)
    IntervalPerformanceTracker:startTracking(str3, nil, tbl1, true, true)
end

function module.startReceiveInterval(id: string, str2: string)
    if not isEnabled() then
        return
    end
    local var2 = tbl3[str2]
    local var3 = if var2 == nil then 0 else var2.timestamp or 0
    if var2 ~= nil and var2.id ~= nil and var3 + 5 > os.clock() then
        return
    end
    tbl3[str2] = {
        id = id,
        timestamp = os.clock()
    }
    local str3 = receiveIntervalName(str2)
    IntervalPerformanceTracker:cancelTracking(str3)
    IntervalPerformanceTracker:startTracking(str3, nil, tbl1, true, true)
end

function module.finishMessageIntervals(id: string)
    if not isEnabled() then
        return
    end
    for value, value2 in tbl2 do
        if value2.id == id then
            tbl2[value] = {}
            IntervalPerformanceTracker:stopAndLogTracking((sendIntervalName(value)))
        end
    end
    for value, value2 in tbl3 do
        if value2.id == id then
            tbl3[value] = {}
            IntervalPerformanceTracker:stopAndLogTracking((receiveIntervalName(value)))
        end
    end
end

function module.cancelForChannel(str1: string)
    if not isEnabled() then
        return
    end
    if tbl2[str1] then
        tbl2[str1] = {}
        IntervalPerformanceTracker:cancelTracking((sendIntervalName(str1)))
    end
    if tbl3[str1] then
        tbl3[str1] = {}
        IntervalPerformanceTracker:cancelTracking((receiveIntervalName(str1)))
    end
end

function module.cancelAll()
    for value in tbl2 do
        IntervalPerformanceTracker:cancelTracking((sendIntervalName(value)))
    end
    for value in tbl3 do
        IntervalPerformanceTracker:cancelTracking((receiveIntervalName(value)))
    end
    tbl2 = {}
    tbl3 = {}
end

return module
