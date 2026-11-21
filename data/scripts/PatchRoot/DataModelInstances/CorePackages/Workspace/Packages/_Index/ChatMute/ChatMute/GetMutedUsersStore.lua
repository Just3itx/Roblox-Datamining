-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T07:00:45Z
-- Luau bytecode version: 14 | Luau type version: 3
local ChatMuteParent = script:FindFirstAncestor("ChatMute").Parent
local Signals = require(ChatMuteParent.Signals)
local createMutedUsersStore = require(script.Parent.createMutedUsersStore)

return Signals.createComputed(createMutedUsersStore)
