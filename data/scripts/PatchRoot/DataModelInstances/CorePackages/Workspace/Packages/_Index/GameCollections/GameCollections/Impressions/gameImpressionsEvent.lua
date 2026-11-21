-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T17:21:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local HttpService = game:GetService("HttpService")
local TelemetryService = game:GetService("TelemetryService")
local GameCollectionsParent = script:FindFirstAncestor("GameCollections").Parent
local Cryo = require(GameCollectionsParent.Cryo)
local getPlatformTarget = require(GameCollectionsParent.Analytics).getPlatformTarget
local t = require(GameCollectionsParent.t)
local AppPage = require(GameCollectionsParent.RobloxAppEnums).AppPage
local ContentType = require(GameCollectionsParent.UnifiedLogging).ContentType
local DiscoveryEventErrorLogger = require(GameCollectionsParent.DiscoveryUtils).DiscoveryEventErrorLogger

local FFlagLuaAppGameImpressionsMobileAdsId = require(GameCollectionsParent.SharedFlags).FFlagLuaAppGameImpressionsMobileAdsId
local FFlagTraversalHistoryDiscoveryTelemetry = require(GameCollectionsParent.SharedFlags).FFlagTraversalHistoryDiscoveryTelemetry

local FFlagLuaAppMigrateGameEventsTelemetryService = require(GameCollectionsParent.SharedFlags).FFlagLuaAppMigrateGameEventsTelemetryService

local FFlagLuaAppGameEventsTelemetryServiceShadowTraffic = require(GameCollectionsParent.SharedFlags).FFlagLuaAppGameEventsTelemetryServiceShadowTraffic

local throttlingPercentage = game:DefineFastInt("LuaAppGameImpressionsEventThrottlingHundredthsPercent", 10000)

local num1 = game:DefineFastInt("LuaAppGameImpressionsShadowThrottlingHundredthsPercent", 10000)

local FFlagLuaAppGameImpressionsAddUnifiedFields = require(GameCollectionsParent.SharedFlags).FFlagLuaAppGameImpressionsAddUnifiedFields
local FFlagLuaAppSduiLandingPageEnabled = require(GameCollectionsParent.SharedFlags).FFlagLuaAppSduiLandingPageEnabled

local FFlagLuaAppAddAnalyticsDataToSeeAllImpressions = require(GameCollectionsParent.SharedFlags).FFlagLuaAppAddAnalyticsDataToSeeAllImpressions
local FFlagSduiSearchResultsPageEnabled = require(GameCollectionsParent.SharedFlags).FFlagSduiSearchResultsPageEnabled

local FFlagLuaAppSearchResultsPageGameTileVideo = require(GameCollectionsParent.SharedFlags).FFlagLuaAppSearchResultsPageGameTileVideo
local FFlagLuaAppDiscoveryMomentVideoTelemetry = require(GameCollectionsParent.SharedFlags).FFlagLuaAppDiscoveryMomentVideoTelemetry

local config = nil
config = FFlagLuaAppMigrateGameEventsTelemetryService
    and {
        eventName = "gameImpressions",
        backends = { "EventIngest" },
        throttlingPercentage = throttlingPercentage,
        lastUpdated = { 26, 2, 4 },
        description = "Fires when game tiles become visible to the user"
    }
    or config

local config2 = nil
config2 = FFlagLuaAppGameEventsTelemetryServiceShadowTraffic
    and {
        eventName = "gameImpressionsShadow",
        backends = { "EventIngest" },
        throttlingPercentage = num1,
        lastUpdated = { 26, 3, 4 },
        description = "Shadow traffic for gameImpressions event recovery percentage"
    }
    or config2

local var1 = t.strictInterface({
    absPositions = t.string,
    topicDataPositions = t.string,
    rootPlaceIds = t.string,
    universeIds = t.string,
    gameSetTypeId = t.string,
    sortPos = t.number,
    locale = t.string,
    thumbnailAssetIds = t.optional(t.string),
    thumbnailListIds = t.optional(t.string),
    videoThumbnailAssetIds = t.optional(t.string),
    videoIsMoment_arr = if FFlagLuaAppDiscoveryMomentVideoTelemetry then t.optional(t.string) else nil,
    componentType = t.optional(t.string),
    gameSetTargetId = t.optional(t.number),
    pageId = t.optional(t.string),
    adFlags = t.optional(t.string),
    adIds = t.optional(t.string),
    rows = t.optional(t.string),
    rowsOnPage = t.optional(t.string),
    positionsInRows = t.optional(t.string),
    tileBadgeContexts = t.optional(t.string),
    appliedFilters = t.optional(t.string),
    mobileAdvertisingId = if FFlagLuaAppGameImpressionsMobileAdsId then t.optional(t.string) else nil,
    footerTextLiterals = t.optional(t.string),
    footerLocalizationKeys = t.optional(t.string),
    loadSource = t.optional(t.string),
    tileTypes = t.optional(t.string),
    sortSubId = t.optional(t.string),
    analyticsData = t.optional(t.table),
    contentType = if FFlagLuaAppGameImpressionsAddUnifiedFields then t.optional(t.string) else nil,
    interactionUuid = if FFlagLuaAppGameImpressionsAddUnifiedFields then t.optional(t.string) else nil,
    hasSponsoredContent = if FFlagLuaAppGameImpressionsAddUnifiedFields then t.optional(t.boolean) else nil
})

local Deeplink = t.strictInterface({
    absPositions = t.string,
    topicDataPositions = t.string,
    rootPlaceIds = t.string,
    universeIds = t.string,
    gameSetTypeId = t.string,
    locale = t.string,
    seeAllFlag = t.number,
    gameSetTargetId = t.optional(t.number),
    pageId = t.optional(t.string),
    adFlags = t.optional(t.string),
    adIds = t.optional(t.string),
    thumbnailAssetIds = t.optional(t.string),
    thumbnailListIds = t.optional(t.string),
    videoThumbnailAssetIds = t.optional(t.string),
    videoIsMoment_arr = if FFlagLuaAppDiscoveryMomentVideoTelemetry then t.optional(t.string) else nil,
    tileBadgeContexts = t.optional(t.string),
    mobileAdvertisingId = if FFlagLuaAppGameImpressionsMobileAdsId then t.optional(t.string) else nil,
    appliedFilters = t.optional(t.string),
    footerTextLiterals = t.optional(t.string),
    footerLocalizationKeys = t.optional(t.string),
    tileTypes = t.optional(t.string),
    analyticsData = if FFlagLuaAppAddAnalyticsDataToSeeAllImpressions then t.optional(t.table) else nil,
    contentType = if FFlagLuaAppGameImpressionsAddUnifiedFields then t.optional(t.string) else nil,
    interactionUuid = if FFlagLuaAppGameImpressionsAddUnifiedFields then t.optional(t.string) else nil,
    hasSponsoredContent = if FFlagLuaAppGameImpressionsAddUnifiedFields then t.optional(t.boolean) else nil
})

local var3 = t.strictInterface({
    absPositions = t.string,
    topicDataPositions = t.string,
    rootPlaceIds = t.string,
    universeIds = t.string,
    searchUuid = t.string,
    emphasisFlag = t.number,
    seeAllFlag = t.number,
    sortPos = t.optional(t.number),
    gameSetTypeId = t.optional(t.string),
    locale = t.optional(t.string),
    adFlags = t.optional(t.string),
    adIds = t.optional(t.string),
    rows = t.optional(t.string),
    rowsOnPage = t.optional(t.string),
    positionsInRows = t.optional(t.string),
    mobileAdvertisingId = if FFlagLuaAppGameImpressionsMobileAdsId then t.optional(t.string) else nil,
    thumbnailAssetIds = t.optional(t.string),
    thumbnailListIds = t.optional(t.string),
    videoThumbnailAssetIds = if FFlagLuaAppSearchResultsPageGameTileVideo then t.optional(t.string) else nil,
    videoIsMoment_arr = if FFlagLuaAppDiscoveryMomentVideoTelemetry then t.optional(t.string) else nil,
    footerTextLiterals = t.optional(t.string),
    footerLocalizationKeys = t.optional(t.string),
    tileBadgeContexts = t.optional(t.string),
    componentType = t.optional(t.string),
    tileTypes = t.optional(t.string),
    analyticsData = if FFlagSduiSearchResultsPageEnabled then t.optional(t.table) else nil,
    contentType = if FFlagLuaAppGameImpressionsAddUnifiedFields then t.optional(t.string) else nil,
    interactionUuid = if FFlagLuaAppGameImpressionsAddUnifiedFields then t.optional(t.string) else nil,
    hasSponsoredContent = if FFlagLuaAppGameImpressionsAddUnifiedFields then t.optional(t.boolean) else nil
})

local recommended = t.strictInterface({
    absPositions = t.string,
    topicDataPositions = t.string,
    rootPlaceIds = t.string,
    universeIds = t.string,
    refId = t.string,
    adFlags = t.optional(t.string),
    adIds = t.optional(t.string),
    locale = t.optional(t.string),
    tileBadgeContexts = t.optional(t.string),
    mobileAdvertisingId = if FFlagLuaAppGameImpressionsMobileAdsId then t.optional(t.string) else nil,
    tileTypes = t.optional(t.string),
    contentType = if FFlagLuaAppGameImpressionsAddUnifiedFields then t.optional(t.string) else nil,
    interactionUuid = if FFlagLuaAppGameImpressionsAddUnifiedFields then t.optional(t.string) else nil,
    hasSponsoredContent = if FFlagLuaAppGameImpressionsAddUnifiedFields then t.optional(t.boolean) else nil
})

local var5 = t.strictInterface({
    absPositions = t.string,
    topicDataPositions = t.string,
    rootPlaceIds = t.string,
    universeIds = t.string,
    sortPos = t.number,
    gameSetTypeId = t.optional(t.string),
    locale = t.optional(t.string),
    thumbnailAssetIds = t.optional(t.string),
    videoThumbnailAssetIds = t.optional(t.string),
    videoIsMoment_arr = if FFlagLuaAppDiscoveryMomentVideoTelemetry then t.optional(t.string) else nil,
    componentType = t.optional(t.string),
    rowsOnPage = t.optional(t.string),
    positionsInRows = t.optional(t.string),
    mobileAdvertisingId = if FFlagLuaAppGameImpressionsMobileAdsId then t.optional(t.string) else nil,
    gameSetTargetId = t.optional(t.number),
    adFlags = t.optional(t.string),
    adIds = t.optional(t.string),
    tileBadgeContexts = t.optional(t.string),
    thumbnailListIds = t.optional(t.string),
    tileTypes = t.optional(t.string),
    contentType = if FFlagLuaAppGameImpressionsAddUnifiedFields then t.optional(t.string) else nil,
    interactionUuid = if FFlagLuaAppGameImpressionsAddUnifiedFields then t.optional(t.string) else nil,
    hasSponsoredContent = if FFlagLuaAppGameImpressionsAddUnifiedFields then t.optional(t.boolean) else nil
})
local var6

if FFlagTraversalHistoryDiscoveryTelemetry then
    var6 = t.strictInterface({
        absPositions = t.string,
        positionsInRows = t.optional(t.string),
        rootPlaceIds = t.string,
        rows = t.string,
        rowsOnPage = t.string,
        topicDataPositions = t.string,
        universeIds = t.string,
        locale = t.optional(t.string),
        tileBadgeContexts = t.optional(t.string),
        contentType = if FFlagLuaAppGameImpressionsAddUnifiedFields then t.optional(t.string) else nil,
        interactionUuid = if FFlagLuaAppGameImpressionsAddUnifiedFields then t.optional(t.string) else nil,
        hasSponsoredContent = if FFlagLuaAppGameImpressionsAddUnifiedFields then t.optional(t.boolean) else nil
    })
else
    var6 = nil
end

local tbl1 = {
    [AppPage.Home] = var1,
    [AppPage.Games] = var1
}
local SduiLandingPage = AppPage.SduiLandingPage

if not FFlagLuaAppSduiLandingPageEnabled then
    var1 = nil
end

tbl1[SduiLandingPage] = var1

tbl1[AppPage.SearchPage] = var3
tbl1[AppPage.SearchLandingPage] = var5
tbl1.recommended = recommended
tbl1.Deeplink = Deeplink
tbl1.InExpHistoryPage = var6

return function(arg1, eventContext, arg2)
    local var7 = if arg2.seeAllFlag and (eventContext == AppPage.Home or eventContext == AppPage.Games) then Deeplink else tbl1[eventContext]

    if var7 then
        local var8, var9 = var7(arg2)

        if not var8 then
            DiscoveryEventErrorLogger.reportError("GameImpressionsEventInvalidInterface", var9)
        end
    else
        DiscoveryEventErrorLogger.reportError(
            "GameImpressionsEventMissingInterface",
            `Missing interface for eventContext {eventContext} to type check gameImpressions event parameters`,
            { eventContext = eventContext }
        )
    end

    if FFlagLuaAppGameImpressionsAddUnifiedFields then
        arg2 = Cryo.Dictionary.join({ interactionUuid = HttpService:GenerateGUID(false), contentType = ContentType.Game }, arg2)
    end

    if arg2.analyticsData then
        local analyticsData = arg2.analyticsData
        arg2 = Cryo.Dictionary.join(analyticsData, arg2, { analyticsData = Cryo.None })
    end

    if FFlagLuaAppMigrateGameEventsTelemetryService then
        TelemetryService:LogEvent(config, {
            eventContext = eventContext,
            standardizedFields = { "addSessionInfo", "addSessionId", "addOSInfo" },
            customFields = arg2,
            legacyOverrideTargetForEventIngest = getPlatformTarget()
        })
    else
        arg1:sendEventDeferred(eventContext, "gameImpressions", arg2)
    end

    if not FFlagLuaAppGameEventsTelemetryServiceShadowTraffic then
        return
    end

    TelemetryService:LogEvent(config2, {
        eventContext = eventContext,
        standardizedFields = { "addSessionInfo", "addSessionId", "addOSInfo" },
        customFields = arg2,
        legacyOverrideTargetForEventIngest = getPlatformTarget()
    })
end
