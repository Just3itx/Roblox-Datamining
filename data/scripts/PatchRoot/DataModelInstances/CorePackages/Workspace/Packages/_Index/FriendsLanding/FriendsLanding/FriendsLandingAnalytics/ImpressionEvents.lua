-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T16:01:04Z
-- Luau bytecode version: 14 | Luau type version: 3
local FriendsLanding = script:FindFirstAncestor("FriendsLanding")
return require(FriendsLanding.dependencies).enumerate(script.Name, {
    ContactWarningSeen = "contactWarningSeen",
    ContactImporterBannerSeen = "contactImporterBannerSeen",
    ContactImporterOnAddFriends = "contactImporterOnAddFriends",
    FriendPruningTooltipSeen = "friendPruningTooltipSeen",
    FriendPruningNewBadgeSeen = "friendPruningNewBadgeSeen",
    ProfileQRCodeBannerSeen = "profileQRCodeBannerSeen"
})
