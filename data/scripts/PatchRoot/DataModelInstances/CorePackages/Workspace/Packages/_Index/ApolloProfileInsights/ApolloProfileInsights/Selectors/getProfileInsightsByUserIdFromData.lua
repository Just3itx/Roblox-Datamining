-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T22:31:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ApolloProfileInsightsParent = script:FindFirstAncestor("ApolloProfileInsights").Parent
local Cryo = require(ApolloProfileInsightsParent.Cryo)

local _GraphQLServer = require(ApolloProfileInsightsParent.GraphQLServer)

return function(tbl1, arg1)
    if not (tbl1 and tbl1.profilesInsightsByUserIds) then
        return nil
    end

    local profilesInsightsByUserIds = tbl1.profilesInsightsByUserIds

    return profilesInsightsByUserIds[Cryo.List.findWhere(profilesInsightsByUserIds, function(arg2, _): boolean
        return arg2.targetUserId == tostring(arg1)
    end)]
end
