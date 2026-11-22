-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T13:30:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local dependencies = require(scriptParentParentParent.dependencies)
local scriptParentParentParentParent = scriptParentParentParent.Parent

local React = dependencies.React
local useLocalization = require(scriptParentParentParentParent.Localization).Hooks.useLocalization
local getRecommendationContextualInfoDisplay = require(scriptParentParentParentParent.SocialCommon).Utils.getRecommendationContextualInfoDisplay
local FFlagShowClassmatesOnPYMK = require(scriptParentParentParentParent.SharedFlags.FFlagShowClassmatesOnPYMK)

local _UserList = require(scriptParentParentParentParent.UserList)

local function useContextualInfo(tbl1)
    local localized = useLocalization({
        singularMutualConnection = "Feature.Friends.Label.OneMutual",
        mutualConnections = {
            "Feature.Friends.Label.MultipleMutuals",
            numConnections = tbl1.recommendation.mutualFriendsCount
        },
        frequents = "Feature.Friends.Label.Frequent",
        connectionRequests = "Feature.Friends.Label.Request",
        contacts = "Feature.Friends.Description.FromContacts",
        classmates = if FFlagShowClassmatesOnPYMK then "Feature.Schools.Label.Classmates" else nil
    })
    return React.useMemo(function()
        local recommendation = {
            contextType = tbl1.recommendation.contextType,
            mutualFriendsList = tbl1.recommendation.mutualFriendsList,
            mutualFriendsCount = tbl1.recommendation.mutualFriendsCount,
            hasIncomingFriendRequest = tbl1.hasIncomingFriendRequest
        }
        return getRecommendationContextualInfoDisplay({ recommendation = recommendation, localized = localized })
    end, {
        localized,
        tbl1.recommendation.contextType,
        tbl1.recommendation.mutualFriendsList,
        tbl1.recommendation.mutualFriendsCount,
        tbl1.hasIncomingFriendRequest
    })
end

return useContextualInfo
