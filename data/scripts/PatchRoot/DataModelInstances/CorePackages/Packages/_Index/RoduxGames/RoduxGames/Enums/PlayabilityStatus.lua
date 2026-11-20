-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T14:01:21Z
-- Luau bytecode version: 14 | Luau type version: 3
local RoduxGamesParent = script:FindFirstAncestor("RoduxGames").Parent
return require(RoduxGamesParent.enumerate)(script.Name, {
    Playable = "Playable",
    UnplayableOtherReason = "UnplayableOtherReason",
    GuestProhibited = "GuestProhibited",
    GameUnapproved = "GameUnapproved",
    IncorrectConfiguration = "IncorrectConfiguration",
    UniverseRootPlaceIsPrivate = "UniverseRootPlaceIsPrivate",
    InsufficientPermissionFriendsOnly = "InsufficientPermissionFriendsOnly",
    InsufficientPermissionGroupOnly = "InsufficientPermissionGroupOnly",
    DeviceRestricted = "DeviceRestricted",
    UnderReview = "UnderReview",
    PurchaseRequired = "PurchaseRequired",
    AccountRestricted = "AccountRestricted",
    TemporarilyUnavailable = "TemporarilyUnavailable"
})
