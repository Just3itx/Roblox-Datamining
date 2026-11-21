-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T01:00:45Z
-- Luau bytecode version: 14 | Luau type version: 3
local AuthCommonParent = script:FindFirstAncestor("AuthCommon").Parent

local LoggingProtocol = require(AuthCommonParent.LoggingProtocol)

game:DefineFastInt("LoginByPhoneSSOErrorsThrottleHundrethsPercent", 0)

return {
    eventName = "LoginByPhoneSSOErrors",
    backends = { LoggingProtocol.TelemetryBackends.Points },
    throttlingPercentage = game:GetFastInt("LoginByPhoneSSOErrorsThrottleHundrethsPercent"),
    lastUpdated = { 26, 10, 5 },
    description = "Report LoginByPhoneSSO Error codes to Points with document name \"loginbyphonessoerrors\""
}
