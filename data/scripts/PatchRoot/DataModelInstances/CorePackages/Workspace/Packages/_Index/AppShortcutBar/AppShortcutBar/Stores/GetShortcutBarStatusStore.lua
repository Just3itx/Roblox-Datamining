-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T23:11:25Z
-- Luau bytecode version: 14 | Luau type version: 3
local AppShortcutBarParent = script:FindFirstAncestor("AppShortcutBar").Parent

local Signals = require(AppShortcutBarParent.Signals)
local createShortcutBarStatusStore = require(script.createShortcutBarStatusStore)

if require(AppShortcutBarParent.SharedFlags).FFlagEnableStickyShortcutBarOnAllPlatforms then
    return require(AppShortcutBarParent.AppShortcutBarStore).GetShortcutBarStatusStore
end

return Signals.createComputed(createShortcutBarStatusStore)
