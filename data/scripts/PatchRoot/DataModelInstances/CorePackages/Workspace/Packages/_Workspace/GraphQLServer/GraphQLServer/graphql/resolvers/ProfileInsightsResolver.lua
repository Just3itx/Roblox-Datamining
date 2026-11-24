-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T17:01:27Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GraphQLServerParent = script:FindFirstAncestor("GraphQLServer").Parent
local HttpService = game:GetService("HttpService")

local Cryo = require(GraphQLServerParent.Cryo)

local _generatedTypes = require(script.Parent.Parent.generatedTypes)

local _LuauPolyfill = require(GraphQLServerParent.LuauPolyfill)

local ProfileInsightsConnector = require(script.Parent.Parent.connectors.ProfileInsightsConnector)
local findProfileInsightsByUserIds = ProfileInsightsConnector.findProfileInsightsByUserIds
local findProfileInsightsByUserIdsFeed = ProfileInsightsConnector.findProfileInsightsByUserIdsFeed

local FFlagPlayerSearchEnableOnlineFrequents = require(GraphQLServerParent.SharedFlags).FFlagPlayerSearchEnableOnlineFrequents

local function func1(arg1, str1: string) -- Luacid: Inlined by compiler; 8 call sites recovered
    for _, profileInsight in arg1.profileInsights do
        if profileInsight[str1] then
            return profileInsight[str1]
        end
    end

    return {}
end

return {
    ProfileInsights = {
        targetUserId = function(arg1)
            return arg1.targetUser
        end,
        mutualFriends = function(arg1)
            local var1 = func1(arg1, "mutualFriendInsight")
            local var2 = not var1 and {} or var1.mutualFriends

            if not var2 then
                return {}
            end

            return Cryo.List.foldLeft(Cryo.Dictionary.keys(var2), function<T>(tbl1: {T}, id): {T}
                local var3 = var2[id]
                table.insert(tbl1, { id = id, username = var3.username, displayName = var3.displayName })

                return tbl1
            end, {})
        end,
        isOfflineFrequents = function(arg1): boolean
            local var1 = func1(arg1, "offlineFrequentsInsight")
            local var2 = if FFlagPlayerSearchEnableOnlineFrequents then func1(arg1, "playedTogetherInsight") else nil

            if FFlagPlayerSearchEnableOnlineFrequents then
                return not not (var1 and var1.havePlayedTogether or var2 and var2.havePlayedTogether)
            end

            return not not (var1 and var1.havePlayedTogether)
        end,
        friendshipAgeUnixSeconds = function(arg1)
            local var1 = func1(arg1, "friendshipAgeInsight")
            return var1.friendsSinceDateTime and var1.friendsSinceDateTime.seconds or -1
        end,
        friendRequestOriginSource = function(arg1)
            return func1(arg1, "friendRequestOriginInsight").friendRequestOriginSource or -1
        end,
        accountCreationDateUnixSeconds = function(arg1)
            local var1 = func1(arg1, "accountCreationDateInsight")
            return var1.accountCreatedDateTime and var1.accountCreatedDateTime.seconds or -1
        end,
        localizedCountryName = function(arg1)
            local var1 = func1(arg1, "accountLocationInsight")
            return var1 and var1.localizedCountryName or ""
        end,
        userAgeVerifiedBracket = function(arg1): string
            local var1 = func1(arg1, "userAgeVerifiedInsight")

            if var1 and var1.namespace and var1.verifiedAgeBandLabel then
                return `{var1.namespace}.{var1.verifiedAgeBandLabel}`
            end
            return ""
        end
    },
    ProfileInsightsPages = {
        id = function(arg1)
            if arg1.pageId then
                return arg1.pageId
            end

            return (HttpService:GenerateGUID(false))
        end,
        profileInsights = function(arg1)
            return arg1.profileInsights
        end
    },
    Query = {
        profilesInsights = function(_, arg1, arg2)
            return findProfileInsightsByUserIdsFeed(
                arg1.userIds,
                arg1.count,
                arg1.pageId,
                if FFlagPlayerSearchEnableOnlineFrequents then arg1.rankingStrategy else nil,
                arg2.fetchImpl
            )
        end,
        profilesInsightsByUserIds = function(_, arg1, arg2)
            return findProfileInsightsByUserIds(arg1.userIds, arg1.count, arg1.rankingStrategy, arg2.fetchImpl)
        end
    }
}
