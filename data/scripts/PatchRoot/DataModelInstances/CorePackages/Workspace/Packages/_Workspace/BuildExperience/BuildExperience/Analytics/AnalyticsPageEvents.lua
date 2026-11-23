-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T18:41:30Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")

local _AnalyticsWindow = require(BuildExperience.Analytics.AnalyticsWindow)
local _GoalLockedActionId = require(BuildExperience.Analytics.Goals.GoalLockedActionId)
local sendBuildExperienceEvent = require(BuildExperience.Telemetry.sendBuildExperienceEvent)
local FFlagBuildExperienceEventContextTelemetry = require(BuildExperience.Flags.FFlagBuildExperienceEventContextTelemetry)

local function getGranularity(universeId: number, tbl1) -- Luacid: Inlined by compiler; 4 call sites recovered
    return {
        universeId = universeId,
        placeId = if tbl1 == nil then nil else tbl1.placeId,
        conversationId = if tbl1 == nil then nil else tbl1.conversationId
    }
end

return {
    goalImpression = function(universeId: number, goalId: string, state: string, windowId, tbl1)
        sendBuildExperienceEvent(
            "ANALYTICS_PAGE_GOAL_IMPRESSION",
            not FFlagBuildExperienceEventContextTelemetry and { universeId = universeId } or getGranularity(universeId, tbl1),
            { goalId = goalId, state = state, windowId = windowId }
        )
    end,
    goalClick = function(universeId: number, goalId: string, tbl1)
        sendBuildExperienceEvent(
            "ANALYTICS_PAGE_GOAL_CLICK",
            not FFlagBuildExperienceEventContextTelemetry and { universeId = universeId } or getGranularity(universeId, tbl1),
            { goalId = goalId }
        )
    end,
    goalCtaImpression = function(universeId: number, goalId: string, actionId, slot: string, tbl1)
        sendBuildExperienceEvent(
            "ANALYTICS_PAGE_GOAL_CTA_IMPRESSION",
            not FFlagBuildExperienceEventContextTelemetry and { universeId = universeId } or getGranularity(universeId, tbl1),
            { goalId = goalId, actionId = actionId, slot = slot }
        )
    end,
    goalCtaClick = function(universeId: number, goalId: string, actionId, slot: string, tbl1)
        sendBuildExperienceEvent(
            "ANALYTICS_PAGE_GOAL_CTA_CLICK",
            not FFlagBuildExperienceEventContextTelemetry and { universeId = universeId } or getGranularity(universeId, tbl1),
            { goalId = goalId, actionId = actionId, slot = slot }
        )
    end
}
