-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T21:11:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")
local TelemetryService = game:GetService("TelemetryService")

local BuildExperience = script:FindFirstAncestor("BuildExperience")

local FFlagBuildExperienceChatOpenId = require(BuildExperience.Flags.FFlagBuildExperienceChatOpenId)
local getBuildExperienceEventFields = require(script.Parent.getBuildExperienceEventFields)

local config = {
    eventName = "buildExperienceEvent",
    backends = { "Points", "EventIngest" },
    throttlingPercentage = game:DefineFastInt("BuildExperienceEventThrottleHundredthsPercent", 0),
    lastUpdated = FFlagBuildExperienceChatOpenId and { 2026, 11, 11 } or { 2026, 11, 2 },
    description = "Client events for Build tab interactions, chat opens, prompt chips, Library browsing and contextual prompt submissions, prompt send lifecycle (start, stall, stop, failure), playtesting, private invites, private playtest preview taps, monetization, ad-upsell impressions and clicks, and Analytics page goal card and locked-action impressions and clicks."
}

local function sendBuildExperienceEvent(eventType: string, arg1, input)
    local tbl1 = {
        eventType = eventType,
        universeId = arg1.universeId,
        placeId = arg1.placeId,
        conversationId = arg1.conversationId,
        messageId = arg1.messageId,
        turnId = arg1.turnId,
        parameters = if input then HttpService:JSONEncode(input) else nil
    }

    local telemetryService = TelemetryService
    local config2 = config
    local tbl2 = {
        standardizedFields = { "addUserId", "addSessionId" },
        customFields = 0
    }

    if FFlagBuildExperienceChatOpenId then
        tbl1 = getBuildExperienceEventFields(eventType, arg1, input)
    end

    tbl2.customFields = tbl1
    telemetryService:LogEvent(config2, tbl2)
end

return sendBuildExperienceEvent
