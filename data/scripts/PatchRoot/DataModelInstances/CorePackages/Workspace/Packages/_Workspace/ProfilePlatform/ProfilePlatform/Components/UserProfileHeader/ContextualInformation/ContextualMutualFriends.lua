-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T05:21:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local ProfilePlatformParent = ProfilePlatform.Parent
local React = require(ProfilePlatformParent.React)
local Cryo = require(ProfilePlatformParent.Cryo)

local useLocalization = require(ProfilePlatformParent.Localization).Hooks.useLocalization
local TextKeys = require(ProfilePlatform.Common.TextKeys)

local UIBlox = require(ProfilePlatformParent.UIBlox)
local Images = UIBlox.App.ImageSet.Images
local PlayerContext = UIBlox.App.Indicator.PlayerContext

local UserProfiles = require(ProfilePlatformParent.UserProfiles)

local function truncateSomeNames(str1: string, tbl1): string
    if tbl1.shouldTruncateLongNames and #str1 >= 13 then
        return string.format("%s%s", string.sub(str1, 1, 12), "…")
    end
    return str1
end

local function getNamesListText(tbl1, tbl2): string
    local tbl3 = {}
    local num1 = #tbl1

    for i = 1, math.min(num1, 3) do
        table.insert(tbl3, tbl1[i])
    end

    return table.concat(Cryo.List.map(tbl3, function(arg1): string
        return truncateSomeNames(arg1, tbl2)
    end), ", ")
end

local function getOthersText(mutualFriendsCount: number, num1: number, tbl1) -- Luacid: Inlined by compiler; 2 call sites recovered
    local oneMutualFriendText = tbl1.oneMutualFriendText
    local pluralMutualFriendsText = tbl1.pluralMutualFriendsText
    local oneOtherMutualFriendText = tbl1.oneOtherMutualFriendText
    local pluralOtherMutualFriendsText = tbl1.pluralOtherMutualFriendsText

    if mutualFriendsCount == 1 then
        return oneMutualFriendText
    end

    if mutualFriendsCount <= 3 then
        return pluralMutualFriendsText
    end

    local num2 = mutualFriendsCount - num1
    if num2 == 1 then
        pluralOtherMutualFriendsText = oneOtherMutualFriendText
    end
    return `+ {num2} {pluralOtherMutualFriendsText}`
end

local function getText(mutualFriendsCount: number, tbl1, tbl2, arg1): string -- Luacid: Inlined by compiler; 1 call site recovered
    local namesListText = getNamesListText(tbl1, tbl2)
    local num1 = #tbl1
    return `{namesListText} {getOthersText(mutualFriendsCount, math.min(num1, 3), arg1)}`
end

local function contextualPresence(tbl1)
    local var1 = useLocalization({
        oneMutualFriendText = TextKeys.OneMutualFriend,
        pluralMutualFriendsText = TextKeys.PluralMutualFriends,
        oneOtherMutualFriendText = TextKeys.OneOtherMutualFriend,
        pluralOtherMutualFriendsText = TextKeys.PluralOtherMutualFriends
    })

    local mutualFriendsCount = tbl1.mutualFriendsCount

    local userIds = Cryo.List.map(tbl1.mutualFriends, function(arg1): string
        return tostring(arg1)
    end)

    local var3 = UserProfiles.Hooks.useUserProfilesFetch(
        {
            userIds = userIds,
            query = UserProfiles.Queries.userProfilesCombinedNameByUserIds
        }
    )
    local tbl2 = ({})
    local str1 = ""
    local mutualFriendsLen = #tbl1.mutualFriends

    if var3.data then
        for i, value in ipairs(userIds) do
            local combinedNameFromId = UserProfiles.Selectors.getCombinedNameFromId(var3.data, value)
            str1 ..= combinedNameFromId
            if i ~= mutualFriendsLen then
                str1 ..= ", "
            end
            tbl2[i] = combinedNameFromId
        end
    end
    local text = getText(mutualFriendsCount, tbl2, { shouldTruncateLongNames = mutualFriendsCount > 1 }, var1)

    return React.createElement(PlayerContext, { icon = Images["icons/status/player/friend"], text = text, textHeight = 30 })
end

return contextualPresence
