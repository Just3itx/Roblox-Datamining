-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T23:11:21Z
-- Luau bytecode version: 14 | Luau type version: 3
local AppShortcutBarParent = script:FindFirstAncestor("AppShortcutBar").Parent

local Signals = require(AppShortcutBarParent.Signals)
local createButtonHoldStore = require(script.createButtonHoldStore)

return Signals.createComputed(createButtonHoldStore)
