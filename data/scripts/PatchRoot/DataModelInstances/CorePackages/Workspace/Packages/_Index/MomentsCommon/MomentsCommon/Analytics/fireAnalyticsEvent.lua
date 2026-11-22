-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T06:01:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCommon = script:FindFirstAncestor("MomentsCommon")
local MomentsCommonParent = MomentsCommon.Parent

local Cryo = require(MomentsCommonParent.Cryo)
local SocialLuaAnalytics = require(MomentsCommonParent.SocialLuaAnalytics)

local _EventNames = require(MomentsCommon.Analytics.EventNames)
local _Types = require(MomentsCommon.Analytics.Types)
local telemetryEmitter = require(MomentsCommon.Analytics.telemetryEmitter)
local FunnelEventActionList = require(MomentsCommon.Analytics.FunnelEventActionList)
local SessionManager = require(MomentsCommon.Analytics.SessionManager)
local fireFunnelAnalyticsEvent = require(MomentsCommon.Analytics.fireFunnelAnalyticsEvent)
local GetFFlagMomentsCreationSaveDraft = require(MomentsCommon.Flags.GetFFlagMomentsCreationSaveDraft)

local telemetry = SocialLuaAnalytics.Telemetry.new({
    name = "MomentsAnalyticsEvent",
    description = "Moments analytics events ported from moments-repo. The wire eventName is taken from the per-emission `eventName` field via `overrideName`; one config covers all moments EventNames values.",
    lastUpdated = { 2026, 5, 28 },
    eventStreamCtx = SocialLuaAnalytics.Analytics.Enums.Contexts.Moments,
    backendsList = {{
        type = "EventIngest",
        standardizedFields = { "addSessionInfo", "addSessionId" },
        overrideName = function(tbl1)
            return tbl1.eventName
        end,
        format = function(tbl1, _)
            return Cryo.Dictionary.join(tbl1.additionalInfo or {}, { client_event_timestamp_ms = DateTime.now().UnixTimestampMillis })
        end
    }}
})

local function fireAnalyticsEvent(eventName, additionalInfo)
    telemetryEmitter.emit(telemetry, { eventName = eventName, additionalInfo = additionalInfo })

    local var1 = FunnelEventActionList[eventName]
    if var1 == nil then
        return
    end

    for _, value in var1 do
        if GetFFlagMomentsCreationSaveDraft() and value.onlyIfSessionOpen and SessionManager.getSessionId(value.funnelType) == nil then
            continue
        end

        local var2 = SessionManager.getSessionId(value.funnelType) or SessionManager.startSession(value.funnelType)
        if value.endSession then
            SessionManager.endSession(value.funnelType)
        end

        if value.stepKey ~= nil then
            fireFunnelAnalyticsEvent(value.funnelType, value.stepKey, var2)
        end
    end
end

return fireAnalyticsEvent
