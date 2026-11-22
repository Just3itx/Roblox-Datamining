-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T19:51:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TelemetryService = game:GetService("TelemetryService")

local _buildSocialProofTextEventParams = require(script.Parent.buildSocialProofTextEventParams)

local config = {
    eventName = "edpSocialProofTextImpression",
    description = "The EDP social proof text (friends who played, with an avatar stack) was shown",
    backends = { "EventIngest" },
    throttlingPercentage = game:DefineFastInt("EdpSocialProofTextImpressionHundredthsPercent", 10000),
    lastUpdated = { 26, 11, 4 }
}

local function sendSocialProofTextImpressionEvent(customFields)
    TelemetryService:LogEvent(
        config,
        {
            standardizedFields = { "addSessionInfo", "addSessionId", "addOSInfo" },
            customFields = customFields
        }
    )
end
return sendSocialProofTextImpressionEvent
