-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T02:31:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserInputService = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")
local IntervalPerformanceTrackerParent = script:FindFirstAncestor("IntervalPerformanceTracker").Parent
local LoggingProtocol = require(IntervalPerformanceTrackerParent.LoggingProtocol)
local default = LoggingProtocol.default
local isSpatial = require(IntervalPerformanceTrackerParent.AppCommonLib).isSpatial
local DeviceTier = require(IntervalPerformanceTrackerParent.Devices).DeviceTier

local JANKY_FRAME_BANDS = require(script.Parent.ScrollFrameBands).JANKY_FRAME_BANDS

local tbl1 = {
    eventName = "luaScrollFrameBucket",
    backends = { LoggingProtocol.TelemetryBackends.Counter },
    lastUpdated = { 2026, 9, 1 },
    description = "Per-frame-time-band frame counts for scroll perf; one increment per band per scroll session.",
    links = ""
}

local tbl2 = {
    eventName = "luaScrollSession",
    backends = { LoggingProtocol.TelemetryBackends.Counter },
    lastUpdated = { 2026, 9, 1 },
    description = "Completed scroll-session count for scroll perf; one increment per session. Carries a jank_band label (per-session % of frames >= 18 ms, bucketed) so sum by jank_band is the session count and the per-band split reproduces the rollup's sessions_jank_* histogram.",
    links = ""
}

local tbl3 = {
    2,
    4,
    6,
    8,
    10,
    15,
    20,
    25,
    30,
    40,
    50,
    60,
    80
}
local tbl4 = {
    "0_2",
    "2_4",
    "4_6",
    "6_8",
    "8_10",
    "10_15",
    "15_20",
    "20_25",
    "25_30",
    "30_40",
    "40_50",
    "50_60",
    "60_80",
    "80_100"
}

local function jankBandForRate(num1: number) -- Luacid: Inlined by compiler; 1 call site recovered
    for value, value2 in tbl3 do
        if num1 < value2 then
            return tbl4[value]
        end
    end
    return tbl4[#tbl4]
end

local deviceMemoryTier = nil
local function getMemTier() -- Luacid: Inlined by compiler; 1 call site recovered
    if deviceMemoryTier == nil then
        deviceMemoryTier = DeviceTier.GetDeviceMemoryTier()
    end
    return deviceMemoryTier or "unknown"
end

local function getPlatform() -- Luacid: Inlined by compiler; 1 call site recovered
    if isSpatial() then
        return "VR"
    end
    local success, result = pcall(function(): Enum.Platform
        return UserInputService:GetPlatform()
    end)
    return if success and result then result.Name else nil
end

local function sendScrollFrameCounters(tbl5)
    local success, result = pcall(function()
        return HttpService:JSONDecode(tbl5.frameBucketsJson)
    end)
    if not success or typeof(result) ~= "table" then
        return
    end

    local tbl6 = {
        intervalName = tbl5.intervalName,
        mem_tier = getMemTier()
    }
    local platform = getPlatform()

    if platform then
        tbl6.platform = platform
    end
    if tbl5.scrollType then
        tbl6.scroll_type = tbl5.scrollType
    end

    local num1 = 0
    local num2 = 0
    for bucket, value2 in result do
        if typeof(value2) ~= "number" or not (value2 > 0) then
            continue
        end

        num1 += value2
        if JANKY_FRAME_BANDS[bucket] then
            num2 += value2
        end
        local var1 = table.clone(tbl6)
        var1.bucket = bucket
        default:logRobloxTelemetryCounter(tbl1, value2, var1)
    end

    if num1 == 0 then
        return
    end

    local var1 = num2 / num1 * 100
    local var2 = table.clone(tbl6)
    var2.jank_band = jankBandForRate(var1)
    default:logRobloxTelemetryCounter(tbl2, 1, var2)
end

return sendScrollFrameCounters
