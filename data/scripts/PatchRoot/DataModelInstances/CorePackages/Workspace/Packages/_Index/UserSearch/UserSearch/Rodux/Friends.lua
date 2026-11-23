-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T03:10:56Z
-- Luau bytecode version: 14 | Luau type version: 3
local UserSearch = script:FindFirstAncestor("UserSearch")
local UserSearchParent = UserSearch.Parent

local RoduxFriends = require(UserSearch.Rodux.RoduxFriends)
local convertActions = require(UserSearchParent.SocialReducerAdaptors).convertActions
local friendsActionAdaptor = require(UserSearchParent.SocialReducerAdaptors).friendsActionAdaptor

return convertActions(RoduxFriends.installReducer(), friendsActionAdaptor(RoduxFriends), {
    countsByUserId = {},
    byUserId = {},
    requests = { receivedCount = 0 },
    recommendations = {},
    friendshipStatus = {},
    followings = {},
    friendsRankByUserId = {}
})
