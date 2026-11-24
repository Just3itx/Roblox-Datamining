-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T22:41:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TelemetryService = game:GetService("TelemetryService")
local UserGameSettings = UserSettings():GetService("UserGameSettings")
local InteractionFeedbackParent = script:FindFirstAncestor("InteractionFeedback").Parent

local t = require(InteractionFeedbackParent.t)
local DiscoveryEventErrorLogger = require(InteractionFeedbackParent.DiscoveryUtils).DiscoveryEventErrorLogger

local throttlingPercentage = game:DefineFastInt("HapticTriggerAttemptThrottleHundredthsPercent", 0)

local var1 = t.interface({ hapticType = t.string, contextKey = t.string, interactionType = t.string })

return function(customFields, eventContext: string)
    if not eventContext then
        DiscoveryEventErrorLogger.reportError("HapticTriggerAttemptInvalidInterface", "event is missing context")
    end

    local var2, var3 = var1(customFields)
    if not var2 then
        DiscoveryEventErrorLogger.reportError("HapticTriggerAttemptInvalidInterface", var3)
    end

    local config = {
        eventName = "hapticTriggerAttempt",
        backends = { "EventIngest" },
        throttlingPercentage = throttlingPercentage,
        lastUpdated = { 25, 10, 21 },
        description = "User has taken an action that may have triggered haptic feedback"
    }

    local hapticStrength = UserGameSettings.HapticStrength
    customFields.hapticEnabledByUser = hapticStrength > 0
    customFields.hapticStrength = hapticStrength
    TelemetryService:LogEvent(
        config,
        {
            eventContext = eventContext,
            standardizedFields = { "addOSInfo", "addSessionInfo" },
            customFields = customFields
        }
    )
end
