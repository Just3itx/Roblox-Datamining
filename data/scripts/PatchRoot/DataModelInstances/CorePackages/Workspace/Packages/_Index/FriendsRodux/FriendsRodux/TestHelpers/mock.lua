-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T17:10:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FriendsRoduxParent = script:FindFirstAncestor("FriendsRodux").Parent
local Rodux = require(FriendsRoduxParent.Rodux)

local mockGetFriendsFromUserIdAction = Rodux.makeActionCreator("GET_FRIENDS_SUCCEEDED_ACTION", function(users, arg1, userSort)
    return {
        responseBody = { data = arg1 },
        namedIds = { users = users },
        queryArgs = { userSort = userSort }
    }
end)

local mockGetFriendsCountFromUserIdAction = Rodux.makeActionCreator("GET_FRIENDS_COUNT_SUCCEEDED_ACTION", function(users, count)
    return {
        responseBody = { count = count },
        namedIds = { users = users }
    }
end)

local mockRequestCountAction = Rodux.makeActionCreator("GET_REQUEST_COUNT", function(count)
    return {
        responseBody = { count = count }
    }
end)

local mockNewFriendRequestsCountAction = Rodux.makeActionCreator("GET_NEW_FRIEND_REQUEST_COUNT", function(count)
    return {
        responseBody = { count = count }
    }
end)

local mockClearNewFriendRequestsAction = Rodux.makeActionCreator("GET_NEW_FRIEND_REQUEST_COUNT", function(status)
    return {
        responseBody = { status = status }
    }
end)

local mockUnfriendTargetUserIdAction = Rodux.makeActionCreator("UNFRIEND_TARGET_USER_ID", function(arg1)
    return {
        namedIds = {
            users = arg1.targetUserId
        },
        additionalData = {
            currentUserId = arg1.currentUserId
        }
    }
end)

local mockAcceptFriendRequestFromUserIdAction = Rodux.makeActionCreator("ACCEPT_REQUEST_FROM_USER_ID", function(arg1)
    return {
        ids = arg1.ids,
        additionalData = {
            currentUserId = arg1.currentUserId
        }
    }
end)

local mockRequestFriendshipFromUserIdAction = Rodux.makeActionCreator("REQUEST_FRIENDSHIP_FROM_USER_ID", function(arg1)
    return {
        namedIds = {
            users = arg1.users
        },
        additionalData = {
            currentUserId = arg1.currentUserId
        }
    }
end)

local mockRequestFriendshipFromContactIdAction = Rodux.makeActionCreator("REQUEST_FRIENDSHIP_FROM_CONTACT_ID", function(arg1)
    return {
        namedIds = {
            contacts = arg1.contacts
        },
        additionalData = {
            currentUserId = arg1.currentUserId
        }
    }
end)

local mockDeclineFriendRequestFromUserIdAction = Rodux.makeActionCreator("DECLINE_REQUEST_FROM_USER_ID", function(arg1)
    return {
        ids = arg1.ids
    }
end)

local mockGetFriendRequestsAction = Rodux.makeActionCreator("GET_FRIEND_REQUESTS", function(arg1)
    return {
        responseBody = not arg1
            and {
                previousPageCursor = nil,
                nextPageCursor = "637699238608300000-46587081730_1_986dd841c63787446d580a8055b3fa73",
                data = {
                    {
                        friendRequest = {
                            sentAt = "2021-10-22T23:20:18.163Z",
                            senderId = 123,
                            sourceUniverseId = nil,
                            contactName = "Name",
                            senderNickname = "nickname"
                        },
                        mutualFriendsList = nil,
                        description = "me dan robux :) gracias",
                        created = "2021-01-19T02:01:21.997Z",
                        isBanned = false,
                        externalAppDisplayName = nil,
                        id = 123,
                        name = "TestUser_1",
                        displayName = "TestUser_1",
                        isUnseen = true
                    },
                    {
                        friendRequest = {
                            sentAt = "2021-10-22T23:20:18.163Z",
                            senderId = 456,
                            sourceUniverseId = 2092410051,
                            contactName = nil,
                            senderNickname = nil,
                            originSourceType = "qrCode"
                        },
                        mutualFriendsList = { 123, 345 },
                        description = "me dan robux :) gracias",
                        created = "2021-01-19T02:01:21.997Z",
                        isBanned = false,
                        externalAppDisplayName = nil,
                        id = 456,
                        name = "TestUser_2",
                        displayName = "TestUser_2",
                        isUnseen = false
                    }
                }
            }
            or arg1.data
            or {
                previousPageCursor = nil,
                nextPageCursor = "637699238608300000-46587081730_1_986dd841c63787446d580a8055b3fa73",
                data = {
                    {
                        friendRequest = {
                            sentAt = "2021-10-22T23:20:18.163Z",
                            senderId = 123,
                            sourceUniverseId = nil,
                            contactName = "Name",
                            senderNickname = "nickname"
                        },
                        mutualFriendsList = nil,
                        description = "me dan robux :) gracias",
                        created = "2021-01-19T02:01:21.997Z",
                        isBanned = false,
                        externalAppDisplayName = nil,
                        id = 123,
                        name = "TestUser_1",
                        displayName = "TestUser_1",
                        isUnseen = true
                    },
                    {
                        friendRequest = {
                            sentAt = "2021-10-22T23:20:18.163Z",
                            senderId = 456,
                            sourceUniverseId = 2092410051,
                            contactName = nil,
                            senderNickname = nil,
                            originSourceType = "qrCode"
                        },
                        mutualFriendsList = { 123, 345 },
                        description = "me dan robux :) gracias",
                        created = "2021-01-19T02:01:21.997Z",
                        isBanned = false,
                        externalAppDisplayName = nil,
                        id = 456,
                        name = "TestUser_2",
                        displayName = "TestUser_2",
                        isUnseen = false
                    }
                }
            },
        additionalData = {
            currentUserId = arg1 and arg1.currentUserId or nil
        }
    }
end)

local mockDeclineAllFriendRequestsAction = Rodux.makeActionCreator("DECLINE_ALL_FRIEND_REQUESTS", function(arg1)
    return {
        ids = arg1.ids
    }
end)

local mockGetFriendRecommendationsFromUserIdAction = Rodux.makeActionCreator("GET_FRIEND_RECOMMENDATIONS_FROM_USER_ID", function(users, arg1)
    return {
        responseBody = {
            data = arg1
                or {
                    {
                        friendRequest = nil,
                        rank = 2,
                        mutualFriendsList = { "1", "2" },
                        description = "string",
                        created = "2022-02-25T21:22:29.217Z",
                        isBanned = true,
                        externalAppDisplayName = "string",
                        id = 89,
                        name = "red",
                        displayName = "coolDisplayName"
                    },
                    {
                        friendRequest = nil,
                        rank = 4,
                        mutualFriendsList = {},
                        description = "string",
                        created = "2022-02-25T21:22:29.217Z",
                        isBanned = true,
                        externalAppDisplayName = "string",
                        id = 19,
                        name = "reputation",
                        contextType = "MutualFriends",
                        displayName = "anotherCoolName"
                    },
                    {
                        rank = 3,
                        mutualFriendsList = {},
                        description = "string",
                        created = "2022-02-25T21:22:29.217Z",
                        isBanned = true,
                        externalAppDisplayName = "string",
                        id = 25,
                        name = "reputation",
                        contextType = "MutualFriends",
                        displayName = "anotherCoolName",
                        friendRequest = {
                            sentAt = "2021-10-22T23:20:18.163Z",
                            senderId = 123,
                            sourceUniverseId = nil,
                            contactName = nil
                        }
                    },
                    {
                        rank = 1,
                        mutualFriendsList = {},
                        description = "string",
                        created = "2022-02-25T21:22:29.217Z",
                        isBanned = true,
                        externalAppDisplayName = "string",
                        id = 0,
                        contactId = "contactId",
                        thumbnailEntities = {
                            avatarImageUrl = "avatarImageUrl",
                            headshotImageUrl = "headshotImageUrl"
                        },
                        name = "reputation",
                        contextType = "Contacts",
                        displayName = "Contact Name"
                    }
                }
        },
        namedIds = {
            users = users or 678
        }
    }
end)

local mockGetFriendshipStatusAction = Rodux.makeActionCreator("GET_FRIENDSHIP_STATUS", function(_)
    return {
        responseBody = {
            data = {
                { id = 123, status = "NotFriends" },
                { id = 355, status = "Friends" }
            }
        }
    }
end)

local mockGetFriendshipStatusesAction = Rodux.makeActionCreator("GET_FRIENDSHIP_STATUSES", function(_)
    return {
        responseBody = {
            data = {
                { id = 123, status = "NotFriends" },
                { id = 355, status = "Friends" }
            }
        }
    }
end)

local mockGetUserExtendedFriendshipStatusAction = Rodux.makeActionCreator("GET_EXTENDED_FRIENDSHIP_STATUS", function(arg1, responseBody)
    return {
        responseBody = responseBody,
        ids = { arg1 }
    }
end)

local mockBlockUserByIdAction = Rodux.makeActionCreator("BLOCK_USER_BY_ID", function(arg1, responseBody)
    return {
        responseBody = responseBody,
        namedIds = {
            users = arg1.userId
        },
        additionalData = {
            currentUserId = arg1.currentUserId
        }
    }
end)

return {
    mockGetFriendsFromUserId = "GET_FRIENDS_SUCCEEDED_ACTION",
    mockGetFriendsFromUserIdAction = mockGetFriendsFromUserIdAction,
    mockGetFriendsCountFromUserId = "GET_FRIENDS_COUNT_SUCCEEDED_ACTION",
    mockGetFriendsCountFromUserIdAction = mockGetFriendsCountFromUserIdAction,
    mockRequestCount = "GET_REQUEST_COUNT",
    mockRequestCountAction = mockRequestCountAction,
    mockGetNewRequestsCount = "GET_NEW_FRIEND_REQUEST_COUNT",
    mockNewFriendRequestsCountAction = mockNewFriendRequestsCountAction,
    mockClearNewFriendRequests = "CLEAR_NEW_FRIEND_REQUEST_COUNT",
    mockClearNewFriendRequestsAction = mockClearNewFriendRequestsAction,
    mockUnfriendTargetUserId = "UNFRIEND_TARGET_USER_ID",
    mockUnfriendTargetUserIdAction = mockUnfriendTargetUserIdAction,
    mockAcceptFriendRequestFromUserId = "ACCEPT_REQUEST_FROM_USER_ID",
    mockAcceptFriendRequestFromUserIdAction = mockAcceptFriendRequestFromUserIdAction,
    mockRequestFriendshipFromUserId = "REQUEST_FRIENDSHIP_FROM_USER_ID",
    mockRequestFriendshipFromUserIdAction = mockRequestFriendshipFromUserIdAction,
    mockRequestFriendshipFromContactId = "REQUEST_FRIENDSHIP_FROM_CONTACT_ID",
    mockRequestFriendshipFromContactIdAction = mockRequestFriendshipFromContactIdAction,
    mockDeclineFriendRequestFromUserId = "DECLINE_REQUEST_FROM_USER_ID",
    mockDeclineFriendRequestFromUserIdAction = mockDeclineFriendRequestFromUserIdAction,
    mockGetFriendRequests = "GET_FRIEND_REQUESTS",
    mockGetFriendRequestsAction = mockGetFriendRequestsAction,
    mockDeclineAllFriendRequests = "DECLINE_ALL_FRIEND_REQUESTS",
    mockDeclineAllFriendRequestsAction = mockDeclineAllFriendRequestsAction,
    mockGetFriendRecommendationsFromUserId = "GET_FRIEND_RECOMMENDATIONS_FROM_USER_ID",
    mockGetFriendRecommendationsFromUserIdAction = mockGetFriendRecommendationsFromUserIdAction,
    mockGetFriendshipStatus = "GET_FRIENDSHIP_STATUS",
    mockGetFriendshipStatusAction = mockGetFriendshipStatusAction,
    mockGetFriendshipStatuses = "GET_FRIENDSHIP_STATUSES",
    mockGetFriendshipStatusesAction = mockGetFriendshipStatusesAction,
    mockGetUserExtendedFriendshipStatus = "GET_EXTENDED_FRIENDSHIP_STATUS",
    mockGetUserExtendedFriendshipStatusAction = mockGetUserExtendedFriendshipStatusAction,
    mockGetFollowingExists = "GET_FOLLOWING_EXISTS",
    mockGetFollowingExistsAction = Rodux.makeActionCreator("GET_FOLLOWING_EXISTS", function(_, _)
        return {
            responseBody = {
                followings = {
                    { userId = 123, isFollowing = true, isFollowed = true },
                    { userId = 355, isFollowing = false, isFollowed = true }
                }
            }
        }
    end),
    mockBlockUserById = "BLOCK_USER_BY_ID",
    mockBlockUserByIdAction = mockBlockUserByIdAction,
    friendsNetworkingMock = {
        GetFriendshipStatus = {
            Succeeded = { name = "GET_FRIENDSHIP_STATUS" }
        },
        GetFriendshipStatuses = {
            Succeeded = { name = "GET_FRIENDSHIP_STATUSES" }
        },
        GetFriendsFromUserId = {
            Succeeded = { name = "GET_FRIENDS_SUCCEEDED_ACTION" }
        },
        GetFriendsCountFromUserId = {
            Succeeded = { name = "GET_FRIENDS_COUNT_SUCCEEDED_ACTION" }
        },
        UnfriendTargetUserId = {
            Succeeded = { name = "UNFRIEND_TARGET_USER_ID" }
        },
        GetFriendRequestsCount = {
            Succeeded = { name = "GET_REQUEST_COUNT" }
        },
        GetNewFriendRequestsCount = {
            Succeeded = { name = "GET_NEW_FRIEND_REQUEST_COUNT" }
        },
        ClearNewFriendRequests = {
            Succeeded = { name = "CLEAR_NEW_FRIEND_REQUEST_COUNT" }
        },
        AcceptFriendRequestFromUserId = {
            Succeeded = { name = "ACCEPT_REQUEST_FROM_USER_ID" }
        },
        DeclineFriendRequestFromUserId = {
            Succeeded = { name = "DECLINE_REQUEST_FROM_USER_ID" }
        },
        GetFriendRequests = {
            Succeeded = { name = "GET_FRIEND_REQUESTS" }
        },
        DeclineAllFriendRequests = {
            Succeeded = { name = "DECLINE_ALL_FRIEND_REQUESTS" }
        },
        GetFriendRecommendationsFromUserId = {
            Succeeded = { name = "GET_FRIEND_RECOMMENDATIONS_FROM_USER_ID" }
        },
        RequestFriendshipFromUserId = {
            Succeeded = { name = "REQUEST_FRIENDSHIP_FROM_USER_ID" }
        },
        RequestFriendshipFromContactId = {
            Succeeded = { name = "REQUEST_FRIENDSHIP_FROM_CONTACT_ID" }
        },
        GetExtendedFriendshipStatus = {
            Succeeded = { name = "GET_EXTENDED_FRIENDSHIP_STATUS" }
        },
        GetFollowingExists = {
            Succeeded = { name = "GET_FOLLOWING_EXISTS" }
        }
    },
    networkingBlockingMock = {
        BlockUserById = {
            Succeeded = { name = "BLOCK_USER_BY_ID" }
        }
    },
    userBlockingNetworkingMock = {
        BlockUserById = {
            Succeeded = { name = "BLOCK_USER_BY_ID" }
        }
    }
}
