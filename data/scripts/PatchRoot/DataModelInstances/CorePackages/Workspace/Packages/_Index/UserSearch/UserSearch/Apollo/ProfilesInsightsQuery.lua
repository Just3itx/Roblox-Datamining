-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T03:01:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserSearchParent = script:FindFirstAncestor("UserSearch").Parent

return {
    query = require(UserSearchParent.ApolloClient).gql(require(script.Parent.ProfilesInsights)),
    createPageId = function(str1: string): string
        return "PROFILE_INSIGHTS_SEARCH_PAGE_ID" .. ":" .. str1
    end
}
