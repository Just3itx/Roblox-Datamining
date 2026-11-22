-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T09:41:01Z
-- Luau bytecode version: 14 | Luau type version: 3
local PlayerContextualMenuParent = script:FindFirstAncestor("PlayerContextualMenu").Parent
local RoduxNetworking = require(script.Parent.RoduxNetworking)

return require(PlayerContextualMenuParent.FriendsNetworking).config({ roduxNetworking = RoduxNetworking })
