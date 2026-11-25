-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T11:01:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiSharedContentParent = script:FindFirstAncestor("SduiSharedContent").Parent
local calculateRowPositionFields = require(SduiSharedContentParent.UnifiedLogging).calculateRowPositionFields

local SetGamePlaySession = require(SduiSharedContentParent.RobloxAppSessionization).SetGamePlaySession

local DiscoveryAnalytics = require(SduiSharedContentParent.DiscoveryAnalytics)
local gamePlayIntent = DiscoveryAnalytics.Events.gamePlayIntent
local sponsoredGamesRecordClick = DiscoveryAnalytics.Requests.sponsoredGamesRecordClick

local findAnalyticsFieldInAncestors = require(SduiSharedContentParent.SduiCoreSystem).findAnalyticsFieldInAncestors

local FFlagLuaAppDemoModePlayButtonTelemetry = require(SduiSharedContentParent.SharedFlags).FFlagLuaAppDemoModePlayButtonTelemetry

local function sduiReportGamePlayIntent(tbl1)
    local sduiContext = tbl1.sduiContext
    local analyticsContext = tbl1.analyticsContext
    local universeId = tbl1.universeId
    local placeId = tbl1.placeId
    local var1 = tbl1.rootPlaceId or placeId
    local appliedFilters = tbl1.appliedFilters
    local launchData = tbl1.launchData

    local eventIngest = sduiContext.dependencies.eventIngest
    local sessionService = sduiContext.dependencies.sessionService

    local collectionPosition = nil
    local collectionId = nil
    local itemsPerRow = nil
    local startRowNumber = nil
    local collectionData = if analyticsContext.getCollectionData then analyticsContext.getCollectionData() or nil else nil

    if collectionData then
        collectionPosition = collectionData.collectionPosition
        collectionId = collectionData.collectionId
        itemsPerRow = collectionData.itemsPerRow
        startRowNumber = collectionData.startRowNumber
    end
    local var2 = collectionPosition or findAnalyticsFieldInAncestors("collectionIndex", analyticsContext)
    local var3 = collectionId or findAnalyticsFieldInAncestors("collectionId", analyticsContext)
    local gameSetTargetId = findAnalyticsFieldInAncestors("gameSetTargetId", analyticsContext)

    local analyticsFieldInAncestors2 = findAnalyticsFieldInAncestors("itemPosition", analyticsContext, -1)
    local analyticsFieldInAncestors3 = findAnalyticsFieldInAncestors("topicDataPosition", analyticsContext, analyticsFieldInAncestors2)

    local heroUnitId = findAnalyticsFieldInAncestors("heroUnitId", analyticsContext)

    local analyticsFieldInAncestors5 = findAnalyticsFieldInAncestors("eventContext", analyticsContext, "ExperienceTile")
    local referralSource = findAnalyticsFieldInAncestors("referralSource", analyticsContext)

    local analyticsFieldInAncestors7 = findAnalyticsFieldInAncestors("gamePlaySessionType", analyticsContext)
    if analyticsFieldInAncestors7 then
        SetGamePlaySession(sessionService, analyticsFieldInAncestors7, true)
    end

    local analyticsFieldInAncestors8 = findAnalyticsFieldInAncestors("nativeAdData", analyticsContext)
    if analyticsFieldInAncestors8 == nil then
        analyticsFieldInAncestors8 = findAnalyticsFieldInAncestors("adId", analyticsContext)
    end
    if analyticsFieldInAncestors8 then
        sponsoredGamesRecordClick(sduiContext.dependencies.networking, tostring(analyticsFieldInAncestors8))
    end

    local var4 = (typeof(analyticsFieldInAncestors2) ~= "number"
        or typeof(itemsPerRow) ~= "number"
        or typeof(startRowNumber) ~= "number"
        or analyticsFieldInAncestors2 == -1
        or itemsPerRow == -1
        or startRowNumber == -1)
        and {}
        or calculateRowPositionFields(analyticsFieldInAncestors2, itemsPerRow, startRowNumber)

    local tileType = findAnalyticsFieldInAncestors("tileType", analyticsContext, "GameTile")

    gamePlayIntent(eventIngest, tostring(analyticsFieldInAncestors5), {
        placeId = tostring(placeId or var1),
        rootPlaceId = tonumber(var1),
        universeId = tostring(universeId),
        sortIndex = if var2 then tostring(var2) else nil,
        sortEntryIndex = if typeof(analyticsFieldInAncestors2) == "number" and analyticsFieldInAncestors2 ~= -1 then tostring(analyticsFieldInAncestors2) else nil,
        referralSource = referralSource,
        gameSetTypeId = if var3 then tostring(var3) else nil,
        gameSetTargetId = gameSetTargetId,
        appliedFilters = appliedFilters,
        topicDataPosition = typeof(analyticsFieldInAncestors3) == "number" and analyticsFieldInAncestors3 ~= -1 and analyticsFieldInAncestors3
            or nil,
        nativeAdData = analyticsFieldInAncestors8,
        pageName = sduiContext.appPage,
        positionInRow = var4.positionInRow,
        rowNumber = var4.rowInSort,
        feedRowNumber = var4.rowOnPage,
        heroUnitId = heroUnitId,
        tileType = tileType,
        launchData = launchData,
        actionType = if FFlagLuaAppDemoModePlayButtonTelemetry then tbl1.actionType else nil
    })
end

return sduiReportGamePlayIntent
