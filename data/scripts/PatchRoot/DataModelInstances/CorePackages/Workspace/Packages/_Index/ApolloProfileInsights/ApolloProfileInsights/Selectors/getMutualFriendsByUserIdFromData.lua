-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T22:31:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ApolloProfileInsightsParent = script:FindFirstAncestor("ApolloProfileInsights").Parent

local getProfileInsightsByUserIdFromData = require(script.Parent.getProfileInsightsByUserIdFromData)

local _GraphQLServer = require(ApolloProfileInsightsParent.GraphQLServer)

return function(arg1, arg2)
    local profileInsightsByUserIdFromData = getProfileInsightsByUserIdFromData(arg1, arg2)
    local mutualFriends

    if profileInsightsByUserIdFromData then
        mutualFriends = profileInsightsByUserIdFromData.mutualFriends

        if not mutualFriends then
            return {}
        end
    else
        mutualFriends = {}
    end

    return mutualFriends
end
