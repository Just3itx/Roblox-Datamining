-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T08:31:18Z
-- Luau bytecode version: 14 | Luau type version: 3
local NotificationsOrchestrator = script:FindFirstAncestor("NotificationsOrchestrator")
local NotificationsOrchestratorParent = NotificationsOrchestrator.Parent

local Signals = require(NotificationsOrchestratorParent.Signals)
local createNotificationsStore = require(NotificationsOrchestrator.Internal.createNotificationsStore)

return Signals.createComputed(createNotificationsStore)
