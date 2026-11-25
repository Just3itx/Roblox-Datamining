-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T10:51:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TelemetryService = game:GetService("TelemetryService")

local config = {
    eventName = "coachmarkImpression",
    backends = { "EventIngest" },
    throttlingPercentage = game:DefineFastInt("CoachmarkImpressionThrottleHundredthsPercent", 10000),
    lastUpdated = { 26, 6, 16 },
    description = "Sent when a coachmark is shown"
}

local standardizedFields = { "addOSInfo", "addSessionInfo" }

local function sendCoachmarkImpression(collectionServiceAnchorTag: string, hasMedia: boolean)
    TelemetryService:LogEvent(config, {
        standardizedFields = standardizedFields,
        customFields = {
            collectionServiceAnchorTag = collectionServiceAnchorTag,
            hasMedia = hasMedia
        }
    })
end

return sendCoachmarkImpression
