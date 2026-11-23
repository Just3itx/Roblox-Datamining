-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T20:01:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TelemetryService = game:GetService("TelemetryService")

local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent
local CreatorAgentChat = require(BuildExperienceParent.DataHydration.CreatorAgentChat)

local _chatTypes = require(BuildExperience.Chat.chatTypes)
local _FeedbackAction = require(script.Parent.FeedbackAction)

local debug2 = CreatorAgentChat.debug

local config = {
    eventName = "agentTurnFeedback",
    backends = { "Points", "EventIngest" },
    throttlingPercentage = game:DefineFastInt("AgentTurnFeedbackEventThrottleHundredthsPercent", 0),
    lastUpdated = { 2026, 7, 30 },
    description = "Fires when a user interacts with an agent turn (thumbs up, thumbs down, copy, or revert)."
}

local function sendAgentTurnFeedback(action, arg1)
    local customFields = {
        action = action,
        universeid = arg1.universeId,
        placeid = arg1.placeId,
        sessionid = arg1.sessionId,
        sequenceId = arg1.sequenceId,
        turnId = arg1.turnId
    }

    debug2.log("info", "agent_turn_feedback sending event", { customFields = customFields })

    TelemetryService:LogEvent(config, { standardizedFields = { "addUserId" }, customFields = customFields })
end

return sendAgentTurnFeedback
