-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T23:31:31Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TelemetryService = game:GetService("TelemetryService")

local _LinkingProtocolTypes = require(script.Parent.LinkingProtocolTypes)

local standardizedFields = { "addOSInfo", "addSessionInfo", "addSessionId" }

local config = {
    eventName = "StartAttributionDecisionPublishedCounter",
    backends = { "RobloxTelemetryCounter" },
    lastUpdated = { 26, 9, 1 },
    description = "\t\tCounts delayed-AppsFlyer-start decisions published to native. Custom field\n\t\t\"trigger\" is Auth / SessionStart / ConsentChanged (ConsentChanged isolates the\n\t\tlive mid-session sell/share toggle); \"applySharingFilter\" is whether the\n\t\tpartner-postback filter was applied.\n\t"
}

local module = {}

function module.logDecisionPublished(trigger, applySharingFilter: boolean)
    TelemetryService:LogCounter(config, {
        standardizedFields = standardizedFields,
        customFields = { trigger = trigger, applySharingFilter = applySharingFilter }
    }, 1)
end

return module
