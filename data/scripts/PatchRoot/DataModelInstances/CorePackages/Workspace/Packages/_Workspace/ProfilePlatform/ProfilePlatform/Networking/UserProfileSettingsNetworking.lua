-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T06:01:29Z
-- Luau bytecode version: 14 | Luau type version: 3
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local ProfilePlatformParent = ProfilePlatform.Parent

local UserProfileSettingsNetworking = require(ProfilePlatformParent.UserProfileSettingsNetworking)
local myRoduxNetworking = require(ProfilePlatform.Networking.myRoduxNetworking)

return (UserProfileSettingsNetworking.config({ roduxNetworking = myRoduxNetworking }))
