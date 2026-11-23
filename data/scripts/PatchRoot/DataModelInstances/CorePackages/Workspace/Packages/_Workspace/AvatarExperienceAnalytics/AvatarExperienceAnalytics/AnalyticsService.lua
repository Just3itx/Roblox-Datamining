-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T12:41:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local EventIngestService = game:GetService("EventIngestService")
local RbxAnalyticsService = game:GetService("RbxAnalyticsService")
local SessionService = game:GetService("SessionService")
local AvatarExperienceAnalyticsParent = script:FindFirstAncestor("AvatarExperienceAnalytics").Parent
local default = require(AvatarExperienceAnalyticsParent.LoggingProtocol).default
local Analytics = require(AvatarExperienceAnalyticsParent.Analytics)
local analytics = Analytics.Analytics.new(RbxAnalyticsService)
local getPlatformTarget = Analytics.getPlatformTarget

local bool1 = game:DefineFastFlag("AXSendSessionForEvents", false)

return {
    Diag = analytics.Diag,
    EventStream = {
        setRBXEventStream = function(_, eventContext: string, eventName: string, tbl1)
            EventIngestService:SetRBXEventStream(getPlatformTarget(), eventContext, eventName, tbl1 or {})
        end,
        sendEventDeferred = function(_, eventContext: string, eventName: string, tbl1)
            EventIngestService:SendEventDeferred(getPlatformTarget(), eventContext, eventName, tbl1 or {})
        end,
        sendEventImmediately = function(_, eventContext: string, eventName: string, tbl1)
            EventIngestService:SendEventImmediately(getPlatformTarget(), eventContext, eventName, tbl1 or {})
        end,
        sendTelemetryEvent = function(_, str1: string, str2: string, tbl1)
            default:logRobloxTelemetryEvent(
                {
                    eventName = str2,
                    backends = { default.TelemetryBackends.EventIngest },
                    throttlingPercentage = 10000
                },
                { "addSessionId", "addSessionInfo" },
                tbl1,
                str1
            )

            if not bool1 then
                return
            end

            default:logRobloxTelemetryEvent(
                {
                    eventName = "sessionIdDebugEvent",
                    backends = { default.TelemetryBackends.EventIngest },
                    throttlingPercentage = 10000
                },
                { "addSessionInfo" },
                {
                    testEventName = str2,
                    sessionTagL2a = SessionService:GetSessionTag("level2a")
                },
                str1
            )
        end
    }
}
