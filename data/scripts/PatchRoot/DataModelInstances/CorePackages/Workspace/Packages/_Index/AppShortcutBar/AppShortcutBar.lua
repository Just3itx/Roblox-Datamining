-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T23:10:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local AppShortcutBarContainer = require(script.Components.AppShortcutBarContainer)
local AppShortcutBarStatusListener = require(script.Components.AppShortcutBarStatusListener)
local AppShortcut = require(script.Components.AppShortcut)
local StickyShortcutBarExposureLogger = require(script.Components.StickyShortcutBarExposureLogger)

local AppShortcutBarContext = require(script.Hooks.AppShortcutBarContext)
local Hooks = require(script.Hooks)
local GetShortcutBarStatusStore = require(script.Stores.GetShortcutBarStatusStore)

return {
    AppShortcutBarContainer = AppShortcutBarContainer,
    AppShortcutBarStatusListener = AppShortcutBarStatusListener,
    StickyShortcutBarExposureLogger = StickyShortcutBarExposureLogger,
    IconWithHoldAnimation = AppShortcut.IconWithHoldAnimation,
    AppShortcutBarContext = AppShortcutBarContext,
    Hooks = Hooks,
    GetShortcutBarStatusStore = GetShortcutBarStatusStore,
    ["jest.config"] = script["jest.config"]
}
