-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T15:50:36Z
-- Luau bytecode version: 14 | Luau type version: 3
local ServerTriggeredModalsParent = script:FindFirstAncestor("ServerTriggeredModals").Parent

local Signals = require(ServerTriggeredModalsParent.Signals)

local createModalSignalStore = require(script.Parent.createModalSignalStore)

return Signals.createComputed(createModalSignalStore)
