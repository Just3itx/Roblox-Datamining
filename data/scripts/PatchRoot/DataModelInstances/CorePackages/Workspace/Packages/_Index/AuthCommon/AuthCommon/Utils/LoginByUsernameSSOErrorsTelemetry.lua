-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T01:00:46Z
-- Luau bytecode version: 14 | Luau type version: 3
local AuthCommonParent = script:FindFirstAncestor("AuthCommon").Parent

local LoggingProtocol = require(AuthCommonParent.LoggingProtocol)

game:DefineFastInt("LoginByUsernameSSOErrorsThrottleHundrethsPercent", 0)

return {
    eventName = "LoginByUsernameSSOErrors",
    backends = { LoggingProtocol.TelemetryBackends.Points },
    throttlingPercentage = game:GetFastInt("LoginByUsernameSSOErrorsThrottleHundrethsPercent"),
    lastUpdated = { 24, 5, 3 },
    description = "Report LoginByUsernameSSO Error codes to Points with document name \"loginbyusernamessoerrors\""
}
