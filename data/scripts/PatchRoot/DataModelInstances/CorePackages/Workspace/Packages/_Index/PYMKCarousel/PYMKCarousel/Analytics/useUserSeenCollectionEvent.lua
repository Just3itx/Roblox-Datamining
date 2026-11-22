-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T13:21:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")
local scriptParentParent = script.Parent.Parent
local Constants = require(scriptParentParent.Common.Constants)
local dependencies = require(scriptParentParent.dependencies)
local scriptParentParentParent = scriptParentParent.Parent

local React = dependencies.React
local useSelector = dependencies.Hooks.useSelector
local getDeepValue = dependencies.SocialLibraries.Dictionary.getDeepValue

local formatRecommendationContextType = dependencies.SocialLuaAnalytics.Analytics.Formatters.formatRecommendationContextType
local buildUserSeenCollectionPayload = dependencies.SocialLuaAnalytics.Analytics.buildUserSeenCollectionPayload
local repeatValue = dependencies.SocialLuaAnalytics.Analytics.Formatters.repeatValue
local DataHydration = require(scriptParentParentParent.DataHydration)
local Impressions = require(scriptParentParentParent.Impressions)
local SharedFlags = require(scriptParentParentParent.SharedFlags)

local EventNames = require(script.Parent.EventNames)
local getFriendStatus = require(script.Parent.getFriendStatus)
local useBatchedImpressions = Impressions.useBatchedImpressions

local FFlagMigrateFriendshipStatusesPYMK = require(scriptParentParent.Flags.FFlagMigrateFriendshipStatusesPYMK)
local FFlagPymkCarouselPresenceStoreMigration = require(scriptParentParent.Flags.FFlagPymkCarouselPresenceStoreMigration)
local FIntUserSeenCollectionBatchTimeMs = SharedFlags.FIntUserSeenCollectionBatchTimeMs
local FFlagLuaAppUserSeenCollectionUnifiedFields = SharedFlags.FFlagLuaAppUserSeenCollectionUnifiedFields
local FFlagLuaAppEnableSduiHomePage = SharedFlags.FFlagLuaAppEnableSduiHomePage
local FFlagPYMKCarouselStableSelectors = require(scriptParentParent.Flags.FFlagPYMKCarouselStableSelectors)
local FFlagPymkCarouselExtendProps = SharedFlags.FFlagPymkCarouselExtendProps

local var1 = table.freeze({})
local var2 = if FFlagPymkCarouselPresenceStoreMigration then DataHydration.Presence.PresenceStore.get() else nil
local var3 = if FFlagMigrateFriendshipStatusesPYMK then DataHydration.Friends.FriendsStore.get() else nil

local function getHydratedFriendshipStatus(userId: string) -- Luacid: Inlined by compiler; 1 call site recovered
    local friendshipStatus = var3.GetFriendshipStatus(userId, { skipFetch = true })
    if friendshipStatus then
        return (friendshipStatus.data(false))
    end

    return nil
end

return function(callback: (...any) -> (...any), tbl1)
    local var4 = if FFlagMigrateFriendshipStatusesPYMK then nil else useSelector(function(arg1)
        local deepValue = getDeepValue(arg1, string.format("%s.Friends.friendshipStatus", Constants.RODUX_KEY))

        if not deepValue then
            if FFlagPYMKCarouselStableSelectors then
                return var1
            end

            deepValue = {}
        end

        return deepValue
    end)

    local var5 = if FFlagLuaAppEnableSduiHomePage then nil else useSelector(function(arg1)
        local deepValue = getDeepValue(arg1, string.format("%s.Friends.recommendations.hasIncomingFriendRequest", Constants.RODUX_KEY))

        if not deepValue then
            if FFlagPYMKCarouselStableSelectors then
                return var1
            end

            deepValue = {}
        end

        return deepValue
    end)

    local var6 = if FFlagPymkCarouselPresenceStoreMigration then nil else useSelector(function(arg1)
        local deepValue = getDeepValue(arg1, "PYMKCarousel.Presence.byUserId")

        if not deepValue then
            if FFlagPYMKCarouselStableSelectors then
                return var1
            end

            deepValue = {}
        end

        return deepValue
    end)

    local useCallback = React.useCallback
    local function func1(tbl2, num1: number)
        local userSeenCollectionPayload = buildUserSeenCollectionPayload(tbl2, num1)
        callback(EventNames.UserSeenCollection, {
            userId = userSeenCollectionPayload.userIds,
            absolutePosition = userSeenCollectionPayload.absolutePositions,
            presence = userSeenCollectionPayload.presences,
            recommendationRank = userSeenCollectionPayload.recommendationRanks,
            friendStatus = userSeenCollectionPayload.friendStatuses,
            recommendationContextType = userSeenCollectionPayload.recommendationContextTypes,
            isRecommendation = userSeenCollectionPayload.isRecommendations,
            universeId = userSeenCollectionPayload.universeIds,
            tileCount = userSeenCollectionPayload.tileCount,
            sessionEventCount = userSeenCollectionPayload.sessionEventCount,
            contentType = if FFlagLuaAppUserSeenCollectionUnifiedFields then userSeenCollectionPayload.contentType else nil,
            interactionUuid = if FFlagLuaAppUserSeenCollectionUnifiedFields then HttpService:GenerateGUID(false) else nil,
            collectionId = if FFlagLuaAppUserSeenCollectionUnifiedFields and tbl1 then tbl1.collectionId else nil,
            collectionPosition = if FFlagLuaAppUserSeenCollectionUnifiedFields and tbl1 then tbl1.collectionPosition else nil,
            positionsInRow = if FFlagLuaAppUserSeenCollectionUnifiedFields then userSeenCollectionPayload.absolutePositions else nil,
            rowNumbers = if FFlagLuaAppUserSeenCollectionUnifiedFields then repeatValue(1, userSeenCollectionPayload.tileCount) else nil,
            feedRowNumbers = if FFlagLuaAppUserSeenCollectionUnifiedFields and tbl1 and tbl1.feedRowNumber then repeatValue(tbl1.feedRowNumber, userSeenCollectionPayload.tileCount) else nil,
            totalNumberOfItems = if FFlagLuaAppUserSeenCollectionUnifiedFields and tbl1 then tbl1.totalNumberOfItems else nil
        })
    end

    local collectionId = if FFlagLuaAppUserSeenCollectionUnifiedFields and tbl1 then tbl1.collectionId else nil
    local collectionPosition = if FFlagLuaAppUserSeenCollectionUnifiedFields and tbl1 then tbl1.collectionPosition else nil
    local feedRowNumber = if FFlagLuaAppUserSeenCollectionUnifiedFields and tbl1 then tbl1.feedRowNumber else nil
    local totalNumberOfItems = if FFlagLuaAppUserSeenCollectionUnifiedFields and tbl1 then tbl1.totalNumberOfItems else nil
    local onFlush = useCallback(func1, { callback, collectionId, collectionPosition, feedRowNumber, totalNumberOfItems })

    local mapItem = React.useCallback(function(userId: string, num1: number, tbl2): {friendStatus: number, index: any, isRecommendation: boolean, presence: any, recommendationContextType: number, recommendationRank: number, universeId: number, userId: string}?
        if not tbl2 or tbl2.isButtonTile or tbl2.isTooltip then
            return nil
        end

        local var8 = if FFlagPymkCarouselPresenceStoreMigration then var2.GetPresenceByUserId(tostring(userId), { skipFetch = true }).data(false) or {} else not var6 and {} or var6[userId] or {}
        local universeId = if var8.universeId == nil or tostring(var8.universeId) == "" then -1 else var8.universeId

        return {
            userId = userId,
            index = tbl2.absolutePosition or num1,
            presence = var8.userPresenceType or "Offline",
            friendStatus = getFriendStatus(
                if FFlagMigrateFriendshipStatusesPYMK then getHydratedFriendshipStatus(userId) else var4[userId],
                if FFlagPymkCarouselExtendProps then if FFlagLuaAppEnableSduiHomePage or tbl2.hasIncomingFriendRequest ~= nil then tbl2.hasIncomingFriendRequest else var5[userId] elseif FFlagLuaAppEnableSduiHomePage then tbl2.hasIncomingFriendRequest else var5[userId]
            ),
            recommendationContextType = if tbl2.recommendationContextType then formatRecommendationContextType(tbl2.recommendationContextType) else "None",
            recommendationRank = tbl2.recommendationRank or -1,
            isRecommendation = true,
            universeId = universeId
        }
    end, { if FFlagMigrateFriendshipStatusesPYMK then nil else var4, var5, if FFlagPymkCarouselPresenceStoreMigration then nil else var6 })

    local var9 = useBatchedImpressions({ batchTimeMs = FIntUserSeenCollectionBatchTimeMs, mapItem = mapItem, onFlush = onFlush })

    return React.useMemo(function()
        return {
            addTileToCollection = var9.addImpression
        }
    end, { var9.addImpression })
end
