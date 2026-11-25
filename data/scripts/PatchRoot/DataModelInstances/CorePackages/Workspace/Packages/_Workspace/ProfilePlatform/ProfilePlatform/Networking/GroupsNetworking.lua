-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T06:01:09Z
-- Luau bytecode version: 14 | Luau type version: 3
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local ProfilePlatformParent = ProfilePlatform.Parent

local GroupsNetworking = require(ProfilePlatformParent.GroupsNetworking)
local myRoduxNetworking = require(ProfilePlatform.Networking.myRoduxNetworking)

return (GroupsNetworking.config({ roduxNetworking = myRoduxNetworking }))
