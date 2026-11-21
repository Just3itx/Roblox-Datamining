-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T12:10:49Z
-- Luau bytecode version: 14 | Luau type version: 3
local EditProfileParent = script:FindFirstAncestor("EditProfile").Parent

local UserProfileSettingsNetworking = require(EditProfileParent.UserProfileSettingsNetworking)
local ProfileRoduxNetworking = require(script.Parent.ProfileRoduxNetworking)

return (UserProfileSettingsNetworking.config({ roduxNetworking = ProfileRoduxNetworking }))
