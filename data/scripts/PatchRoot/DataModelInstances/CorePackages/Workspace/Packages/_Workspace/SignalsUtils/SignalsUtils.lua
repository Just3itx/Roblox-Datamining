-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T15:00:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
return {
    createDetachedEffect = require(script.createDetachedEffect),
    createCurrentTimeSignal = require(script.createCurrentTimeSignal),
    createSessionScopedSignal = require(script.createSessionScopedSignal),
    ["jest.config"] = script["jest.config"]
}
