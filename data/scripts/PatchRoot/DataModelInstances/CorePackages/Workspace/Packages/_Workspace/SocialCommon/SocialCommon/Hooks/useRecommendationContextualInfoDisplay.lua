-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T15:20:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialCommon = script:FindFirstAncestor("SocialCommon")
local SocialCommonParent = SocialCommon.Parent

local useLocalization = require(SocialCommonParent.Localization).Hooks.useLocalization

local getRecommendationContextualInfoDisplay = require(SocialCommon.Utils.getRecommendationContextualInfoDisplay)
local FFlagShowClassmatesOnPYMK = require(SocialCommonParent.SharedFlags.FFlagShowClassmatesOnPYMK)

return function(recommendation)
    local localized = useLocalization({
        singularMutualConnection = "Feature.Friends.Label.MutualFriendTitle",
        mutualConnections = {
            "Feature.Friends.Label.MutualFriendsTitle",
            numConnections = recommendation.mutualFriendsCount
        },
        frequents = "Feature.Friends.Label.Frequent",
        connectionRequests = "Feature.Friends.Label.FriendRequest",
        contacts = "Feature.Friends.Description.FromContacts",
        classmates = if FFlagShowClassmatesOnPYMK then "Feature.Schools.Label.Classmates" else nil
    })
    return getRecommendationContextualInfoDisplay({ recommendation = recommendation, localized = localized })
end
