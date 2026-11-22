-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T13:21:13Z
-- Luau bytecode version: 14 | Luau type version: 3
local scriptParentParent = script.Parent.Parent
local dependencies = require(scriptParentParent.dependencies)
local enumerate = dependencies.enumerate
local getFFlagPYMKAddFriendsEntry = dependencies.getFFlagPYMKAddFriendsEntry

return enumerate(script.Name, {
    CarouselLoadedWithUsers = "CarouselLoadedWithUsers",
    PYMKCarouselLoadingTime = "PYMKCarouselLoadingTime",
    UserSeen = "UserSeen",
    UserSeenCollection = "UserSeenCollection",
    UserPressed = "UserPressed",
    RequestFriendship = "RequestFriendship",
    AcceptFriendship = "AcceptFriendship",
    CarouselGenericTileClicked = if getFFlagPYMKAddFriendsEntry() then "CarouselGenericTileClicked" else nil,
    PYMKUserPresenceLoad = "PYMKUserPresenceLoad"
})
