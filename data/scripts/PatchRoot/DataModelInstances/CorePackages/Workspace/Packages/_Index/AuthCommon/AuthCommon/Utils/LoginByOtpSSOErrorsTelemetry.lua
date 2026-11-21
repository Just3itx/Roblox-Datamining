-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T01:00:43Z
-- Luau bytecode version: 14 | Luau type version: 3
local AuthCommonParent = script:FindFirstAncestor("AuthCommon").Parent

local LoggingProtocol = require(AuthCommonParent.LoggingProtocol)

game:DefineFastInt("LoginByOtpSSOErrorsThrottleHundrethsPercent", 0)

return {
    eventName = "LoginByOtpSSOErrors",
    backends = { LoggingProtocol.TelemetryBackends.Points },
    throttlingPercentage = game:GetFastInt("LoginByOtpSSOErrorsThrottleHundrethsPercent"),
    lastUpdated = { 26, 10, 20 },
    description = "Report LoginByOtp SSO error codes to Points with document name \"loginbyotpssoerrors\""
}
