-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T13:31:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local dependencies = require(scriptParentParentParent.dependencies)

local RoduxFriends = dependencies.RoduxFriends
local llama = dependencies.llama
local _RecommendationContextType = RoduxFriends.Enums.RecommendationContextType

local filterOutPYMKRecommendations = require(script.Parent.filterOutPYMKRecommendations)

return function(str1: string)
    return function(arg1)
        local var1 = filterOutPYMKRecommendations(RoduxFriends.Selectors.getSortedByRankRecommendations(arg1, str1))(arg1)

        return llama.List.map(var1, function(arg2, absolutePosition)
            return {
                id = arg2.id,
                absolutePosition = absolutePosition,
                recommendationRank = arg2.rank,
                recommendationContextType = arg2.contextType,
                hasIncomingFriendRequest = nil
            }
        end)
    end
end
