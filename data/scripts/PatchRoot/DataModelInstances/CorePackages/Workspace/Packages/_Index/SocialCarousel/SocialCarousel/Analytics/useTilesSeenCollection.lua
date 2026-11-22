-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T17:51:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialCarousel = script:FindFirstAncestor("SocialCarousel")
local SocialCarouselParent = SocialCarousel.Parent
local React = require(SocialCarouselParent.React)
local Impressions = require(SocialCarouselParent.Impressions)
local SharedFlags = require(SocialCarouselParent.SharedFlags)
local SocialLuaAnalytics = require(SocialCarouselParent.SocialLuaAnalytics)

local getFriendStatusFromTileType = require(SocialCarousel.Analytics.getFriendStatusFromTileType)
local useSocialCarouselAnalytics = require(SocialCarousel.Analytics.useSocialCarouselAnalytics)
local Tile = require(SocialCarousel.Common.Enums).Tile
local buildUserSeenCollectionPayload = SocialLuaAnalytics.Analytics.buildUserSeenCollectionPayload
local useBatchedImpressions = Impressions.useBatchedImpressions
local FIntUserSeenCollectionBatchTimeMs = SharedFlags.FIntUserSeenCollectionBatchTimeMs
local FFlagLuaAppPYMKSendUserSeenCollection = SharedFlags.FFlagLuaAppPYMKSendUserSeenCollection
local FFlagLuaAppUserSeenCollectionUnifiedFields = SharedFlags.FFlagLuaAppUserSeenCollectionUnifiedFields
local FFlagShowRequestsInCarouselForAllUsers = SharedFlags.FFlagShowRequestsInCarouselForAllUsers

local function useTilesSeenCollection()
    local var1 = useSocialCarouselAnalytics()

    if FFlagLuaAppPYMKSendUserSeenCollection then
        local mapItem = React.useCallback(function(userId: string, index: number, tbl1)
            return {
                userId = userId,
                index = index,
                presence = if tbl1 and tbl1.presence then tbl1.presence.userPresenceType else "Offline",
                friendStatus = getFriendStatusFromTileType(tbl1 and tbl1.tileType).Name,
                recommendationContextType = if tbl1 and tbl1.recommendationContextType then tbl1.recommendationContextType else "None",
                recommendationRank = if tbl1 and tbl1.recommendationRank then tbl1.recommendationRank else -1,
                isRecommendation = tbl1 and tbl1.tileType == Tile.Recommendation,
                universeId = if not tbl1 or not tbl1.presence or not tbl1.presence.universeId or tbl1.presence.universeId == "" then -1 else tbl1.presence.universeId
            }
        end, {})

        local tilesSeenCollection = var1.tilesSeenCollection
        local var3 = React.useCallback(function(tbl1, num1: number)
            if not tilesSeenCollection then
                return
            end

            tilesSeenCollection(buildUserSeenCollectionPayload(tbl1, num1))
        end, { tilesSeenCollection })

        local var4 = useBatchedImpressions
        local tbl1 = {
            batchTimeMs = FIntUserSeenCollectionBatchTimeMs,
            mapItem = mapItem,
            onFlush = 0
        }

        if not tilesSeenCollection then
            var3 = nil
        end

        tbl1.onFlush = var3
        local var5 = var4(tbl1)

        local addTileToCollection = React.useCallback(function(str1: string, num1: number, tbl2)
            if FFlagShowRequestsInCarouselForAllUsers and tbl2 and tbl2.tileType == Tile.FriendRequest and not tbl2.presence then
                return
            end
            var5.addImpression(str1, num1, tbl2)
        end, { var5.addImpression })

        return React.useMemo(function()
            return { addTileToCollection = addTileToCollection }
        end, { addTileToCollection })
    end

    local var2 = React.useRef({})
    local var3 = React.useRef(nil)
    local var4 = React.useRef({})
    local var5 = React.useRef({})
    local var6 = React.useRef(0)

    local var7 = React.useCallback(function()
        local current = var2.current

        if #current == 0 then
            return
        end

        local tbl1 = {}
        local tbl2 = {}
        local tbl3 = {}
        local tbl4 = {}
        local tbl5 = {}
        local tbl6 = {}
        local tbl7 = {}
        local tbl8 = {}

        for _, value in current do
            if not (value and value.userId and value.index) then
                continue
            end

            var4.current[value.userId] = true

            table.insert(tbl1, tostring(value.userId))
            table.insert(tbl2, tostring(value.index))
            table.insert(tbl5, value.friendStatus)
            table.insert(tbl7, tostring(value.isRecommendation))
            table.insert(tbl3, tostring(value.presence))
            table.insert(tbl8, tostring(value.universeId))
            table.insert(tbl6, tostring(value.recommendationContextType))
            table.insert(tbl4, tostring(value.recommendationRank))
        end

        if var1.tilesSeenCollection then
            var6.current += 1
            local var7 = not FFlagLuaAppUserSeenCollectionUnifiedFields
                and {
                    userIds = table.concat(tbl1, ","),
                    absolutePositions = table.concat(tbl2, ","),
                    presences = table.concat(tbl3, ","),
                    recommendationRanks = table.concat(tbl4, ","),
                    friendStatuses = table.concat(tbl5, ","),
                    recommendationContextTypes = table.concat(tbl6, ","),
                    isRecommendations = table.concat(tbl7, ","),
                    universeIds = table.concat(tbl8, ","),
                    tileCount = #tbl1,
                    sessionEventCount = var6.current
                }
                or buildUserSeenCollectionPayload(current, var6.current)

            var1.tilesSeenCollection(var7)
        end

        var2.current = {}
        var5.current = {}
    end, { var1 })

    local addTileToCollection = React.useCallback(function(userId: string, index: number, tbl1)
        if not userId
            or not index
            or var4.current[userId]
            or var5.current[userId]
            or FFlagShowRequestsInCarouselForAllUsers and tbl1 and tbl1.tileType == Tile.FriendRequest and not tbl1.presence
        then
            return
        end

        var5.current[userId] = true
        table.insert(var2.current, {
            userId = userId,
            index = index,
            presence = if tbl1 and tbl1.presence then tbl1.presence.userPresenceType else "Offline",
            friendStatus = getFriendStatusFromTileType(tbl1 and tbl1.tileType).Name,
            recommendationContextType = if tbl1 and tbl1.recommendationContextType then tbl1.recommendationContextType else "None",
            recommendationRank = if tbl1 and tbl1.recommendationRank then tbl1.recommendationRank else -1,
            isRecommendation = tbl1 and tbl1.tileType == Tile.Recommendation,
            universeId = if not tbl1 or not tbl1.presence or not tbl1.presence.universeId or tbl1.presence.universeId == "" then -1 else tbl1.presence.universeId
        })

        if var3.current then
            pcall(task.cancel, var3.current)
        end
        var3.current = task.delay(FIntUserSeenCollectionBatchTimeMs * 0.001, var7)
    end, { var7 })

    React.useEffect(function()
        return function()
            if var3.current then
                pcall(task.cancel, var3.current)
            end
            var3.current = nil
            var7()
        end
    end, {})

    return { addTileToCollection = addTileToCollection }
end

return useTilesSeenCollection
