-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T12:30:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
return {
    dependencies = require(script.dependencies),
    Events = require(script.Events),
    EventStreamConstants = require(script.Constants.EventStreamConstants),
    LoginType = require(script.Constants.LoginType),
    authTimingUtil = require(script.Utils.authTimingUtil),
    TelemetryConfigs = require(script.RobloxTelemetry.TelemetryConfigs),
    RobloxTelemetry = require(script.RobloxTelemetry),
    Flags = {
        FFlagEnableTimeToLoginMetrics = require(script.Flags.FFlagEnableTimeToLoginMetrics),
        FFlagRestartTimeToLoginOnHumanInteractionRetry = require(script.Flags.FFlagRestartTimeToLoginOnHumanInteractionRetry)
    },
    ["jest.config"] = script["jest.config"]
}
