-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T01:01:28Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local ConnectionUtil = require(script.ConnectionUtil)

return {
    ["jest.config"] = script["jest.config"],
    AvatarUtil = require(script.AvatarUtil),
    ConnectionUtil = ConnectionUtil,
    Constants = require(script.Constants),
    Url = require(script.Url),
    SettingsUtility = require(script.SettingsUtility),
    SettingsShowSignal = require(script.SettingsUtility).CreateSignal(),
    MouseIconOverrideService = require(script.MouseIconOverrideService)
}
