-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T15:21:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialCommon = script:FindFirstAncestor("SocialCommon")
local SocialCommonParent = SocialCommon.Parent

local getMutualFriendsText = require(SocialCommon.Utils.getMutualFriendsText)
local RecommendationContextType = require(SocialCommon.Enums.RecommendationContextType)
local FFlagShowClassmatesOnPYMK = require(SocialCommonParent.SharedFlags.FFlagShowClassmatesOnPYMK)

local Images = require(SocialCommonParent.UIBlox).App.ImageSet.Images

return function(tbl1)
    local var1 = tbl1.recommendation.contextType and tbl1.recommendation.contextType.rawValue()
    local mutualFriendsCount = tbl1.recommendation.mutualFriendsCount or 0
    local var2, iconsStatusPlayerFriend

    if tbl1.recommendation.hasIncomingFriendRequest then
        var2 = tbl1.localized.connectionRequests
        iconsStatusPlayerFriend = nil
    else
        var2 = nil
        iconsStatusPlayerFriend = nil
    end

    if var1 == RecommendationContextType.Contacts.rawValue() then
        var2 = tbl1.localized.contacts
    elseif var1 == RecommendationContextType.MutualFriends.rawValue() and mutualFriendsCount > 0 then
        var2 = getMutualFriendsText({
            mutualFriendsCount = mutualFriendsCount,
            localized = {
                mutualConnections = tbl1.localized.mutualConnections,
                singularMutualConnection = tbl1.localized.singularMutualConnection
            }
        })
        iconsStatusPlayerFriend = Images["icons/status/player/friend"]
    elseif var1 == RecommendationContextType.Frequents.rawValue() then
        var2 = tbl1.localized.frequents
    elseif FFlagShowClassmatesOnPYMK and var1 == RecommendationContextType.Classmates.rawValue() then
        var2 = tbl1.localized.classmates
    end

    return { text = var2, icon = iconsStatusPlayerFriend }
end
