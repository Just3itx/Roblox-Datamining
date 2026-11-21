-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T17:10:40Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
return function(arg1)
    return {
        isFriendsWith = require(script.isFriendsWith)(arg1),
        getSortedByRankRecommendations = require(script.getSortedByRankRecommendations)(arg1),
        selectFriendshipStatusesByUserIds = require(script.selectFriendshipStatusesByUserIds)(arg1),
        getRecommendationIdsBySource = require(script.getRecommendationIdsBySource)(arg1),
        selectRecommendationsForUserId = require(script.selectRecommendationsForUserId)(arg1),
        getSortedByRankRecommendationIds = require(script.getSortedByRankRecommendationIds)(arg1)
    }
end
