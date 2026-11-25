-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T13:01:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ServerDrivenUi = script:FindFirstAncestor("ServerDrivenUi")
local ServerDrivenUiParent = ServerDrivenUi.Parent

local Cryo = require(ServerDrivenUiParent.Cryo)
local GetInputModeStore = require(ServerDrivenUiParent.Responsive).GetInputModeStore

local AppPage = require(ServerDrivenUiParent.RobloxAppEnums).AppPage
local OpenGameDetails = require(ServerDrivenUiParent.GameDetail).OpenGameDetails
local IntervalPerformanceTracker = require(ServerDrivenUiParent.IntervalPerformanceTracker).IntervalPerformanceTracker
local sponsoredGamesRecordClick = require(ServerDrivenUiParent.DiscoveryAnalytics).Requests.sponsoredGamesRecordClick
local calculateRowPositionFields = require(ServerDrivenUiParent.UnifiedLogging).calculateRowPositionFields

local SduiCoreSystem = require(ServerDrivenUiParent.SduiCoreSystem)
local findAnalyticsFieldInAncestors = SduiCoreSystem.findAnalyticsFieldInAncestors
local SduiParsers = SduiCoreSystem.SduiParsers
local SduiErrors = SduiCoreSystem.SduiErrors
local filterAndStringifyAnalyticsData = require(ServerDrivenUi.Analytics.filterAndStringifyAnalyticsData)

local FFlagEnableExperienceDetailsBottomSheet = require(ServerDrivenUiParent.SharedFlags).FFlagEnableExperienceDetailsBottomSheet
local FFlagLuaAppEdpBottomSheetPeekViewEvents = require(ServerDrivenUiParent.SharedFlags).FFlagLuaAppEdpBottomSheetPeekViewEvents
local FFlagLuaAppSduiEdpEnabled = require(ServerDrivenUiParent.SharedFlags).FFlagLuaAppSduiEdpEnabled
local FFlagLuaAppSduiPassSortSubId = require(ServerDrivenUiParent.SharedFlags).FFlagLuaAppSduiPassSortSubId
local FFlagSduiFixSearchTelemetry = require(ServerDrivenUiParent.SharedFlags).FFlagSduiFixSearchTelemetry
local FFlagLuaAppSduiSponsoredTwoByOneTile = require(ServerDrivenUiParent.SharedFlags).FFlagLuaAppSduiSponsoredTwoByOneTile
local FFlagSduiForwardAnalyticsDataToGameClick = require(ServerDrivenUiParent.SharedFlags).FFlagSduiForwardAnalyticsDataToGameClick

local tbl1 = {}

return function(arg1, arg2, arg3)
    arg3.dependencies.logger.reportCounter(
        SduiErrors.SduiCounterName.OpenGameDetailsAction,
        {
            name = GetInputModeStore(false).getLastInputType(false)
        },
        true
    )
    local var1 = arg1 and arg1.actionParams or tbl1
    local analyticsFieldInAncestors = findAnalyticsFieldInAncestors("itemComponentType", arg2)
    if analyticsFieldInAncestors == "Tile" or analyticsFieldInAncestors == "GameTile" then
        IntervalPerformanceTracker:startTracking("AppGameTile_to_GameDetail", 2)
    end

    local var2 = var1.placeId or findAnalyticsFieldInAncestors("placeId", arg2)
    local var3 = var1.universeId or findAnalyticsFieldInAncestors("universeId", arg2)
    local index = findAnalyticsFieldInAncestors("itemPosition", arg2)
    local var4 = if FFlagSduiFixSearchTelemetry then findAnalyticsFieldInAncestors("topicDataPosition", arg2, index) else index
    local var5 = SduiParsers.safeParseBoolean(findAnalyticsFieldInAncestors("adFlag", arg2, false), arg3, arg2)

    local analyticsFieldInAncestors3 = findAnalyticsFieldInAncestors("nativeAdData", arg2)
    if analyticsFieldInAncestors3 == nil then
        analyticsFieldInAncestors3 = findAnalyticsFieldInAncestors("adId", arg2)
    end

    local placeIdOverride, analyticsFieldInAncestors4, var6

    if FFlagLuaAppSduiSponsoredTwoByOneTile then
        placeIdOverride = var1.placeIdOverride
        analyticsFieldInAncestors4 = findAnalyticsFieldInAncestors("tileType", arg2)

        var6 = Cryo.Dictionary.join(
            var1.experienceJoinData or tbl1,
            { nativeAdData = analyticsFieldInAncestors3, tileType = analyticsFieldInAncestors4 }
        )
    else
        placeIdOverride = nil
        var6 = nil
        analyticsFieldInAncestors4 = nil
    end

    local analyticsFieldInAncestors5 = findAnalyticsFieldInAncestors("navigationUniverseId", arg2, var3)

    local collectionPosition = nil
    local collectionId = nil
    local totalNumberOfItems = nil
    local itemsPerRow = nil
    local startRowNumber = nil
    local collectionData = if arg2.getCollectionData then arg2.getCollectionData() or nil else nil

    if collectionData then
        collectionPosition = collectionData.collectionPosition
        collectionId = collectionData.collectionId
        totalNumberOfItems = collectionData.totalNumberOfItems
        itemsPerRow = collectionData.itemsPerRow
        startRowNumber = collectionData.startRowNumber
    end

    local var7 = collectionPosition or findAnalyticsFieldInAncestors("collectionIndex", arg2)
    local var8 = collectionId or findAnalyticsFieldInAncestors("collectionId", arg2)
    local var9 = totalNumberOfItems or findAnalyticsFieldInAncestors("totalNumberOfItems", arg2)
    local analyticsFieldInAncestors6 = findAnalyticsFieldInAncestors("gameSetTargetId", arg2)
    local analyticsFieldInAncestors7 = findAnalyticsFieldInAncestors("heroUnitId", arg2)
    local num1 = tonumber(findAnalyticsFieldInAncestors("seeAllFlag", arg2)) or 0

    local dependencies = arg3.dependencies
    if var5 and analyticsFieldInAncestors3 then
        sponsoredGamesRecordClick(dependencies.networking, tostring(analyticsFieldInAncestors3))
    end

    local rowPositionFields = calculateRowPositionFields(index, itemsPerRow, startRowNumber)

    local analyticsFieldInAncestors8 = findAnalyticsFieldInAncestors("appliedFilters", arg2)
    local analyticsFieldInAncestors9 = if FFlagLuaAppSduiPassSortSubId then findAnalyticsFieldInAncestors("sortSubId", arg2) else nil
    local var10 = if FFlagSduiForwardAnalyticsDataToGameClick then filterAndStringifyAnalyticsData(
        Cryo.Dictionary.join(collectionData or tbl1, arg2.ancestorAnalyticsData or tbl1, arg2.analyticsData or tbl1)
    ) else nil

    if var1.inheritReferralSession == true then
        local analyticsFieldInAncestors10 = findAnalyticsFieldInAncestors("hostUniverseId", arg2)
        dependencies.gameAnalytics.reportOpenGameDetailFromGameDetail(
            FFlagLuaAppSduiSponsoredTwoByOneTile and placeIdOverride or var2,
            index,
            var9,
            var5,
            analyticsFieldInAncestors3,
            tostring(var3),
            arg3.appPage,
            analyticsFieldInAncestors10
        )
    else
        local reportOpenGameDetailWithId = dependencies.gameAnalytics.reportOpenGameDetailWithId
        local var11 = FFlagLuaAppSduiSponsoredTwoByOneTile and placeIdOverride or var2
        local str1 = tostring(var8)

        local str2 = tostring(var3)
        local appPage = arg3.appPage
        local str3 = tostring(analyticsFieldInAncestors5)

        local bool1 = true
        local positionInRow = rowPositionFields.positionInRow
        local rowInSort = rowPositionFields.rowInSort
        local rowOnPage = rowPositionFields.rowOnPage

        local var12 = nil
        local var13 = FFlagLuaAppSduiSponsoredTwoByOneTile and analyticsFieldInAncestors4 or nil
        local var14 = if FFlagLuaAppSduiPassSortSubId and analyticsFieldInAncestors9 then tostring(analyticsFieldInAncestors9) else nil

        if not FFlagSduiForwardAnalyticsDataToGameClick then
            var10 = nil
        end

        reportOpenGameDetailWithId(
            var11,
            str1,
            analyticsFieldInAncestors6,
            var7,
            index,
            var9,
            var5,
            analyticsFieldInAncestors3,
            str2,
            appPage,
            str3,
            analyticsFieldInAncestors8,
            var4,
            bool1,
            positionInRow,
            rowInSort,
            rowOnPage,
            analyticsFieldInAncestors7,
            var12,
            var13,
            var14,
            var10,
            num1
        )
    end

    local navigation = dependencies.getNavigation()
    dependencies.dispatch(
        OpenGameDetails(
            tostring(analyticsFieldInAncestors5),
            navigation,
            {
                index = index,
                placeIdOverride = FFlagLuaAppSduiSponsoredTwoByOneTile and placeIdOverride or nil,
                experienceJoinData = FFlagLuaAppSduiSponsoredTwoByOneTile and var6 or nil,
                mountAsFullView = if FFlagLuaAppEdpBottomSheetPeekViewEvents or not FFlagEnableExperienceDetailsBottomSheet then nil else arg3.appPage == AppPage.GameDetail
            },
            if FFlagLuaAppSduiEdpEnabled then dependencies.networking else nil
        )
    )

    arg3.dependencies.logger.reportCounter(
        SduiErrors.SduiCounterName.OpenGameDetailsActionFinish,
        {
            name = GetInputModeStore(false).getLastInputType(false)
        },
        true
    )
end
