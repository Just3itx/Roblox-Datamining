-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T03:01:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserSearch = script:FindFirstAncestor("UserSearch")
local UserSearchParent = UserSearch.Parent

local React = require(UserSearchParent.React)
local Dash = require(UserSearchParent.Dash)
local useProfileInsightsFetch = require(script.Parent.useProfileInsightsFetch)
local useMatchSearchPagination = require(UserSearch.Utils.useMatchSearchPagination)

local ProfileInsights = require(UserSearchParent.ProfileInsights)
local SignalsReact = require(UserSearchParent.SignalsReact)

local _LocalTypes = require(UserSearch.Common.LocalTypes)
local _GraphQLServer = require(UserSearchParent.GraphQLServer)

local GetFFlagEnableProfileInsightsApolloMigration = require(UserSearchParent.SharedFlags).GetFFlagEnableProfileInsightsApolloMigration

local FFlagPlayerSearchEnableOnlineFrequents = require(UserSearchParent.SharedFlags).FFlagPlayerSearchEnableOnlineFrequents
local FFlagUserSearchClassmatesInsight = require(UserSearchParent.SharedFlags).FFlagUserSearchClassmatesInsight

local function func1(tbl1)
    return Dash.reduce(tbl1, function(arg1, arg2)
        arg1[arg2.targetUserId] = arg2
        return arg1
    end, {})
end

local function func2(searchKeyword: string): string -- Luacid: Inlined by compiler; 1 call site recovered
    return "PROFILE_INSIGHTS_SEARCH_PAGE_ID" .. ":" .. searchKeyword
end

return function(tbl1)
    local users = tbl1.users or {}
    local var2 = useMatchSearchPagination({ users = users })

    local userIds = React.useMemo(function()
        return Dash.map(var2, function(arg1)
            return arg1.id
        end)
    end, { var2 })

    local var4

    if GetFFlagEnableProfileInsightsApolloMigration() then
        local var5 = ProfileInsights.ProfileInsightsStore(false).getProfileInsightsByPage({
            pageId = func2(tbl1.searchKeyword),
            userIds = userIds,
            rankingStrategy = if FFlagPlayerSearchEnableOnlineFrequents then tbl1.rankingStrategy else nil,
            count = if FFlagUserSearchClassmatesInsight and FFlagPlayerSearchEnableOnlineFrequents then if tbl1.rankingStrategy then 3 else nil else nil
        })

        var4 = SignalsReact.useSignalState(var5(false).data.getProfileInsights)
    else
        local var5 = useProfileInsightsFetch(
            userIds,
            tbl1.searchKeyword,
            if FFlagPlayerSearchEnableOnlineFrequents then tbl1.rankingStrategy else nil
        )

        var4 = not (var5.data and var5.data.profilesInsights) and {} or var5.data.profilesInsights.profileInsights
    end

    return (React.useMemo(function()
        return func1(var4)
    end, { var4 }))
end
