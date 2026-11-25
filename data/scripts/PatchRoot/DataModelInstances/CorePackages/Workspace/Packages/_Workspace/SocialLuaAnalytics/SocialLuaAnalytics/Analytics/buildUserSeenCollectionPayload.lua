-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T16:01:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialLuaAnalyticsParent = script:FindFirstAncestor("SocialLuaAnalytics").Parent

local FFlagLuaAppUserSeenCollectionUnifiedFields = require(SocialLuaAnalyticsParent.SharedFlags).FFlagLuaAppUserSeenCollectionUnifiedFields

local function buildUserSeenCollectionPayload(tbl1, sessionEventCount: number)
    local tbl2 = {}
    local tbl3 = {}
    local tbl4 = {}
    local tbl5 = {}
    local tbl6 = {}
    local tbl7 = {}
    local tbl8 = {}
    local tbl9 = {}

    for _, value in tbl1 do
        table.insert(tbl2, tostring(value.userId))
        table.insert(tbl3, tostring(value.index))
        table.insert(tbl4, tostring(value.presence))
        table.insert(tbl5, tostring(value.recommendationRank))
        table.insert(tbl6, tostring(value.friendStatus))
        table.insert(tbl7, tostring(value.recommendationContextType))
        table.insert(tbl8, tostring(value.isRecommendation))
        table.insert(tbl9, tostring(value.universeId))
    end

    return {
        userIds = table.concat(tbl2, ","),
        absolutePositions = table.concat(tbl3, ","),
        presences = table.concat(tbl4, ","),
        recommendationRanks = table.concat(tbl5, ","),
        friendStatuses = table.concat(tbl6, ","),
        recommendationContextTypes = table.concat(tbl7, ","),
        isRecommendations = table.concat(tbl8, ","),
        universeIds = table.concat(tbl9, ","),
        tileCount = #tbl2,
        sessionEventCount = sessionEventCount,
        contentType = if FFlagLuaAppUserSeenCollectionUnifiedFields then "User" else nil
    }
end

return buildUserSeenCollectionPayload
