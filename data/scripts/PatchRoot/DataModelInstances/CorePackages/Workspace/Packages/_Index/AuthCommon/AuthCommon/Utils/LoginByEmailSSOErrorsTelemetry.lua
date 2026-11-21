-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T01:00:42Z
-- Luau bytecode version: 14 | Luau type version: 3
local AuthCommonParent = script:FindFirstAncestor("AuthCommon").Parent

local LoggingProtocol = require(AuthCommonParent.LoggingProtocol)

game:DefineFastInt("LoginByEmailSSOErrorsThrottleHundrethsPercent", 0)

return {
    eventName = "LoginByEmailSSOErrors",
    backends = { LoggingProtocol.TelemetryBackends.Points },
    throttlingPercentage = game:GetFastInt("LoginByEmailSSOErrorsThrottleHundrethsPercent"),
    lastUpdated = { 26, 10, 5 },
    description = "Report LoginByEmail SSO error codes to Points with document name \"loginbyemailssoerrors\""
}
