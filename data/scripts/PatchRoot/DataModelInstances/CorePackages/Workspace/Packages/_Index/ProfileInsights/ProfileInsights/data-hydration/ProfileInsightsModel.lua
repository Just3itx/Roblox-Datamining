-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T10:50:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfileInsightsParent = script:FindFirstAncestor("ProfileInsights").Parent

local Cryo = require(ProfileInsightsParent.Cryo)

local createSignal = require(ProfileInsightsParent.Signals).createSignal

local FFlagPlayerSearchEnableOnlineFrequents = require(ProfileInsightsParent.SharedFlags).FFlagPlayerSearchEnableOnlineFrequents
local FFlagProfileInsightsParseClassmates = require(ProfileInsightsParent.SharedFlags).FFlagProfileInsightsParseClassmates
local FFlagProfileInsightsKeyByRankingStrategy = require(ProfileInsightsParent.SharedFlags).FFlagProfileInsightsKeyByRankingStrategy
local FFlagTrustedFriendCandidatesSection = require(ProfileInsightsParent.SharedFlags).FFlagTrustedFriendCandidatesSection

local function hasNumberValue(num1: number?): boolean -- Luacid: Inlined by compiler; 3 call sites recovered
    return not (num1 == nil) and num1 ~= -1
end

local tbl1 = {
    mutualFriendInsight = {
        field = "mutualFriends",
        hasValue = function(arg1): boolean
            return #arg1.mutualFriends > 0
        end
    },
    offlineFrequentsInsight = {
        field = "isOfflineFrequents",
        hasValue = function(arg1): boolean
            return arg1.isOfflineFrequents == true
        end
    },
    playedTogetherInsight = FFlagPlayerSearchEnableOnlineFrequents and {
        field = "isOfflineFrequents",
        hasValue = function(arg1): boolean
            return arg1.isOfflineFrequents == true
        end
    } or nil,
    friendshipAgeInsight = {
        field = "friendshipAgeUnixSeconds",
        hasValue = function(arg1): boolean
            return (hasNumberValue(arg1.friendshipAgeUnixSeconds))
        end
    },
    friendRequestOriginInsight = {
        field = "friendRequestOriginSource",
        hasValue = function(arg1)
            if FFlagTrustedFriendCandidatesSection then
                return (hasNumberValue(arg1.friendRequestOriginSource))
            end

            local friendRequestOriginSource = arg1.friendRequestOriginSource
            return not (friendRequestOriginSource == nil) and friendRequestOriginSource ~= -1
        end
    },
    accountCreationDateInsight = {
        field = "accountCreationDateUnixSeconds",
        hasValue = function(arg1): boolean
            return (hasNumberValue(arg1.accountCreationDateUnixSeconds))
        end
    },
    accountLocationInsight = {
        field = "localizedCountryName",
        hasValue = function(arg1): boolean
            local localizedCountryName = arg1.localizedCountryName
            return not (localizedCountryName == nil) and localizedCountryName ~= ""
        end
    },
    classmatesInsight = FFlagProfileInsightsParseClassmates and {
        field = "isClassmate",
        hasValue = function(arg1): boolean
            return arg1.isClassmate == true
        end
    } or nil
}

local function getRankedInsightKeys(profileInsights, tbl2)
    local rankedInsightKeys = {}
    for _, profileInsight in profileInsights do
        for value, value2 in tbl1 do
            if profileInsight[value] and value2 and table.find(rankedInsightKeys, value2.field) == nil and value2.hasValue(tbl2) then
                table.insert(rankedInsightKeys, value2.field)
            end
        end
    end
    return rankedInsightKeys
end

local function createProfileInsight(userId: string, arg1)
    local tbl2 = {
        userId = userId,
        mutualFriends = {},
        targetUserId = "",
        isOfflineFrequents = false
    }

    if not arg1 or type(arg1) ~= "table" then
        return tbl2
    end

    if arg1.targetUser then
        tbl2.targetUserId = tostring(arg1.targetUser)
    end

    for _, profileInsight in arg1.profileInsights do
        if profileInsight.mutualFriendInsight and profileInsight.mutualFriendInsight.mutualFriends then
            local mutualFriends = profileInsight.mutualFriendInsight.mutualFriends
            tbl2.mutualFriends = Cryo.List.foldLeft(Cryo.Dictionary.keys(mutualFriends), function<T>(tbl3: {T}, id): {T}
                local mutualFriend = mutualFriends[id]
                table.insert(tbl3, { id = id, username = mutualFriend.username, displayName = mutualFriend.displayName })

                return tbl3
            end, {})
        end
        if profileInsight.offlineFrequentsInsight then
            tbl2.isOfflineFrequents = profileInsight.offlineFrequentsInsight.havePlayedTogether
        end
        if FFlagPlayerSearchEnableOnlineFrequents and profileInsight.playedTogetherInsight then
            local playedTogetherInsight = profileInsight.playedTogetherInsight
            tbl2.isOfflineFrequents = tbl2.isOfflineFrequents or playedTogetherInsight.havePlayedTogether
        end

        if profileInsight.friendshipAgeInsight then
            local friendshipAgeInsight = profileInsight.friendshipAgeInsight
            tbl2.friendshipAgeUnixSeconds = friendshipAgeInsight.friendsSinceDateTime and friendshipAgeInsight.friendsSinceDateTime.seconds or -1
        end

        if profileInsight.friendRequestOriginInsight then
            tbl2.friendRequestOriginSource = profileInsight.friendRequestOriginInsight.friendRequestOriginSource or -1
        end
        if profileInsight.accountCreationDateInsight then
            local accountCreationDateInsight = profileInsight.accountCreationDateInsight
            tbl2.accountCreationDateUnixSeconds = accountCreationDateInsight.accountCreatedDateTime and accountCreationDateInsight.accountCreatedDateTime.seconds or -1
        end
        if profileInsight.accountLocationInsight then
            local accountLocationInsight = profileInsight.accountLocationInsight
            tbl2.localizedCountryName = accountLocationInsight and accountLocationInsight.localizedCountryName or ""
        end

        if FFlagProfileInsightsParseClassmates and profileInsight.classmatesInsight then
            tbl2.isClassmate = profileInsight.classmatesInsight.isClassmate == true
        end
        if not profileInsight.accountCreationDateInsight then
            continue
        end

        local accountCreationDateInsight = profileInsight.accountCreationDateInsight
        if accountCreationDateInsight and accountCreationDateInsight.namespace and accountCreationDateInsight.verifiedAgeBandLabel then
            tbl2.userAgeVerifiedBracket = `{accountCreationDateInsight.namespace}.{accountCreationDateInsight.verifiedAgeBandLabel}`
        end
    end

    if FFlagProfileInsightsKeyByRankingStrategy then
        tbl2.rankedInsightKeys = getRankedInsightKeys(arg1.profileInsights, tbl2)
    end

    return tbl2
end

return {
    createProfileInsightsSignalList = function()
        local getProfileInsights, setProfileInsights = createSignal({})
        return { getProfileInsights = getProfileInsights, setProfileInsights = setProfileInsights }
    end,
    createProfileInsightsList = function(arg1)
        local profileInsightsList = {}

        if not arg1 or type(arg1) ~= "table" then
            return profileInsightsList
        end

        for _, value in arg1 do
            table.insert(profileInsightsList, (createProfileInsight(value.targetUser, value)))
        end

        return profileInsightsList
    end,
    createProfileInsight = createProfileInsight
}
