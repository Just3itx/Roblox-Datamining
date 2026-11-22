-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T19:51:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TelemetryService = game:GetService("TelemetryService")

local _buildSocialProofTextEventParams = require(script.Parent.buildSocialProofTextEventParams)

local config = {
    eventName = "edpSocialProofTextClicked",
    description = "The user tapped the EDP social proof text to open the full list of friends who played",
    backends = { "EventIngest" },
    throttlingPercentage = game:DefineFastInt("EdpSocialProofTextClickedHundredthsPercent", 10000),
    lastUpdated = { 26, 11, 4 }
}

local function sendSocialProofTextClickedEvent(customFields)
    TelemetryService:LogEvent(
        config,
        {
            standardizedFields = { "addSessionInfo", "addSessionId", "addOSInfo" },
            customFields = customFields
        }
    )
end
return sendSocialProofTextClickedEvent
