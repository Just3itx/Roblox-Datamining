-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T02:31:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RbxAnalyticsService = game:GetService("RbxAnalyticsService")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")
local UserInputService = game:GetService("UserInputService")
local IntervalPerformanceTrackerParent = script:FindFirstAncestor("IntervalPerformanceTracker").Parent
local var1 = require(IntervalPerformanceTrackerParent.Analytics).Analytics.new(RbxAnalyticsService)
local Dash = require(IntervalPerformanceTrackerParent.Dash)
local default = require(IntervalPerformanceTrackerParent.LoggingProtocol).default
local isSpatial = require(IntervalPerformanceTrackerParent.AppCommonLib).isSpatial

local function getDefaultMetadata(metaData)
    local platform = UserInputService:GetPlatform()
    local var2 = if isSpatial() then "VR" else platform

    local tbl1 = {
        appVersion = RunService:GetRobloxVersion(),
        userAgent = HttpService:GetUserAgent(),
        coreScriptVersion = RunService:GetCoreScriptVersion(),
        platform = var2
    }

    return (Dash.assign(tbl1, metaData))
end

local function sendFPSStat(tbl1)
    local bool1 = tbl1.excludeEventStream ~= false
    local defaultMetadata = getDefaultMetadata(tbl1.metaData)

    if not tbl1.excludeStat then
        local tbl2 = {
            eventName = tbl1.statName,
            backends = { "RobloxTelemetryStat" },
            lastUpdated = { 2025, 4, 28 },
            description = "Stat to track FPS metrics.",
            links = ""
        }

        default:logRobloxTelemetryStat(tbl2, tbl1.interval, defaultMetadata)
    end

    if not bool1 and tbl1.eventStreamName then
        var1.EventStream:sendEventDeferred(tbl1.eventStreamName, "robloxFPSMetrics", defaultMetadata)
    end
end

return sendFPSStat
