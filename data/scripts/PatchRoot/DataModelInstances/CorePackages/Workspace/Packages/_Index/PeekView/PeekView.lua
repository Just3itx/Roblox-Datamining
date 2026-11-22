-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T08:50:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local PeekViewState = require(script.PeekViewState)
local PeekView = require(script.PeekView)
local PeekViewWithTopBar = require(script.PeekViewWithTopBar)
local peekViewDismissedEvent = require(script.analytics.peekViewDismissedEvent)
local Scrim = require(script.Scrim)

return {
    analytics = { peekViewDismissedEvent = peekViewDismissedEvent },
    ["jest.config"] = script["jest.config"],
    PeekViewState = PeekViewState,
    PeekView = PeekView,
    PeekViewWithTopBar = PeekViewWithTopBar,
    Scrim = Scrim
}
