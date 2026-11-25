-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T05:41:02Z
-- Luau bytecode version: 14 | Luau type version: 3
local ProfilePlatformParent = script:FindFirstAncestor("ProfilePlatform").Parent

local FFlagEnableBottomNavOnMarketplace = require(ProfilePlatformParent.SharedFlags).FFlagEnableBottomNavOnMarketplace
local FFlagAXEnableProfileTab = require(ProfilePlatformParent.SharedFlags).FFlagAXEnableProfileTab
local FFlagAppIaScopedScrollAway = require(ProfilePlatformParent.SharedFlags).FFlagAppIaScopedScrollAway

return FFlagAXEnableProfileTab
    and FFlagAppIaScopedScrollAway
    and FFlagEnableBottomNavOnMarketplace
    and game:DefineFastFlag("ProfilePlatformMeTabScrollAway", false)
