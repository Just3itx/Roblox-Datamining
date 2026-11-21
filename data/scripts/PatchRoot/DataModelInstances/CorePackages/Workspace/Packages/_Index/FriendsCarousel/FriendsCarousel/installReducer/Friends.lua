-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T14:11:14Z
-- Luau bytecode version: 14 | Luau type version: 3
local FriendsCarousel = script:FindFirstAncestor("FriendsCarousel")
local dependencies = require(FriendsCarousel.dependencies)
local RoduxFriends = dependencies.RoduxFriends
local convertActions = dependencies.convertActions
local friendsActionAdaptor = dependencies.friendsActionAdaptor

return convertActions(RoduxFriends.installReducer(), friendsActionAdaptor(RoduxFriends), {
    countsByUserId = {},
    byUserId = {},
    requests = { receivedCount = 0, newFriendRequestsCount = 0 },
    recommendations = {},
    friendshipStatus = {},
    friendsRankByUserId = {}
})
