-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T23:21:32Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local SplitView = require(script.Components.SplitView)
local Enums = require(script.Common.Enums)

return {
    SplitView = SplitView,
    PaneResizer = require(script.Components.PaneResizer),
    useSplitViewResize = require(script.Hooks.useSplitViewResize),
    Enums = Enums,
    ["jest.config"] = script["jest.config"]
}
