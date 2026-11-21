-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T14:41:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FriendsCommon = script:FindFirstAncestor("FriendsCommon")
local FriendsCommonParent = FriendsCommon.Parent

local React = require(FriendsCommonParent.React)

local ApolloFriends = require(FriendsCommonParent.ApolloFriends)

local queries = require(FriendsCommonParent.ApolloLocalState).queries

local userIdExists = require(FriendsCommonParent.SocialCommon).Utils.userIdExists

local ApolloClient = require(FriendsCommonParent.ApolloClient)
local useQuery = ApolloClient.useQuery
local useApolloClient = ApolloClient.useApolloClient

local useLocalUserId = require(FriendsCommonParent.RobloxAppHooks).useLocalUserId

local handleFriendshipEvent = require(FriendsCommon.EventHandlers.handleFriendshipEvent)

local FFlagFriendSortedByPresenceSignalsImplementation = require(FriendsCommonParent.SharedFlags).FFlagFriendSortedByPresenceSignalsImplementation

local function useHandleFriendshipEvent()
    local var1 = useLocalUserId()
    local var2 = if FFlagFriendSortedByPresenceSignalsImplementation then nil else useApolloClient()
    local var3 = if FFlagFriendSortedByPresenceSignalsImplementation then nil else useQuery(
        queries.onlineFriendsByUserId,
        {
            skip = not userIdExists(var1),
            notifyOnNetworkStatusChange = true,
            variables = {
                userId = var1,
                sort = ApolloFriends.Enums.Sort.FriendshipScore
            }
        }
    )

    return (React.useCallback(function(friendshipUpdate)
        handleFriendshipEvent({
            localUserId = var1,
            onlineFriendsRef = if FFlagFriendSortedByPresenceSignalsImplementation then nil else var3,
            apolloClient = if FFlagFriendSortedByPresenceSignalsImplementation then nil else var2,
            friendshipUpdate = friendshipUpdate
        })
    end, { if FFlagFriendSortedByPresenceSignalsImplementation then nil else var3 }))
end

return useHandleFriendshipEvent
