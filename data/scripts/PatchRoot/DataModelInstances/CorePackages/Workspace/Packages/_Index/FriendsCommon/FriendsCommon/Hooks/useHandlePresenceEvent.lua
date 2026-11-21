-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T14:41:13Z
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

local handlePresenceEventWithScores = require(FriendsCommon.EventHandlers.handlePresenceEventWithScores)

local function useHandlePresenceEvent()
    local var1 = useLocalUserId()

    local apolloClient = useApolloClient()

    local onlineFriendsRef = useQuery(queries.onlineFriendsByUserId, {
        skip = not userIdExists(var1),
        notifyOnNetworkStatusChange = true,
        variables = {
            userId = var1,
            sort = ApolloFriends.Enums.Sort.FriendshipScore
        }
    })

    return {
        handleNewEvent = React.useCallback(function(updatedPresences, updatedSortScores, rtnMessageId)
            handlePresenceEventWithScores({
                localUserId = var1,
                apolloClient = apolloClient,
                onlineFriendsRef = onlineFriendsRef,
                updatedPresences = updatedPresences,
                updatedSortScores = updatedSortScores,
                rtnMessageId = rtnMessageId
            })
        end, { var1, apolloClient, onlineFriendsRef }),
        refetchOnlineFriends = React.useCallback(function()
            return onlineFriendsRef.refetch()
        end, { onlineFriendsRef })
    }
end

return useHandlePresenceEvent
