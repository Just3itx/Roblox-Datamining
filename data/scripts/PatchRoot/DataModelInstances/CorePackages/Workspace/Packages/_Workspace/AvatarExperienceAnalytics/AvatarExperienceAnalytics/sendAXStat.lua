-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T12:50:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")
local UserInputService = game:GetService("UserInputService")

local AvatarExperienceAnalyticsParent = script:FindFirstAncestor("AvatarExperienceAnalytics").Parent

local Dash = require(AvatarExperienceAnalyticsParent.Dash)
local default = require(AvatarExperienceAnalyticsParent.LoggingProtocol).default

local AnalyticsService = require(script.Parent.AnalyticsService)
local isSpatial = require(AvatarExperienceAnalyticsParent.AppCommonLib).isSpatial

local function getAXStatMetadata(tbl1)
    local platform = UserInputService:GetPlatform()

    local var1 = if isSpatial() then "VR" else platform

    local tbl2 = {
        AppVersion = RunService:GetRobloxVersion(),
        UserAgent = HttpService:GetUserAgent(),
        CoreScriptVersion = RunService:GetCoreScriptVersion(),
        Platform = var1
    }

    if tbl1 and next(tbl1) ~= nil then
        tbl2 = Dash.assign({}, tbl2, tbl1)
    end

    return tbl2
end

local function sendAXStat(tbl1)
    if not tbl1.excludeStat then
        local tbl2 = {
            eventName = tbl1.statName,
            backends = { "RobloxTelemetryStat" },
            lastUpdated = { 2024, 11, 19 },
            description = "Stat to track Avatar Experience latency.",
            links = ""
        }

        local aXStatMetadata = getAXStatMetadata(tbl1.metaData)
        default:logRobloxTelemetryStat(tbl2, tbl1.deltaMs, aXStatMetadata)
    end

    if tbl1.excludeTelemetry then
        return
    end

    local tbl2 = {
        deltaMs = tbl1.deltaMs,
        metricName = tbl1.statName
    }
    if tbl1.metaData then
        tbl2.coldStart = tbl1.metaData.ColdStart
        tbl2.category = tbl1.metaData.Category
        tbl2.subcategory = tbl1.metaData.Subcategory
        tbl2.page = tbl1.metaData.Page
        tbl2.opaquePage = tbl1.metaData.OpaquePage
    end

    local aXStatMetadata = getAXStatMetadata()
    tbl2.appVersion = aXStatMetadata.AppVersion
    tbl2.userAgent = aXStatMetadata.UserAgent
    tbl2.coreScriptVersion = aXStatMetadata.CoreScriptVersion
    tbl2.platform = aXStatMetadata.Platform

    local var1 = if tbl1.customEventStreamSchemaName then tbl1.customEventStreamSchemaName else "marketplacePerformanceMetric"

    AnalyticsService.EventStream:sendEventDeferred(tbl1.statName, var1, tbl2)
end

return sendAXStat
