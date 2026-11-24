-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T06:00:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
return {
    ["jest.config"] = script["jest.config"],
    Flags = require(script.Flags),
    GetDisplayStore = require(script.Stores.GetDisplayStore),
    getGlobalGuiInset = require(script.getGlobalGuiInset),
    shouldUseDeviceSafeInsets = require(script.shouldUseDeviceSafeInsets)
}
