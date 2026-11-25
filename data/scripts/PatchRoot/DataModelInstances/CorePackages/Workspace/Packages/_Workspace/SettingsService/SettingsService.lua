-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T13:51:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local SettingsService = require(script.SettingsService)
local _Types = require(script.Types)
return {
    SettingEnum = require(script.SettingEnum),
    SettingsService = SettingsService,
    ValueChangedSignal = require(script.ValueChangedSignal),
    AvailabilitySignal = require(script.AvailabilitySignal),
    VisibilitySignal = require(script.VisibilitySignal),
    ["jest.config"] = script["jest.config"]
}
