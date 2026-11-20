-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T22:01:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ApolloFriendsParent = script:FindFirstAncestor("ApolloFriends").Parent

local gql = require(ApolloFriendsParent.ApolloClient).gql

local function createFriendInCache(arg1, tbl1)
    return (arg1.cache:writeFragment({
        data = {
            __typename = "Friend",
            id = tbl1.userId,
            targetUserId = tbl1.targetUserId,
            hasVerifiedBadge = tbl1.hasVerifiedBadge or false,
            displayName = ""
        },
        fragment = gql(
            "\t\t\tfragment NewFriend on Friend {\n\t\t\t\tid\n\t\t\t\ttargetUserId\n\t\t\t\thasVerifiedBadge\n\t\t\t\tdisplayName\n\t\t\t}\n\t\t"
        )
    }))
end

return createFriendInCache
