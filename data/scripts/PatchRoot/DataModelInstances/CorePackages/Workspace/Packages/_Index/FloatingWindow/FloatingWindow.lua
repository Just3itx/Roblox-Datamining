-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T13:30:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local BehaviorKind = require(script.BehaviorKind)
local Behaviors = require(script.Behaviors)
local _Types = require(script.Types)
return {
    BehaviorKind = BehaviorKind,
    Behaviors = Behaviors,
    Window = require(script.Window),
    ["jest.config"] = script["jest.config"]
}
