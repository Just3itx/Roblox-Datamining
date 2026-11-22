-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T16:31:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local ActionHandlers = require(script.ActionHandlers)
return {
    createSignalsMiddleware = require(script.SignalsMiddleware),
    ActionHandlers = ActionHandlers,
    ["jest.config"] = script["jest.config"]
}
