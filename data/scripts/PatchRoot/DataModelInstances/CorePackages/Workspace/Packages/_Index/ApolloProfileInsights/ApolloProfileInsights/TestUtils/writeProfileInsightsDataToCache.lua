-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T22:31:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ApolloProfileInsightsParent = script:FindFirstAncestor("ApolloProfileInsights").Parent

local Cryo = require(ApolloProfileInsightsParent.Cryo)

local ApolloLocalState = require(ApolloProfileInsightsParent.ApolloLocalState)
local _ApolloClient = require(ApolloProfileInsightsParent.ApolloClient)
local queries = ApolloLocalState.queries

return function(arg1, tbl1, tbl2)
    local query = if tbl2 and tbl2.query then tbl2.query else queries.profilesInsightsByUserIds

    for userIds, value2 in tbl1 do
        local mutualFriends = {}

        for value3, value4 in value2.mutualFriends or {} do
            table.insert(
                mutualFriends,
                Cryo.Dictionary.join({
                    __typename = "MutualFriend",
                    id = value4.id or tostring(value3),
                    username = value4.username or "",
                    displayName = value4.displayName or ""
                }, value4)
            )
        end

        local tbl4 = {
            variables = { userIds = userIds },
            query = query,
            data = 0
        }
        local tbl5 = {
            profilesInsightsByUserIds = {{
                __typename = "ProfileInsights",
                targetUserId = value2.targetUserId or tostring(userIds),
                isOfflineFrequents = value2.isOfflineFrequents or false,
                mutualFriends = mutualFriends,
                friendshipAgeUnixSeconds = value2.friendshipAgeUnixSeconds or 0,
                friendRequestOriginSource = value2.friendRequestOriginSource or 0,
                accountCreationDateUnixSeconds = value2.accountCreationDateUnixSeconds or 0,
                localizedCountryName = value2.localizedCountryName or "",
                userAgeVerifiedBracket = value2.userAgeVerifiedBracket or ""
            }}
        }
        tbl4.data = tbl5
        arg1:writeQuery(tbl4)
    end
end
