-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T17:21:28Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameCollectionsParent = script:FindFirstAncestor("GameCollections").Parent
local React = require(GameCollectionsParent.React)
local useRoactService = require(GameCollectionsParent.RobloxAppHooks).useRoactService
local AppPage = require(GameCollectionsParent.RobloxAppEnums).AppPage
local RoactAnalyticsCommonGameEvents = require(GameCollectionsParent.RoactServiceTags).RoactAnalyticsCommonGameEvents
local AppEventIngestService = require(GameCollectionsParent.RoactServiceTags).AppEventIngestService
local gamePlayIntent = require(GameCollectionsParent.DiscoveryAnalytics).Events.gamePlayIntent
local reportGameAttributionError = require(GameCollectionsParent.DiscoveryAnalytics).Events.reportGameAttributionError
local mutedError = require(GameCollectionsParent.Loggers).mutedError
local useStore = require(GameCollectionsParent.RoactUtils).Hooks.RoactRodux.useStore
local GameCollectionItemTypes = require(GameCollectionsParent.DiscoveryTypes).GameCollectionItemTypes
local GameSortLoadSource = require(GameCollectionsParent.DiscoveryAvailability).GameSortLoadSource
local feedScroll = require(GameCollectionsParent.ScrollTelemetry).feedScroll
local calculateRowPositionFields = require(GameCollectionsParent.UnifiedLogging).calculateRowPositionFields
local Cryo = require(GameCollectionsParent.Cryo)

local FFlagLuaAppLogGameAttributionError = require(GameCollectionsParent.SharedFlags).FFlagLuaAppLogGameAttributionError
local FFlagLuaAppGameDetailsAttributionFix = require(GameCollectionsParent.SharedFlags).FFlagLuaAppGameDetailsAttributionFix
local FFlagLuaAppDemoModePlayButtonTelemetry = require(GameCollectionsParent.SharedFlags).FFlagLuaAppDemoModePlayButtonTelemetry

local tbl1 = {}

local function mergeAnalyticsData(tbl2, analyticsData) -- Luacid: Inlined by compiler; 2 call sites recovered
    if not (tbl2 or analyticsData) then
        return nil
    end
    local var1 = Cryo.Dictionary.join(tbl2 or tbl1, analyticsData or tbl1)
    return if next(var1) then var1 else nil
end

local var1 = FFlagLuaAppLogGameAttributionError and {
    GameDetail = "GameDetail",
    PlayIntent = "PlayIntent"
} or nil

local function getGameSetTypeId(arg1, bool1: boolean, bool2: boolean?) -- Luacid: Inlined by compiler; 1 call site recovered
    if arg1 == nil then
        return nil
    end

    if bool1 or bool2 then
        return arg1.topicId
    end

    return arg1.gameSetTypeId
end

local function getGameSetTargetId(arg1, bool1: boolean) -- Luacid: Inlined by compiler; 1 call site recovered
    return if bool1 or arg1 == nil then nil else arg1.gameSetTargetId
end

local function getAppliedFilters(arg1, bool1: boolean) -- Luacid: Inlined by compiler; 1 call site recovered
    return if bool1 or not arg1 then nil else arg1.appliedFilters
end

local function useGameSortAnalytics(arg1, bool1: boolean, num1: number, pageName: string, tbl2, tbl3, num2: number, num3: number?)
    local var2 = useStore()
    local var3 = useRoactService(RoactAnalyticsCommonGameEvents)
    local var4 = useRoactService(AppEventIngestService)

    local gameSetTypeId = getGameSetTypeId(arg1, bool1, pageName == AppPage.SearchPage)
    local gameSetTargetId = getGameSetTargetId(arg1, bool1)
    local appliedFilters = getAppliedFilters(arg1, bool1)
    local loadSource = if pageName == AppPage.Home and arg1 and arg1.topicId then GameSortLoadSource.getSortLoadSource(arg1.topicId) else nil
    local sortSubId = if arg1 then arg1.sortSubId else nil
    local analyticsData = if arg1 then arg1.analyticsData else nil

    local var5 = React.useCallback(function(sortEntryIndex: number?, clickedUniverseId: string?)
        if FFlagLuaAppGameDetailsAttributionFix then
            local var5, bool2

            if sortEntryIndex and tbl3 then
                var5 = tbl3[sortEntryIndex]
                bool2 = not var5 or var5.universeId ~= clickedUniverseId
            else
                bool2 = true
                var5 = nil
            end

            if bool2 then
                reportGameAttributionError(pageName, {
                    errorType = var1.GameDetail,
                    clickedUniverseId = clickedUniverseId,
                    universeId = if var5 then var5.universeId else nil,
                    gameSetTypeId = gameSetTypeId,
                    gameSetTargetId = gameSetTargetId,
                    sortIndex = num1,
                    sortEntryIndex = sortEntryIndex or nil
                })
            end
        end

        if sortEntryIndex == nil or tbl3 == nil then
            return
        end

        local var5 = tbl3[sortEntryIndex]
        if not var5 then
            mutedError("reportGameDetailOpened requires a valid entry")
        end

        local rowPositionFields = calculateRowPositionFields(sortEntryIndex, num2, num3)

        local var6 = mergeAnalyticsData(analyticsData, var5.analyticsData)

        var3.reportOpenGameDetailWithId(
            var5.placeIdOverride or var5.placeId,
            gameSetTypeId,
            gameSetTargetId,
            num1,
            sortEntryIndex,
            #tbl3,
            var5.isSponsored,
            var5.adId,
            var5.universeId,
            pageName,
            clickedUniverseId,
            appliedFilters,
            var5.topicContentsIndex or sortEntryIndex,
            nil,
            rowPositionFields.positionInRow,
            rowPositionFields.rowInSort,
            rowPositionFields.rowOnPage,
            nil,
            loadSource,
            var5.tileType or GameCollectionItemTypes.GameCollectionItemType.GameTile,
            sortSubId,
            var6
        )
    end, {
        var3,
        num1,
        pageName,
        gameSetTypeId,
        gameSetTargetId,
        tbl3,
        num2,
        num3,
        loadSource,
        sortSubId,
        analyticsData
    })

    local useCallback = React.useCallback
    local function func1(arg2, referralSource: string?, _: string?, str2: string, sortEntryIndex: number?, actionType: string?)
        if FFlagLuaAppLogGameAttributionError then
            local var6, bool2

            if sortEntryIndex and tbl3 then
                var6 = tbl3[sortEntryIndex]
                bool2 = not var6 or var6.universeId ~= arg2.universeId
            else
                bool2 = true
                var6 = nil
            end

            if bool2 then
                reportGameAttributionError(str2, {
                    errorType = var1.PlayIntent,
                    clickedUniverseId = arg2.universeId,
                    universeId = if var6 then var6.universeId else nil,
                    gameSetTypeId = gameSetTypeId,
                    gameSetTargetId = gameSetTargetId,
                    sortIndex = num1,
                    sortEntryIndex = sortEntryIndex or nil
                })
            end
        end

        local rowPositionFields = calculateRowPositionFields(sortEntryIndex, num2, num3)

        local var6 = mergeAnalyticsData(analyticsData, arg2.analyticsData)

        local var7 = gamePlayIntent
        local var8 = var4

        local tbl4 = {
            placeId = arg2.placeIdOverride or arg2.placeId,
            rootPlaceId = tonumber(arg2.placeId),
            universeId = arg2.universeId,
            sortIndex = tostring(num1),
            sortEntryIndex = if sortEntryIndex then tostring(sortEntryIndex) else nil,
            referralSource = referralSource,
            gameSetTypeId = gameSetTypeId,
            gameSetTargetId = gameSetTargetId,
            appliedFilters = appliedFilters,
            topicDataPosition = arg2.topicContentsIndex or sortEntryIndex,
            nativeAdData = arg2.adId,
            pageName = pageName,
            positionInRow = rowPositionFields.positionInRow,
            rowNumber = rowPositionFields.rowInSort,
            feedRowNumber = rowPositionFields.rowOnPage,
            loadSource = loadSource,
            launchData = arg2.launchDataOverride,
            sortSubId = sortSubId,
            tileType = arg2.tileType or GameCollectionItemTypes.GameCollectionItemType.GameTile,
            analyticsData = var6,
            actionType = 0
        }

        if not FFlagLuaAppDemoModePlayButtonTelemetry then
            actionType = nil
        end

        tbl4.actionType = actionType
        var7(var8, str2, tbl4)
    end

    local var6 = if FFlagLuaAppLogGameAttributionError then tbl3 else nil
    local tbl4 = {
        num1,
        var4,
        gameSetTypeId,
        gameSetTargetId,
        var6,
        pageName,
        num2,
        num3,
        loadSource,
        sortSubId,
        analyticsData
    }

    return var5, useCallback(func1, tbl4), React.useCallback(function()
        var3.reportSeeAllWithId(gameSetTypeId, gameSetTargetId, num1)
    end, {
        var3,
        gameSetTypeId,
        gameSetTargetId,
        num1
    }), (React.useCallback(function(distance: number, scrollDuration: number, startPos: number)
        if not tbl2 or tbl2.current == nil then
            return
        end

        local scrollingDirection = tbl2.current.ScrollingDirection
        local num4 = 0
        if scrollingDirection == Enum.ScrollingDirection.X then
            num4 = tbl2.current.AbsoluteSize.X
        elseif scrollingDirection == Enum.ScrollingDirection.Y then
            num4 = tbl2.current.AbsoluteSize.Y
        else
            mutedError(`Direction {scrollingDirection.Name} is an unsupported option for feedScroll event`)
        end

        local screenSize = var2:getState().ScreenSize
        local tbl5 = {
            distance = distance,
            screenSizeX = screenSize.X,
            screenSizeY = screenSize.Y,
            scrollAreaSize = num4,
            scrollDepth = if num4 > 0 then distance / num4 else nil,
            startDepth = if num4 > 0 then startPos / num4 else nil,
            startPos = startPos,
            scrollDuration = scrollDuration,
            sortPos = num1,
            gameSetTypeId = gameSetTypeId,
            gameSetTargetId = gameSetTargetId
        }
        feedScroll(var4, pageName, scrollingDirection, tbl5)
    end, {
        var4,
        num1,
        pageName,
        tbl2,
        gameSetTypeId,
        gameSetTargetId,
        var2
    }))
end
return useGameSortAnalytics
