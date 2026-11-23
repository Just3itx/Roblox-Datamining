-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T04:10:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TelemetryService = game:GetService("TelemetryService")
local VideoUtils = script:FindFirstAncestor("VideoUtils")

local VideoUtilsParent = VideoUtils.Parent
local Cryo = require(VideoUtilsParent.Cryo)
local LoggingProtocol = require(VideoUtilsParent.LoggingProtocol)

local reportWarning = require(VideoUtilsParent.DiscoveryAnalytics).Points.reportWarning
local t = require(VideoUtilsParent.t)

local _VideoAnalyticsTypes = require(VideoUtils.Analytics.VideoAnalyticsTypes)
local VideoEngagementEvents = require(VideoUtils.Analytics.Enums).VideoEngagementEvents

local throttlingPercentage = game:DefineFastInt("VideoEngagementEventHundredthsPercent", 0)

local tbl1 = {}

local var1 = t.strictInterface({
    videoAssetId = t.string,
    source = t.string,
    sourceId = t.string,
    impressionId = t.optional(t.string),
    playbackSessionId = t.optional(t.string),
    videoAssetDuration = t.optional(t.number),
    isVisible = t.optional(t.boolean),
    isAudible = t.optional(t.boolean),
    isFullscreen = t.optional(t.boolean),
    volumeLevel = t.optional(t.number)
})

local var2 = t.strictInterface({
    loadTime = t.optional(t.number),
    scrubStartTime = t.optional(t.number),
    scrubEndTime = t.optional(t.number),
    destination = t.optional(t.string)
})

local tbl2 = {
    eventName = "videoEngagementEvent",
    backends = { LoggingProtocol.TelemetryBackends.Points, LoggingProtocol.TelemetryBackends.EventIngest },
    throttlingPercentage = throttlingPercentage,
    lastUpdated = { 25, 6, 25 },
    description = "Fire when video engagement event is triggered",
    links = ""
}

return {
    reportVideoAction = function(actionType, eventContext: string?, arg1, arg2)
        local var3, var4 = var1(arg1)

        if not var3 then
            reportWarning(LoggingProtocol.default, "EventLogging", var4)
        end

        if arg2 then
            local var5, var6 = var2(arg2)

            if not var5 then
                reportWarning(LoggingProtocol.default, "EventLogging", var6)
            end
        end

        local customFields = Cryo.Dictionary.join(
            arg1,
            {
                videoEngagementEventType = VideoEngagementEvents.VIDEO_ACTION,
                actionType = actionType
            },
            arg2 or tbl1
        )
        local config = Cryo.Dictionary.join(tbl2, { eventContext = eventContext })

        TelemetryService:LogEvent(
            config,
            {
                standardizedFields = { "addSessionInfo", LoggingProtocol.StandardizedFields.addOsInfo },
                customFields = customFields
            }
        )
    end
}
