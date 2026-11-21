-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T14:41:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FriendsCommonParent = script:FindFirstAncestor("FriendsCommon").Parent

local ApolloFriends = require(FriendsCommonParent.ApolloFriends)

local FFlagFriendSortedByPresenceSignalsImplementation = require(FriendsCommonParent.SharedFlags).FFlagFriendSortedByPresenceSignalsImplementation

local var1 = require(FriendsCommonParent.DataHydration).Friends.FriendsStore.get()

local function handleFriendshipEvent(tbl1)
    if tbl1.friendshipUpdate.removedUserId then
        if FFlagFriendSortedByPresenceSignalsImplementation then
            var1.UpdateIsFriendsWith(tbl1.friendshipUpdate.removedUserId, false)
            var1.UpdateFriendshipStatus(tbl1.friendshipUpdate.removedUserId, Enum.FriendStatus.NotFriend)
            return
        end
        ApolloFriends.Cache.removeFriendFromCache(
            tbl1.apolloClient,
            {
                targetUserId = tbl1.localUserId,
                userId = tbl1.friendshipUpdate.removedUserId
            }
        )
        return
    end

    if not tbl1.friendshipUpdate.addedUserId then
        return
    end

    if FFlagFriendSortedByPresenceSignalsImplementation then
        var1.RefetchOnlineFriends()
        var1.UpdateIsFriendsWith(tbl1.friendshipUpdate.addedUserId, true)
        var1.UpdateFriendshipStatus(tbl1.friendshipUpdate.addedUserId, Enum.FriendStatus.Friend)
        return
    end
    tbl1.onlineFriendsRef:refetch()
    ApolloFriends.Cache.addFriendToFriendsByUserIdCache(
        tbl1.apolloClient,
        {
            targetUserId = tbl1.localUserId,
            userId = tbl1.friendshipUpdate.addedUserId,
            hasVerifiedBadge = nil
        }
    )
end

return handleFriendshipEvent
