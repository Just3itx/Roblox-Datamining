-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T06:01:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCommon = script:FindFirstAncestor("MomentsCommon")
local MomentsCommonParent = MomentsCommon.Parent

local Cryo = require(MomentsCommonParent.Cryo)
local SocialLuaAnalytics = require(MomentsCommonParent.SocialLuaAnalytics)

local FunnelEventNames = require(MomentsCommon.Analytics.FunnelEventNames)
local _Types = require(MomentsCommon.Analytics.Types)
local telemetryEmitter = require(MomentsCommon.Analytics.telemetryEmitter)

local telemetry = SocialLuaAnalytics.Telemetry.new({
    name = "MomentsFunnelStep",
    description = "Moments funnel-step events ported from moments-repo. funnelName/funnelSessionId/stepNumber/stepName plus any customFields are emitted as top-level EventIngest columns so downstream funnel reconstruction continues to work.",
    lastUpdated = { 2026, 5, 28 },
    eventStreamCtx = SocialLuaAnalytics.Analytics.Enums.Contexts.Moments,
    backendsList = {{
        type = "EventIngest",
        standardizedFields = { "addSessionInfo", "addSessionId" },
        format = function(tbl1, _)
            return Cryo.Dictionary.join(tbl1.customFields or {}, {
                funnelName = tbl1.funnelName,
                funnelSessionId = tbl1.funnelSessionId,
                stepNumber = tbl1.stepNumber,
                stepName = tbl1.stepName
            })
        end
    }}
})

local function fireFunnelAnalyticsEvent(funnelName, arg1, funnelSessionId: string, customFields)
    local funnelStep = FunnelEventNames.FunnelSteps[funnelName]
    if not funnelStep then
        warn(`[Moments] Unknown funnel type: {funnelName}`)
        return
    end
    local var1 = funnelStep[arg1]
    if not var1 then
        warn(`[Moments] Unknown funnel step '{arg1}' for funnel '{funnelName}'`)
        return
    end

    telemetryEmitter.emit(telemetry, {
        funnelName = funnelName,
        funnelSessionId = funnelSessionId,
        stepNumber = var1.stepNumber,
        stepName = var1.stepName,
        customFields = customFields
    })
end

return fireFunnelAnalyticsEvent
