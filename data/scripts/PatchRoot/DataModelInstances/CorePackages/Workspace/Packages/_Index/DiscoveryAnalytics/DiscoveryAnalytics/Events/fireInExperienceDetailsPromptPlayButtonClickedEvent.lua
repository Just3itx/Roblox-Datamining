-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T10:31:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TelemetryService = game:GetService("TelemetryService")
local DiscoveryAnalyticsParent = script:FindFirstAncestor("DiscoveryAnalytics").Parent

local t = require(DiscoveryAnalyticsParent.t)
local DiscoveryEventErrorLogger = require(DiscoveryAnalyticsParent.DiscoveryUtils).DiscoveryEventErrorLogger

local FFlagLuaAppIedpSendPoints = require(DiscoveryAnalyticsParent.SharedFlags).FFlagLuaAppIedpSendPoints

local throttlingPercentage = game:DefineFastInt("InExperienceDetailsPromptPlayClickedHundredthsPercent", 0)

local var1 = t.strictInterface({
    targetUniverseId = t.string,
    targetRootPlaceId = t.optional(t.number),
    playabilityRetrievalStatus = t.optional(t.string)
})

local config = {
    eventName = "inExperienceDetailsPromptPlayButtonClicked",
    backends = FFlagLuaAppIedpSendPoints and { "EventIngest", "Points" } or { "EventIngest" },
    throttlingPercentage = throttlingPercentage,
    lastUpdated = FFlagLuaAppIedpSendPoints and { 25, 11, 19 } or { 25, 11, 11 },
    description = "Fires when the play button is clicked in the in-experience details prompt"
}

local function fireInExperienceDetailsPromptPlayButtonClickedEvent(customFields)
    local var2, var3 = var1(customFields)

    if not var2 then
        DiscoveryEventErrorLogger.reportError("InExperienceDetailsPromptPlayClickedInvalidInterface", var3)
    end

    TelemetryService:LogEvent(
        config,
        {
            standardizedFields = { "addUniverseId", "addOSInfo" },
            customFields = customFields
        }
    )
end
return fireInExperienceDetailsPromptPlayButtonClickedEvent
