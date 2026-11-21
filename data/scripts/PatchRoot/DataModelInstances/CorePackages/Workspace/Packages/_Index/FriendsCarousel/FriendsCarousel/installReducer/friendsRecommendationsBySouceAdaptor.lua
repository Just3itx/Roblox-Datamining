-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T14:11:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FriendsCarousel = script:FindFirstAncestor("FriendsCarousel")
local dependencies = require(FriendsCarousel.dependencies)

local NetworkingFriends = dependencies.NetworkingFriends
local RoduxFriends = dependencies.RoduxFriends
local llama = dependencies.llama
local RecommendationSourceEnum = dependencies.SocialCommon.Enums.RecommendationSourceEnum

return function()
    local module = {}
    module[NetworkingFriends.GetFriendRecommendationsFromUserId.Succeeded.name] = function(arg1)
        local data = arg1.responseBody.data or {}

        local recommendationIds = llama.List.map(data, function(arg2)
            return arg2.id
        end)

        return { arg1, (RoduxFriends.Actions.RecommendationSourceCreated(
                {
                    source = RecommendationSourceEnum.HomepageFriendsCarousel,
                    recommendationIds = recommendationIds
                }
            )) }
    end

    return module
end
