-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T03:01:31Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserSearch = script:FindFirstAncestor("UserSearch")
local UserSearchParent = UserSearch.Parent

local useLocalization = require(UserSearchParent.Localization).Hooks.useLocalization

local useRelationshipSelector = require(script.Parent.useRelationshipSelector)
local _LocalTypes = require(UserSearch.Common.LocalTypes)
local _GraphQLServer = require(UserSearchParent.GraphQLServer)

local Images = require(UserSearchParent.UIBlox).App.ImageSet.Images

local SocialCommon = require(UserSearchParent.SocialCommon)
local useMutualFriendsText = SocialCommon.Hooks.useMutualFriendsText
local ContextualInfoTypes = SocialCommon.Enums.ContextualInfoTypes

local PresenceType = require(UserSearch.Rodux.RoduxPresence).Enums.PresenceType
local FFlagUserSearchPresenceStoreMigration = require(UserSearch.Flags.FFlagUserSearchPresenceStoreMigration)
local PresenceType2 = if FFlagUserSearchPresenceStoreMigration then require(UserSearchParent.DataHydration).Presence.PresenceEnums.PresenceType else nil
local FFlagUserSearchUsePreviousUsernameMatch = require(UserSearchParent.SharedFlags).FFlagUserSearchUsePreviousUsernameMatch
local FFlagUserSearchUseThisIsYou = require(UserSearchParent.SharedFlags).FFlagUserSearchUseThisIsYou
local FFlagUserSearchClassmatesInsight = require(UserSearchParent.SharedFlags).FFlagUserSearchClassmatesInsight

local iconsStatusPlayerFriend = Images["icons/status/player/friend"]
local iconsStatusPlayerFollowing = Images["icons/status/player/following"]

local function func1(previousUsernames, searchKeyword: string)
    if not previousUsernames or #previousUsernames == 0 then
        return false
    end
    for i = 1, #previousUsernames do
        if string.lower(previousUsernames[i]) == string.lower(searchKeyword) then
            return previousUsernames[i]
        end
    end
    return false
end

return function(tbl1)
    local var1 = useRelationshipSelector(tbl1.userId)

    local shouldUseCompactTiles = tbl1.shouldUseCompactTiles
    local shouldUseCompactTiles2 = tbl1.shouldUseCompactTiles

    local var2 = useLocalization({
        youAreFriends = if shouldUseCompactTiles then nil else "Feature.PlayerSearchResults.Label.YouAreFriends",
        youAreFollowing = if shouldUseCompactTiles then nil else "Feature.PlayerSearchResults.Label.YouAreFollowing",
        thisIsYou = if FFlagUserSearchUseThisIsYou then "Feature.PlayerSearchResults.Label.ThisIsYou" elseif shouldUseCompactTiles then nil else "Feature.PlayerSearchResults.Label.ThisIsYou",
        friend = if shouldUseCompactTiles then "Feature.Friends.Label.Friend" else nil,
        following = if shouldUseCompactTiles then "Feature.Friends.Label.Following" else nil,
        you = if shouldUseCompactTiles then "Feature.PlayerSearchResults.Label.You" else nil,
        newUsername = "Feature.PlayerSearchResults.Label.NewUsername",
        frequents = "Feature.Friends.Label.Frequent",
        classmates = if FFlagUserSearchClassmatesInsight then "Feature.Schools.Label.Classmates" else nil
    })

    local profileInsight = tbl1.profileInsight
    local mutualFriendsLen = profileInsight and profileInsight.mutualFriends and #profileInsight.mutualFriends or 0
    local text = useMutualFriendsText(mutualFriendsLen)

    if var1.isMyself then
        return {
            text = if FFlagUserSearchUseThisIsYou then var2.thisIsYou elseif shouldUseCompactTiles then var2.you else var2.thisIsYou
        }, ContextualInfoTypes.IsMyself
    elseif if FFlagUserSearchUsePreviousUsernameMatch then tbl1.isPreviousUsernameMatch else func1(tbl1.previousUsernames, tbl1.searchKeyword) then
        return {
            text = var2.newUsername
        }, ContextualInfoTypes.PreviousUsername
    elseif var1.status == Enum.FriendStatus.Friend then
        if tbl1.shouldUseCompactTiles then
            local var4 = if FFlagUserSearchPresenceStoreMigration then tbl1.userPresence and tbl1.userPresence.userPresenceType == PresenceType2.InGame else tbl1.userPresence and tbl1.userPresence.userPresenceType == PresenceType.InGame

            if var4 and tbl1.userPresence and tbl1.userPresence.lastLocation and tbl1.userPresence.universeId then
                return {
                    text = tbl1.userPresence.lastLocation
                }, ContextualInfoTypes.ExperienceLastLocation
            end
        end
        return {
            text = if shouldUseCompactTiles then var2.friend else var2.youAreFriends,
            icon = if shouldUseCompactTiles2 then nil else iconsStatusPlayerFriend
        }, ContextualInfoTypes.Friend
    elseif var1.following == true then
        return {
            text = if shouldUseCompactTiles then var2.following else var2.youAreFollowing,
            icon = if shouldUseCompactTiles2 then nil else iconsStatusPlayerFollowing
        }, ContextualInfoTypes.Following
    else
        if profileInsight then
            if mutualFriendsLen > 0 then
                return {
                    text = text,
                    icon = if shouldUseCompactTiles2 then nil else iconsStatusPlayerFriend
                }, ContextualInfoTypes.MutualFriends
            end

            if profileInsight.isOfflineFrequents then
                return {
                    text = var2.frequents
                }, ContextualInfoTypes.Frequents
            end
        end

        if FFlagUserSearchClassmatesInsight and profileInsight and profileInsight.isClassmate then
            return {
                text = var2.classmates
            }, ContextualInfoTypes.Classmates
        end

        return nil, nil
    end
end
