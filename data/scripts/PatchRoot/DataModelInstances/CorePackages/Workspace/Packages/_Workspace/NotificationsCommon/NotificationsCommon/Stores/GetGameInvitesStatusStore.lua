-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T00:21:13Z
-- Luau bytecode version: 14 | Luau type version: 3
local NotificationsCommonParent = script:FindFirstAncestor("NotificationsCommon").Parent

local Signals = require(NotificationsCommonParent.Signals)
local createGameInvitesStatusStore = require(script.createGameInvitesStatusStore)

return Signals.createComputed(createGameInvitesStatusStore)
