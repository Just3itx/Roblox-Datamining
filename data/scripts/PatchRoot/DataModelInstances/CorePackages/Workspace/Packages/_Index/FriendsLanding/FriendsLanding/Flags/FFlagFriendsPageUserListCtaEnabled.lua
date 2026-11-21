-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T15:51:16Z
-- Luau bytecode version: 14 | Luau type version: 3
local FriendsLandingParent = script:FindFirstAncestor("FriendsLanding").Parent

local SharedFlags = require(FriendsLandingParent.SharedFlags)

return game:DefineFastFlag("FriendsPageUserListCtaEnabled", false)
    and SharedFlags.FFlagFriendsPageUserListEnabled
    and SharedFlags.FFlagUserListCtaIntegrationEnabled
    and SharedFlags.FFlagUserListSurfacePresenceWins
    and SharedFlags.FFlagUserListDefaultCtaWidths
