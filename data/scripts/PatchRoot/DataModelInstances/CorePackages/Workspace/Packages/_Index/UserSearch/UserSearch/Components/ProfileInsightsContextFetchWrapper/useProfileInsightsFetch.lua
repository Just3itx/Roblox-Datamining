-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T03:01:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserSearch = script:FindFirstAncestor("UserSearch")
local UserSearchParent = UserSearch.Parent

local useQuery = require(UserSearchParent.ApolloClient).useQuery

local ProfilesInsightsQuery = require(UserSearch.Apollo.ProfilesInsightsQuery)

local FFlagPlayerSearchEnableOnlineFrequents = require(UserSearchParent.SharedFlags).FFlagPlayerSearchEnableOnlineFrequents

return function(userIds, str1: string, rankingStrategy: string?)
    local pageId = ProfilesInsightsQuery.createPageId(str1)

    local var1 = useQuery
    local query = ProfilesInsightsQuery.query
    local tbl1 = {
        errorPolicy = "all",
        skip = not userIds or #userIds == 0,
        variables = 0
    }
    local variables = { userIds = userIds, pageId = pageId, rankingStrategy = 0 }
    if not FFlagPlayerSearchEnableOnlineFrequents then
        rankingStrategy = nil
    end

    variables.rankingStrategy = rankingStrategy
    tbl1.variables = variables
    return (var1(query, tbl1))
end
