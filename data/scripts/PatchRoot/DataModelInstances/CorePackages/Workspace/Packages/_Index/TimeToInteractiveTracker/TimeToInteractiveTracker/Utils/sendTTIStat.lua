-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T00:00:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")
local UserInputService = game:GetService("UserInputService")

local TimeToInteractiveTrackerParent = script:FindFirstAncestor("TimeToInteractiveTracker").Parent

local Dash = require(TimeToInteractiveTrackerParent.Dash)
local LoggingProtocol = require(TimeToInteractiveTrackerParent.LoggingProtocol)
local default = LoggingProtocol.default
local AppCommonLib = require(TimeToInteractiveTrackerParent.AppCommonLib)
local var1 = require(TimeToInteractiveTrackerParent.TelemetryService).EventStreamReporter.new(default)

local isSpatial = AppCommonLib.isSpatial
local ttiDebugLog = require(script.Parent.ttiDebugLog)
local Util = require(script.Parent.Util)
local FFlagTTITrackerMemoryTracking = require(script.Parent.FFlagTTITrackerMemoryTracking)
local _types = require(script.Parent.Parent.Stores.types)

local str1 = game:DefineFastString("TTIMetricsTableName", "marketplacePerformanceMetric")

local bool1 = game:DefineFastFlag("AXTTIAddNumElementsRendered", false)

local bool2 = game:DefineFastFlag("TTIEmitPointsEvent", false)

local tbl1 = {
    eventName = "ua_page_load_time",
    backends = { LoggingProtocol.TelemetryBackends.Points },
    lastUpdated = { 2026, 9, 3 },
    description = "Raw per-page-load TTI event to Elasticsearch (Points) for exact-percentile PLT dashboards.",
    links = ""
}

game:DefineFastInt("TimeToInteractiveTrackerSampleRate", 0)

game:DefineFastInt("TTIPointsEventSampleRate", 0)

local function getDefaultMetadata(arg1)
    local str2 = tostring(UserInputService:GetPlatform())
    local platform = if isSpatial() then "VR" else str2

    local tbl2 = {
        AppVersion = RunService:GetRobloxVersion(),
        UserAgent = HttpService:GetUserAgent(),
        CoreScriptVersion = RunService:GetCoreScriptVersion(),
        Platform = platform
    }

    return Dash.assign(tbl2, arg1)
end

local function sendTTIStat(tbl2)
    if math.clamp(
        if tbl2.samplingRateOverride ~= nil then tbl2.samplingRateOverride else game:GetFastInt("TimeToInteractiveTrackerSampleRate"),
        0,
        1000
    ) < math.random(1, 1000)
        and not RunService:IsStudio()
    then
        return
    end

    local tbl3 = {
        eventName = tbl2.statName,
        backends = { "RobloxTelemetryStat" },
        lastUpdated = { 2026, 1, 14 },
        description = "Stat to track Time-To-Interactive (TTI) latency metrics.",
        links = ""
    }

    local defaultMetadata = getDefaultMetadata(tbl2.metaData)

    local function logMemoryStats(str2: string, totalMemoryMb: number?, luaHeapMb: number?)
        if totalMemoryMb then
            local var2 = table.clone(tbl3)
            var2.eventName = str2 .. "_TotalMemoryMB"
            default:logRobloxTelemetryStat(var2, totalMemoryMb, defaultMetadata)
        end
        if luaHeapMb then
            local var2 = table.clone(tbl3)
            var2.eventName = str2 .. "_LuaHeapMB"
            default:logRobloxTelemetryStat(var2, luaHeapMb, defaultMetadata)
        end
    end

    default:logRobloxTelemetryStat(tbl3, tbl2.deltaMs, defaultMetadata)

    if tbl2.milestones then
        for _, value in (Util.generateMilestoneStats(tbl2.statName, tbl2.milestones)) do
            local var2 = table.clone(tbl3)
            var2.eventName = value.eventName
            default:logRobloxTelemetryStat(var2, value.deltaMs, defaultMetadata)
            if FFlagTTITrackerMemoryTracking then
                logMemoryStats(value.eventName, value.totalMemoryMB, value.luaHeapMB)
            end
        end
    end

    if FFlagTTITrackerMemoryTracking then
        logMemoryStats(tbl2.statName, tbl2.totalMemoryMB, tbl2.luaHeapMB)
    end

    local tbl4 = {
        deltaMs = tbl2.deltaMs,
        metricName = tbl2.statName
    }

    if tbl2.metaData then
        tbl4.coldStart = tbl2.metaData.coldStart
        tbl4.category = tbl2.metaData.category
        tbl4.subcategory = tbl2.metaData.subcategory
        tbl4.page = tbl2.metaData.page
        tbl4.opaquePage = tbl2.metaData.opaquePage
        if bool1 then
            tbl4.num_elements_rendered = tbl2.metaData.numElementsRendered
        end
    end

    local defaultMetadata2 = getDefaultMetadata({})
    tbl4.appVersion = defaultMetadata2.AppVersion
    tbl4.userAgent = defaultMetadata2.UserAgent
    tbl4.coreScriptVersion = defaultMetadata2.CoreScriptVersion
    tbl4.platform = defaultMetadata2.Platform

    tbl4.total_memory_mb = tbl2.totalMemoryMB
    tbl4.lua_heap_mb = tbl2.luaHeapMB

    if tbl2.milestones then
        local input = Util.milestonesToProto(tbl2.milestones)
        local success, result = pcall(function(): string
            return HttpService:JSONEncode(input)
        end)
        if success then
            tbl4.milestones_json = result
        end
    end

    var1:sendTelemetryEvent(str1, str1, tbl4)

    if bool2
        and (math.clamp(game:GetFastInt("TTIPointsEventSampleRate"), 0, 1000) >= math.random(1, 1000) or RunService:IsStudio())
    then
        local var2 = table.clone(tbl4)
        var2.milestones_json = nil
        if tbl2.milestones then
            for value, value2 in Util.milestonesToPointsFields(tbl2.milestones) do
                var2[value] = value2
            end
        end

        default:logRobloxTelemetryEvent(tbl1, nil, var2)
    end

    ttiDebugLog("sendTTIStat", tbl2.statName, tbl2.deltaMs, tbl4, tbl2.milestones)
end

return sendTTIStat
