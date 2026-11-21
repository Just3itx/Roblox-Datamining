-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T10:31:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TelemetryService = game:GetService("TelemetryService")
local DiscoveryAnalyticsParent = script:FindFirstAncestor("DiscoveryAnalytics").Parent

local t = require(DiscoveryAnalyticsParent.t)
local DiscoveryEventErrorLogger = require(DiscoveryAnalyticsParent.DiscoveryUtils).DiscoveryEventErrorLogger

local FFlagLuaAppIedpSendPoints = require(DiscoveryAnalyticsParent.SharedFlags).FFlagLuaAppIedpSendPoints

local throttlingPercentage = game:DefineFastInt("InExperienceDetailsPromptOpenedHundredthsPercent", 0)

local var1 = t.strictInterface({ targetUniverseId = t.string })

local config = {
    eventName = "inExperienceDetailsPromptOpened",
    backends = FFlagLuaAppIedpSendPoints and { "EventIngest", "Points" } or { "EventIngest" },
    throttlingPercentage = throttlingPercentage,
    lastUpdated = FFlagLuaAppIedpSendPoints and { 25, 11, 19 } or { 25, 11, 11 },
    description = "Fires when the in-experience details prompt is opened"
}

local function fireInExperienceDetailsPromptOpenedEvent(customFields)
    local var2, var3 = var1(customFields)

    if not var2 then
        DiscoveryEventErrorLogger.reportError("InExperienceDetailsPromptOpenedInvalidInterface", var3)
    end

    TelemetryService:LogEvent(
        config,
        {
            standardizedFields = { "addUniverseId", "addOSInfo" },
            customFields = customFields
        }
    )
end
return fireInExperienceDetailsPromptOpenedEvent
