-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T12:50:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")
local UserInputService = game:GetService("UserInputService")

local AvatarExperienceAnalyticsParent = script:FindFirstAncestor("AvatarExperienceAnalytics").Parent

local default = require(AvatarExperienceAnalyticsParent.LoggingProtocol).default
local Dash = require(AvatarExperienceAnalyticsParent.Dash)

local isSpatial = require(AvatarExperienceAnalyticsParent.AppCommonLib).isSpatial

local FFlagAXUnifiedEventCounters = require(AvatarExperienceAnalyticsParent.AvatarExperienceFlags).FFlagAXUnifiedEventCounters

local function getAXCounterV2Metadata(tbl1)
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

local function sendAXCounterV2(str1: string, tbl1, num1: number?)
    local tbl2 = {
        eventName = "AvatarExperience_" .. str1,
        backends = { default.TelemetryBackends.Counter },
        lastUpdated = { 2025, 10, 30 },
        description = "Counter to track various Avatar Experience events.",
        links = ""
    }

    local aXCounterV2Metadata = getAXCounterV2Metadata(tbl1)
    default:logRobloxTelemetryCounter(tbl2, FFlagAXUnifiedEventCounters and num1 or 1, aXCounterV2Metadata)
end

return sendAXCounterV2
