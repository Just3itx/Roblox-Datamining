-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T20:31:27Z
-- Luau bytecode version: 14 | Luau type version: 3
local UserProfilesParent = script:FindFirstAncestor("UserProfiles").Parent

return require(UserProfilesParent.Analytics).Analytics.new(game:GetService("RbxAnalyticsService"))
