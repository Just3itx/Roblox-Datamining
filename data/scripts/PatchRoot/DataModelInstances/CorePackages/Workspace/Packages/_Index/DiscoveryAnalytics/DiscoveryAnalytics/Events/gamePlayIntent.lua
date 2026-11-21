-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T10:31:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")
local AppStorageService = game:GetService("AppStorageService")
local TelemetryService = game:GetService("TelemetryService")
local DiscoveryAnalytics = script:FindFirstAncestor("DiscoveryAnalytics")
local DiscoveryAnalyticsParent = DiscoveryAnalytics.Parent

local Cryo = require(DiscoveryAnalyticsParent.Cryo)
local getPlatformTarget = require(DiscoveryAnalyticsParent.Analytics).getPlatformTarget
local t = require(DiscoveryAnalyticsParent.t)
local DiscoveryEventErrorLogger = require(DiscoveryAnalyticsParent.DiscoveryUtils).DiscoveryEventErrorLogger

local FFlagLuaAppGamePlayIntentEventMobileAdsId = require(DiscoveryAnalyticsParent.SharedFlags).FFlagLuaAppGamePlayIntentEventMobileAdsId
local FFlagTraversalHistoryDiscoveryTelemetry = require(DiscoveryAnalyticsParent.SharedFlags).FFlagTraversalHistoryDiscoveryTelemetry

local FFlagLuaAppMigrateGameEventsTelemetryService = require(DiscoveryAnalyticsParent.SharedFlags).FFlagLuaAppMigrateGameEventsTelemetryService

local FFlagLuaAppGameEventsTelemetryServiceShadowTraffic = require(DiscoveryAnalyticsParent.SharedFlags).FFlagLuaAppGameEventsTelemetryServiceShadowTraffic
local FFlagLuaAppContinueSortInstantPlay = require(DiscoveryAnalyticsParent.SharedFlags).FFlagLuaAppContinueSortInstantPlay
local FFlagLuaAppDemoModePlayButtonTelemetry = require(DiscoveryAnalyticsParent.SharedFlags).FFlagLuaAppDemoModePlayButtonTelemetry

local throttlingPercentage = game:DefineFastInt("LuaAppGamePlayIntentEventThrottlingHundredthsPercent", 10000)

local num1 = game:DefineFastInt("LuaAppGamePlayIntentShadowThrottlingHundredthsPercent", 10000)

local Constants = require(DiscoveryAnalytics.Constants)

local config = nil
config = FFlagLuaAppMigrateGameEventsTelemetryService
    and {
        eventName = "gamePlayIntent",
        backends = { "EventIngest" },
        throttlingPercentage = throttlingPercentage,
        lastUpdated = { 26, 2, 4 },
        description = "Fires when the user clicks on a Play Button"
    }
    or config

local var1 = nil
var1 = FFlagLuaAppGameEventsTelemetryServiceShadowTraffic
    and {
        eventName = "gamePlayIntentShadow",
        backends = { "EventIngest" },
        throttlingPercentage = num1,
        lastUpdated = { 26, 3, 4 },
        description = "Shadow traffic for gamePlayIntent event recovery percentage"
    }
    or var1

local PlayGameFromPlayTogether = t.strictInterface({
    placeId = t.union(t.string, t.number),
    rootPlaceId = t.union(t.number, t.string),
    referralSource = t.optional(t.string),
    sortIndex = t.optional(t.string),
    sortEntryIndex = t.optional(t.string),
    gameSetTypeId = t.optional(t.string),
    gameSetTargetId = t.optional(t.number),
    linkId = t.optional(t.union(t.string, t.number)),
    linkType = t.optional(t.string),
    linkStatus = t.optional(t.string),
    conversationId = t.optional(t.union(t.number, t.string)),
    joinAttemptId = t.optional(t.string),
    uid = t.optional(t.string),
    launchData = t.optional(t.string),
    pageName = t.optional(t.string)
})

local PlayButton = t.strictInterface({
    placeId = t.union(t.string, t.number),
    rootPlaceId = t.union(t.number, t.string),
    referralSource = t.optional(t.string),
    universeId = t.string,
    launchData = t.optional(t.string),
    tileType = t.optional(t.string),
    nativeAdData = t.optional(t.string),
    pageName = t.optional(t.string),
    actionType = if FFlagLuaAppDemoModePlayButtonTelemetry then t.optional(t.string) else nil
})

local var4 = t.strictInterface({
    placeId = t.string,
    rootPlaceId = t.number,
    universeId = t.string,
    referralSource = t.optional(t.string),
    sortIndex = t.string,
    sortEntryIndex = t.string,
    gameSetTypeId = t.optional(t.string),
    gameSetTargetId = t.optional(t.number),
    appliedFilters = t.optional(t.string),
    topicDataPosition = t.optional(t.number),
    nativeAdData = t.optional(t.string),
    pageName = t.optional(t.string),
    positionInRow = t.optional(t.number),
    rowNumber = t.optional(t.number),
    feedRowNumber = t.optional(t.number),
    heroUnitId = t.optional(t.string),
    loadSource = t.optional(t.string),
    launchData = t.optional(t.string),
    sortSubId = t.optional(t.string),
    tileType = t.string,
    analyticsData = t.optional(t.table),
    actionType = if FFlagLuaAppDemoModePlayButtonTelemetry then t.optional(t.string) else nil
})

local var5 = t.strictInterface({
    placeId = t.string,
    rootPlaceId = t.number,
    universeId = t.string,
    sortEntryIndex = t.string,
    gameSetTypeId = t.string,
    sortIndex = t.string,
    rowOnPage = t.optional(t.number),
    topicDataPosition = t.optional(t.number),
    nativeAdData = t.optional(t.string),
    pageName = t.optional(t.string),
    launchData = t.optional(t.string),
    tileType = t.string,
    positionInRow = t.optional(t.number),
    rowNumber = t.optional(t.number),
    feedRowNumber = t.optional(t.number),
    actionType = if FFlagLuaAppDemoModePlayButtonTelemetry then t.optional(t.string) else nil
})

local var6 = t.strictInterface({
    placeId = t.string,
    rootPlaceId = t.number,
    joinAttemptId = t.optional(t.string),
    friendId = t.string,
    pageName = t.optional(t.string)
})

local var7 = t.strictInterface({
    placeId = t.string,
    rootPlaceId = t.number,
    joinAttemptId = t.optional(t.string),
    friendId = t.string,
    pageName = t.optional(t.string)
})

local PlayGameFromLinkCard = t.strictInterface({
    placeId = t.string,
    rootPlaceId = t.number,
    joinAttemptId = t.optional(t.string),
    conversationId = t.optional(t.string),
    pageName = t.optional(t.string)
})

local shareLinks = t.strictInterface({
    placeId = t.union(t.string, t.number),
    rootPlaceId = t.union(t.number, t.string),
    linkId = t.string,
    linkType = t.string,
    linkStatus = t.string,
    joinAttemptId = t.optional(t.string),
    pageName = t.optional(t.string)
})

local var10 = t.strictInterface({
    friendId = t.string,
    pageName = t.string,
    placeId = t.optional(t.string),
    rootPlaceId = t.optional(t.string),
    joinAttemptId = t.string
})

local var11 = t.strictInterface({
    placeId = t.string,
    rootPlaceId = t.number,
    universeId = t.string,
    referralSource = t.string,
    sortIndex = t.string,
    sortEntryIndex = t.string,
    gameSetTypeId = t.string,
    gameSetTargetId = t.optional(t.number),
    topicDataPosition = t.optional(t.number),
    nativeAdData = t.optional(t.string),
    pageName = t.optional(t.string),
    tileType = t.string,
    actionType = if FFlagLuaAppDemoModePlayButtonTelemetry then t.optional(t.string) else nil
})
local var12 = if FFlagTraversalHistoryDiscoveryTelemetry then t.strictInterface(
    {
        placeId = t.string,
        universeId = t.string,
        sortEntryIndex = t.string,
        pageName = t.optional(t.string)
    }
) else nil
local tbl1 = {
    PlayButton = PlayButton,
    [Constants.Context.ExperienceTile] = var4,
    [Constants.Context.SearchExperienceTile] = var5,
    [Constants.Context.PeopleListInHomePage] = var6,
    [Constants.Context.GamePlayIntentInPlacesList] = var7,
    shareLinks = shareLinks,
    PlayGameFromPlayTogether = PlayGameFromPlayTogether,
    PlayGameFromLinkCard = PlayGameFromLinkCard,
    [Constants.Context.PlayerContextualMenu] = var10,
    [Constants.Context.HoldToPlayLauncher] = var11
}
local InExpHistoryTile = Constants.Context.InExpHistoryTile

if not FFlagTraversalHistoryDiscoveryTelemetry then
    var12 = nil
end

tbl1[InExpHistoryTile] = var12

local InstantPlay = Constants.Context.InstantPlay

if not FFlagLuaAppContinueSortInstantPlay then
    var4 = nil
end

tbl1[InstantPlay] = var4

local function addMobileAdvertisingIdToEventParams(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    local mobileAdvertisingId = AppStorageService:GetItem("MobileAdvertisingId")
    if mobileAdvertisingId and mobileAdvertisingId ~= "" then
        arg1.mobileAdvertisingId = mobileAdvertisingId
    end
end

return function(arg1, eventContext: string, arg2)
    if tbl1[eventContext] ~= nil then
        local var13, var14 = tbl1[eventContext](arg2)

        if not var13 then
            DiscoveryEventErrorLogger.reportError("GamePlayIntentInvalidInterface", var14)
        end
    else
        DiscoveryEventErrorLogger.reportError(
            "GamePlayIntentMissingInterface",
            `Missing interface for eventContext {eventContext} to type check gamePlayIntent event parameters`,
            { eventContext = eventContext }
        )
    end

    local analyticsData = arg2.analyticsData

    if not arg2.interactionUuid then
        arg2.interactionUuid = HttpService:GenerateGUID(false)
    end

    if not arg2.contentType then
        arg2.contentType = "Game"
    end

    if not arg2.actionType then
        arg2.actionType = "PlayButtonClick"
    end

    if FFlagLuaAppGamePlayIntentEventMobileAdsId then
        addMobileAdvertisingIdToEventParams(arg2)
    end

    if FFlagLuaAppMigrateGameEventsTelemetryService then
        local tbl2 = {
            placeId = arg2.placeId,
            rootPlaceId = arg2.rootPlaceId,
            universeId = arg2.universeId,
            referralSource = arg2.referralSource,
            sortIndex = arg2.sortIndex,
            sortEntryIndex = arg2.sortEntryIndex,
            gameSetTypeId = arg2.gameSetTypeId,
            gameSetTargetId = arg2.gameSetTargetId,
            linkId = arg2.linkId,
            linkType = arg2.linkType,
            linkStatus = arg2.linkStatus,
            conversationId = arg2.conversationId,
            joinAttemptId = arg2.joinAttemptId,
            friendId = arg2.friendId,
            pageName = arg2.pageName,
            rowOnPage = arg2.rowOnPage,
            appliedFilters = arg2.appliedFilters,
            topicDataPosition = arg2.topicDataPosition,
            nativeAdData = arg2.nativeAdData,
            interactionUuid = arg2.interactionUuid,
            contentType = arg2.contentType,
            actionType = arg2.actionType,
            positionInRow = arg2.positionInRow,
            rowNumber = arg2.rowNumber,
            feedRowNumber = arg2.feedRowNumber,
            heroUnitId = arg2.heroUnitId,
            mobileAdvertisingId = if FFlagLuaAppGamePlayIntentEventMobileAdsId then arg2.mobileAdvertisingId else nil,
            loadSource = arg2.loadSource,
            launchData = if arg2.launchData then arg2.launchData else nil,
            sortSubId = arg2.sortSubId,
            tileType = arg2.tileType
        }

        if analyticsData then
            tbl2 = Cryo.Dictionary.join(analyticsData, tbl2)
        end

        TelemetryService:LogEvent(config, {
            eventContext = eventContext,
            standardizedFields = { "addSessionInfo", "addSessionId", "addOSInfo" },
            customFields = tbl2,
            legacyOverrideTargetForEventIngest = getPlatformTarget()
        })
    else
        local tbl2 = {
            placeId = arg2.placeId,
            rootPlaceId = arg2.rootPlaceId,
            universeId = arg2.universeId,
            referralSource = arg2.referralSource,
            sortIndex = arg2.sortIndex,
            sortEntryIndex = arg2.sortEntryIndex,
            gameSetTypeId = arg2.gameSetTypeId,
            gameSetTargetId = arg2.gameSetTargetId,
            linkId = arg2.linkId,
            linkType = arg2.linkType,
            linkStatus = arg2.linkStatus,
            conversationId = arg2.conversationId,
            joinAttemptId = arg2.joinAttemptId,
            friendId = arg2.friendId,
            pageName = arg2.pageName,
            rowOnPage = arg2.rowOnPage,
            appliedFilters = arg2.appliedFilters,
            topicDataPosition = arg2.topicDataPosition,
            nativeAdData = arg2.nativeAdData,
            interactionUuid = arg2.interactionUuid,
            contentType = arg2.contentType,
            actionType = arg2.actionType,
            positionInRow = arg2.positionInRow,
            rowNumber = arg2.rowNumber,
            feedRowNumber = arg2.feedRowNumber,
            heroUnitId = arg2.heroUnitId,
            mobileAdvertisingId = if FFlagLuaAppGamePlayIntentEventMobileAdsId then arg2.mobileAdvertisingId else nil,
            loadSource = arg2.loadSource,
            launchData = if arg2.launchData then arg2.launchData else nil,
            sortSubId = arg2.sortSubId,
            tileType = arg2.tileType
        }

        if analyticsData then
            tbl2 = Cryo.Dictionary.join(analyticsData, tbl2)
        end

        arg1:sendEventDeferred(eventContext, "gamePlayIntent", tbl2)
    end

    if not FFlagLuaAppGameEventsTelemetryServiceShadowTraffic then
        return
    end

    TelemetryService:LogEvent(var1, {
        eventContext = eventContext,
        standardizedFields = { "addSessionInfo", "addSessionId", "addOSInfo" },
        customFields = {
            placeId = arg2.placeId,
            rootPlaceId = arg2.rootPlaceId,
            universeId = arg2.universeId,
            referralSource = arg2.referralSource,
            sortIndex = arg2.sortIndex,
            sortEntryIndex = arg2.sortEntryIndex,
            gameSetTypeId = arg2.gameSetTypeId,
            gameSetTargetId = arg2.gameSetTargetId,
            linkId = arg2.linkId,
            linkType = arg2.linkType,
            linkStatus = arg2.linkStatus,
            conversationId = arg2.conversationId,
            joinAttemptId = arg2.joinAttemptId,
            friendId = arg2.friendId,
            pageName = arg2.pageName,
            rowOnPage = arg2.rowOnPage,
            appliedFilters = arg2.appliedFilters,
            topicDataPosition = arg2.topicDataPosition,
            nativeAdData = arg2.nativeAdData,
            interactionUuid = arg2.interactionUuid,
            contentType = arg2.contentType,
            actionType = arg2.actionType,
            positionInRow = arg2.positionInRow,
            rowNumber = arg2.rowNumber,
            feedRowNumber = arg2.feedRowNumber,
            heroUnitId = arg2.heroUnitId,
            mobileAdvertisingId = if FFlagLuaAppGamePlayIntentEventMobileAdsId then arg2.mobileAdvertisingId else nil,
            loadSource = arg2.loadSource,
            launchData = if arg2.launchData then arg2.launchData else nil,
            sortSubId = arg2.sortSubId,
            tileType = arg2.tileType
        },
        legacyOverrideTargetForEventIngest = getPlatformTarget()
    })
end
