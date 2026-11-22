-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T10:51:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfileInsightsParent = script:FindFirstAncestor("ProfileInsights").Parent

local Array = require(ProfileInsightsParent.LuauPolyfill).Array

local ApolloProfileInsights = require(ProfileInsightsParent.ApolloProfileInsights)
local useProfileInsightsByUserIds = ApolloProfileInsights.Hooks.useProfileInsightsByUserIds
local getMutualFriendsByUserIdFromData = ApolloProfileInsights.Selectors.getMutualFriendsByUserIdFromData

local UserProfiles = require(ProfileInsightsParent.UserProfiles)

local function getUserIdsWithLimit(arg1, limit: number) -- Luacid: Inlined by compiler; 1 call site recovered
    local var1 = Array.slice(arg1, 1, limit + 1)

    return Array.map(var1, function(arg2)
        return arg2.id
    end)
end

local function getUsersNamesFromData(data, userIdsWithLimit) -- Luacid: Inlined by compiler; 1 call site recovered
    if data then
        return (Array.map(userIdsWithLimit, function(arg1)
            return UserProfiles.Selectors.getCombinedNameFromId(data, arg1)
        end))
    end

    return nil
end

local function useMutualFriendsNamesWithLimit(tbl1)
    local var1 = useProfileInsightsByUserIds({ userIds = { tbl1.userId } })

    local userIds = getUserIdsWithLimit(getMutualFriendsByUserIdFromData(var1.data, tbl1.userId), tbl1.limit)

    local var2 = UserProfiles.Hooks.useUserProfilesFetch(
        {
            userIds = userIds,
            query = UserProfiles.Queries.userProfilesCombinedNameByUserIds
        }
    )
    local loading = var1.loading or var2.loading
    return getUsersNamesFromData(var2.data, userIds), loading
end

return useMutualFriendsNamesWithLimit
