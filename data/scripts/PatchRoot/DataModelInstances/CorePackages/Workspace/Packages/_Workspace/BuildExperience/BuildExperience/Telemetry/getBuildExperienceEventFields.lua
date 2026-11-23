-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T21:11:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")

local BuildExperienceParent = script:FindFirstAncestor("BuildExperience").Parent

local chatOpenTelemetry = require(BuildExperienceParent.DataHydration.CreatorAgentChat).chatOpenTelemetry

local function getBuildExperienceEventFields(eventType: string, tbl1, input)
    local chatOpenId, var2 = chatOpenTelemetry.resolveEventIds(tbl1.chatOpenId, tbl1.conversationId, tbl1.universeId)
    local conversationId = tbl1.conversationId or var2
    return {
        eventType = eventType,
        universeId = tbl1.universeId,
        placeId = tbl1.placeId,
        conversationId = conversationId,
        messageId = tbl1.messageId,
        turnId = tbl1.turnId,
        chatOpenId = chatOpenId,
        parameters = if input then HttpService:JSONEncode(input) else nil
    }
end

return getBuildExperienceEventFields
