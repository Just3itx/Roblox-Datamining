-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T16:00:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local _Types = require(script.Analytics.Types)
local _Contexts = require(script.Analytics.Enums.Contexts)
local _PlatformSpecificity = require(script.Analytics.Enums.PlatformSpecificity)
local telemetryNewConfig = require(script.Telemetry.telemetryNewConfig)
local Performance = require(script.Performance)

return {
    ["jest.config"] = script["jest.config"],
    Analytics = require(script.Analytics),
    TestingAnalytics = require(script.TestingAnalytics),
    Performance = Performance,
    Telemetry = {
        new = telemetryNewConfig,
        createEmitter = require(script.Telemetry.telemetryCreateEmitter)
    }
}
