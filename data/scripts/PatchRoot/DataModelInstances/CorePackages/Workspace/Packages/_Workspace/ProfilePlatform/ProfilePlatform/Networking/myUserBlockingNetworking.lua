-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T06:01:13Z
-- Luau bytecode version: 14 | Luau type version: 3
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local ProfilePlatformParent = ProfilePlatform.Parent

local UserBlockingNetworking = require(ProfilePlatformParent.UserBlockingNetworking)
local myRoduxNetworking = require(ProfilePlatform.Networking.myRoduxNetworking)

return (UserBlockingNetworking.config({ roduxNetworking = myRoduxNetworking }))
