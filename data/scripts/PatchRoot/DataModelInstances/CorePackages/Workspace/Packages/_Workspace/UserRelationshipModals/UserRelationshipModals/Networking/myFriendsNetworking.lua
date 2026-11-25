-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T21:11:06Z
-- Luau bytecode version: 14 | Luau type version: 3
local UserRelationshipModalsParent = script:FindFirstAncestor("UserRelationshipModals").Parent

local FriendsNetworking = require(UserRelationshipModalsParent.FriendsNetworking)

local myRoduxNetworking = require(script.Parent.myRoduxNetworking)

return FriendsNetworking.config({ roduxNetworking = myRoduxNetworking })
