-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T22:30:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ApolloProfileInsightsParent = script:FindFirstAncestor("ApolloProfileInsights").Parent

local ApolloClient = require(ApolloProfileInsightsParent.ApolloClient)
local ApolloLocalState = require(ApolloProfileInsightsParent.ApolloLocalState)

local useQuery = ApolloClient.useQuery
local queries = ApolloLocalState.queries

local function useProfileInsightsByUserIds(tbl1)
    return (useQuery(queries.profilesInsightsByUserIds, {
        errorPolicy = "all",
        skip = not tbl1.userIds or tbl1.skip,
        variables = {
            userIds = tbl1.userIds,
            rankingStrategy = tbl1.rankingStrategy
        },
        fetchPolicy = tbl1.fetchPolicy
    }))
end
return useProfileInsightsByUserIds
