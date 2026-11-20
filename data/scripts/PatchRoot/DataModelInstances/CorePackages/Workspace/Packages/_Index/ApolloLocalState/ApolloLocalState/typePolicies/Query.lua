-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T22:20:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ApolloLocalStateParent = script:FindFirstAncestor("ApolloLocalState").Parent

local _ApolloClient = require(ApolloLocalStateParent.ApolloClient)
local Cryo = require(ApolloLocalStateParent.Cryo)

local mergeListsWithoutDuplicates = require(script.Parent.utils.mergeListsWithoutDuplicates)

return {
    fields = {
        omniFeedItem = {},
        profilesInsightsByUserIds = {
            read = function(_, _, arg1)
                local result = {}

                for _, targetUserId in pairs(arg1.args.userIds) do
                    local var1 = arg1:toReference({ __typename = "ProfileInsights", targetUserId = targetUserId })

                    table.insert(result, var1)

                    if not arg1:canRead(var1) then
                        return nil
                    end
                end

                return result
            end
        },
        userProfiles = {
            read = function(_, _, arg1)
                local result = {}
                for _, id in arg1.args.userIds do
                    local var1 = arg1:toReference({ __typename = "UserProfile", id = id })

                    table.insert(result, var1)

                    if not arg1:canRead(var1) then
                        return nil
                    end
                end

                return result
            end
        },
        allFriendsByUserId = {
            keyArgs = { "userId", "sort" },
            merge = function(_, arg1, arg2)
                if not arg1 then
                    return arg2
                end

                if arg1.nextCursor ~= arg2.curCursor then
                    return arg1
                end

                local friends = mergeListsWithoutDuplicates(arg1 and arg1.friends, arg2 and arg2.friends, "__ref")

                return Cryo.Dictionary.join(arg2, { friends = friends })
            end
        },
        onlineFriendsByUserId = {
            keyArgs = { "userId", "sort" },
            read = function(_, arg1, arg2)
                if not arg1 then
                    return arg1
                end

                return (Cryo.List.filter(arg1, function(arg3)
                    local var1 = arg2:readField("presence", arg3)
                    local var2 = arg2:readField("userPresenceType", var1)

                    return var2 and var2 ~= "Offline"
                end))
            end
        }
    }
}
