-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T00:00:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local HoldToPlayLauncher = require(script.HoldToPlayLauncher)
local useHoldToPlayStateAndCallbacks = require(script.useHoldToPlayStateAndCallbacks)
return {
    Constants = require(script.Constants),
    HoldToPlayLauncher = HoldToPlayLauncher,
    HoldDetector = require(script.HoldDetector),
    useHoldToPlayStateAndCallbacks = useHoldToPlayStateAndCallbacks,
    ["jest.config"] = script["jest.config"]
}
