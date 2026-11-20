-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T23:21:24Z
-- Luau bytecode version: 14 | Luau type version: 3
local AppShortcutBarStoreParent = script:FindFirstAncestor("AppShortcutBarStore").Parent

local Signals = require(AppShortcutBarStoreParent.Signals)
local createShortcutBarStatusStore = require(script.createShortcutBarStatusStore)

return Signals.createComputed(createShortcutBarStatusStore)
