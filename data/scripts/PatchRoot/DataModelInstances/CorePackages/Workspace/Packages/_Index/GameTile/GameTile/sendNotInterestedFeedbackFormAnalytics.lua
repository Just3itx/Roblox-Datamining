-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T22:31:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TelemetryService = game:GetService("TelemetryService")
local GameTileParent = script:FindFirstAncestor("GameTile").Parent

local t = require(GameTileParent.t)
local DiscoveryEventErrorLogger = require(GameTileParent.DiscoveryUtils).DiscoveryEventErrorLogger

local throttlingPercentage = game:DefineFastInt("NotInterestedFeedbackFormActionThrottleHundredthsPercent", 0)

local var1 = t.strictInterface({ universeId = t.string, sortId = t.optional(t.string), actionType = t.string })

local config = {
    eventName = "notInterestedFeedbackFormAction",
    backends = { "EventIngest" },
    throttlingPercentage = throttlingPercentage,
    lastUpdated = { 25, 10, 22 },
    description = "User has taken an action with the Not Interested Feedback Form"
}

return function(customFields, eventContext: string)
    if not eventContext then
        DiscoveryEventErrorLogger.reportError("NotInterestedFeedbackFormActionInvalidInterface", "event is missing context")
    end

    local var2, var3 = var1(customFields)
    if not var2 then
        DiscoveryEventErrorLogger.reportError("NotInterestedFeedbackFormActionInvalidInterface", var3)
    end

    TelemetryService:LogEvent(
        config,
        {
            eventContext = eventContext,
            standardizedFields = { "addSessionInfo" },
            customFields = customFields
        }
    )
end
