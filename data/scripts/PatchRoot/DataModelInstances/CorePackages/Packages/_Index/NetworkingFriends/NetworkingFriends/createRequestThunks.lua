-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T11:01:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local _networkingFriendsTypes = require(script.Parent.networkingFriendsTypes)

local networkRequests = script.Parent.networkRequests
local createGetFriendsFromUserId = require(networkRequests.createGetFriendsFromUserId)
local createFindFriendsFromUserId = require(networkRequests.createFindFriendsFromUserId)
local createSearchFriendsByQuery = require(networkRequests.createSearchFriendsByQuery)
local createGetFriendRequestsCount = require(networkRequests.createGetFriendRequestsCount)
local createUnfriendTargetUserId = require(networkRequests.createUnfriendTargetUserId)
local createGetFriendRequests = require(networkRequests.createGetFriendRequests)
local createAcceptFriendRequestFromUserId = require(networkRequests.createAcceptFriendRequestFromUserId)
local createDeclineFriendRequestFromUserId = require(networkRequests.createDeclineFriendRequestFromUserId)
local createDeclineAllFriendRequests = require(networkRequests.createDeclineAllFriendRequests)
local createGetFriendsCountFromUserId = require(networkRequests.createGetFriendsCountFromUserId)
local createGetInactiveFriends = require(networkRequests.createGetInactiveFriends)
local createRequestFriendshipFromUserId = require(networkRequests.createRequestFriendshipFromUserId)

local createRequestFriendshipFromContactId = require(networkRequests.createRequestFriendshipFromContactId)
local createGetFollowingExists = require(networkRequests.createGetFollowingExists)
local createGetUserFollowers = require(networkRequests.createGetUserFollowers)

local createGetFriendRecommendationsFromUserId = require(networkRequests.createGetFriendRecommendationsFromUserId)

local createGetFriendshipStatus = require(networkRequests.createGetFriendshipStatus)

local createGetExtendedFriendshipStatus = require(networkRequests.createGetExtendedFriendshipStatus)
local createAcceptFriendRequestWithToken = require(networkRequests.createAcceptFriendRequestWithToken)
local createGetFollowersCount = require(networkRequests.createGetFollowersCount)
local createGetFollowingsCount = require(networkRequests.createGetFollowingsCount)
local createValidateFriendRequestNickname = require(networkRequests.createValidateFriendRequestNickname)

return function(arg1)
    return {
        GetFriendsFromUserId = createGetFriendsFromUserId(arg1),
        FindFriendsFromUserId = createFindFriendsFromUserId(arg1),
        SearchFriendsByQuery = createSearchFriendsByQuery(arg1),
        GetFriendRequestsCount = createGetFriendRequestsCount(arg1),
        UnfriendTargetUserId = createUnfriendTargetUserId(arg1),
        GetFriendRequests = createGetFriendRequests(arg1),
        AcceptFriendRequestFromUserId = createAcceptFriendRequestFromUserId(arg1),
        DeclineFriendRequestFromUserId = createDeclineFriendRequestFromUserId(arg1),
        DeclineAllFriendRequests = createDeclineAllFriendRequests(arg1),
        GetFriendsCountFromUserId = createGetFriendsCountFromUserId(arg1),
        GetInactiveFriends = createGetInactiveFriends(arg1),
        RequestFriendshipFromUserId = createRequestFriendshipFromUserId(arg1),
        RequestFriendshipFromContactId = createRequestFriendshipFromContactId(arg1),
        GetFollowingExists = createGetFollowingExists(arg1),
        GetUserFollowers = createGetUserFollowers(arg1),
        GetFriendRecommendationsFromUserId = createGetFriendRecommendationsFromUserId(arg1),
        GetFriendshipStatus = createGetFriendshipStatus(arg1),
        GetExtendedFriendshipStatus = createGetExtendedFriendshipStatus(arg1),
        AcceptFriendRequestWithToken = createAcceptFriendRequestWithToken(arg1),
        GetFollowersCount = createGetFollowersCount(arg1),
        GetFollowingsCount = createGetFollowingsCount(arg1),
        ValidateFriendRequestNickname = createValidateFriendRequestNickname(arg1)
    }
end
