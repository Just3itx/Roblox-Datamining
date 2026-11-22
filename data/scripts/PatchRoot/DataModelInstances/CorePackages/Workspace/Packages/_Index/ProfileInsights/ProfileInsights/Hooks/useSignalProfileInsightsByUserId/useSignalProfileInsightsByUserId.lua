-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T10:51:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfileInsights = script:FindFirstAncestor("ProfileInsights")
local ProfileInsightsParent = ProfileInsights.Parent

local ProfileInsightsStore = require(ProfileInsights["data-hydration"].ProfileInsightsStore)

local SignalsReact = require(ProfileInsightsParent.SignalsReact)
local React = require(ProfileInsightsParent.React)

local FFlagAddFriendsPageTrustedFriendRequestSection = require(ProfileInsightsParent.SharedFlags).FFlagAddFriendsPageTrustedFriendRequestSection

local function useSignalProfileInsightsByUserId(tbl1)
    local var1 = React.useMemo(function()
        return ProfileInsightsStore(false).getProfileInsightsByUserId({
            userIds = { tbl1.userId },
            rankingStrategy = tbl1.rankingStrategy,
            skipFetch = if FFlagAddFriendsPageTrustedFriendRequestSection then tbl1.skipFetch else nil,
            forceFetch = tbl1.forceFetch
        })
    end, {
        tbl1.userId,
        tbl1.rankingStrategy,
        tbl1.skipFetch,
        tbl1.forceFetch
    })
    local var2 = SignalsReact.useSignalState(var1(false).data.getProfileInsights)

    return React.useMemo(function()
        for _, value in var2 do
            if value.targetUserId == tbl1.userId then
                return value
            end
        end
        return {}
    end, { var2 }), var1(false).status == "fetching"
end

return useSignalProfileInsightsByUserId
