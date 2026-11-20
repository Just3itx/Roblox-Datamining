-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T22:01:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ApolloFriendsParent = script:FindFirstAncestor("ApolloFriends").Parent

local Cryo = require(ApolloFriendsParent.Cryo)
local utils = require(ApolloFriendsParent.ApolloLocalState).typePolicies.utils

local createFriendInCache = require(script.Parent.createFriendInCache)

local function addFriendToFriendsByUserIdCache(arg1, tbl1)
    local friendInCache = createFriendInCache(
        arg1,
        {
            userId = tbl1.userId,
            targetUserId = tbl1.targetUserId,
            hasVerifiedBadge = tbl1.hasVerifiedBadge
        }
    )
    arg1.cache:modify({
        id = arg1.cache:identify({ __typename = "AllFriendsPage" }),
        fields = {
            allFriendsByUserId = function(_, arg2, _)
                if arg2.targetUserId ~= tbl1.targetUserId then
                    return arg2
                end

                return (Cryo.Dictionary.join(arg2, { friends = utils.mergeListsWithoutDuplicates(arg2.friends, { friendInCache }, "__ref") }))
            end
        }
    })
end

return addFriendToFriendsByUserIdCache
