-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T14:10:51Z
-- Luau bytecode version: 14 | Luau type version: 3
local scriptParentParent = script.Parent.Parent
return require(scriptParentParent.dependencies).enumerate(script.Name, {
    CarouselLoadedWithUsers = "CarouselLoadedWithUsers",
    UserSeen = "UserSeen",
    UserPressed = "UserPressed",
    RequestFriendship = "RequestFriendship",
    RevokeFriendRequest = "RevokeFriendRequest",
    ViewAllFriends = "ViewAllFriends",
    ViewAddFriends = "ViewAddFriends",
    CarouselLoadingTime = "CarouselLoadingTime",
    ContactImporterOnAddFriends = "ContactImporterOnAddFriends",
    PaginatedFriendsCarouselLoadingTime = "PaginatedFriendsCarouselLoadingTime",
    FriendsEndpointLoadingTime = "FriendsEndpointLoadingTime",
    FriendsCarouselUILoadingTime = "FriendsCarouselUILoadingTime",
    OnlineFriendsRefetchOnPresenceUpdate = "OnlineFriendsRefetchOnPresenceUpdate",
    OnlineFriendsRefetchOnFriendshipUpdate = "OnlineFriendsRefetchOnFriendshipUpdate"
})
