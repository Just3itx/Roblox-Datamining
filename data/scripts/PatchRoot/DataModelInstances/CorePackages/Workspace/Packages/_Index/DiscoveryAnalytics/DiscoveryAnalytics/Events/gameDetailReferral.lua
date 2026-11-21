-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T10:31:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")
local AppStorageService = game:GetService("AppStorageService")
local TelemetryService = game:GetService("TelemetryService")
local DiscoveryAnalyticsParent = script:FindFirstAncestor("DiscoveryAnalytics").Parent

local Cryo = require(DiscoveryAnalyticsParent.Cryo)
local getPlatformTarget = require(DiscoveryAnalyticsParent.Analytics).getPlatformTarget
local t = require(DiscoveryAnalyticsParent.t)
local DiscoveryEventErrorLogger = require(DiscoveryAnalyticsParent.DiscoveryUtils).DiscoveryEventErrorLogger

local FFlagEnableShareLinksInGameDetailEvent = require(DiscoveryAnalyticsParent.SharedFlags).FFlagEnableShareLinksInGameDetailEvent
local FFlagEnableTopSongsSort = require(DiscoveryAnalyticsParent.SharedFlags).FFlagEnableTopSongsSort
local FFlagLuaAppGameDetailEventMobileAdsId = require(DiscoveryAnalyticsParent.SharedFlags).FFlagLuaAppGameDetailEventMobileAdsId

local FFlagLuaAppMigrateGameEventsTelemetryService = require(DiscoveryAnalyticsParent.SharedFlags).FFlagLuaAppMigrateGameEventsTelemetryService

local FFlagLuaAppGameEventsTelemetryServiceShadowTraffic = require(DiscoveryAnalyticsParent.SharedFlags).FFlagLuaAppGameEventsTelemetryServiceShadowTraffic

local throttlingPercentage = game:DefineFastInt("LuaAppGameDetailReferralEventThrottlingHundredthsPercent", 10000)

local num1 = game:DefineFastInt("LuaAppGameDetailReferralShadowThrottlingHundredthsPercent", 10000)

local config = nil
config = FFlagLuaAppMigrateGameEventsTelemetryService
    and {
        eventName = "gameDetailReferral",
        backends = { "EventIngest" },
        throttlingPercentage = throttlingPercentage,
        lastUpdated = { 26, 2, 4 },
        description = "Fires when the user navigates to game details"
    }
    or config

local config2 = nil
config2 = FFlagLuaAppGameEventsTelemetryServiceShadowTraffic
    and {
        eventName = "gameDetailReferralShadow",
        backends = { "EventIngest" },
        throttlingPercentage = num1,
        lastUpdated = { 26, 3, 4 },
        description = "Shadow traffic for gameDetailReferral event recovery percentage"
    }
    or config2

local var1 = t.strictInterface({
    pg = t.string,
    universeId = t.union(t.string, t.number),
    navigationUniverseId = t.optional(t.string),
    pos = t.optional(t.number),
    pid = t.optional(t.union(t.number, t.string)),
    sortPos = t.optional(t.number),
    ad = t.optional(t.string),
    isAd = t.optional(t.boolean),
    nativeAdData = t.optional(t.string),
    gameSetTargetId = t.optional(t.number),
    gameSetTypeId = t.optional(t.string),
    tis = t.optional(t.number),
    refId = t.optional(t.string),
    src = t.optional(t.string),
    friendId = t.optional(t.string),
    position = t.optional(t.number),
    absolutePosition = t.optional(t.number),
    fromWhere = t.optional(t.string),
    locale = t.optional(t.string),
    conversationId = t.optional(t.number),
    shareLinkType = if FFlagEnableShareLinksInGameDetailEvent then t.optional(t.string) else nil,
    shareLinkId = if FFlagEnableShareLinksInGameDetailEvent then t.optional(t.string) else nil,
    rowOnPage = t.optional(t.number),
    appliedFilters = t.optional(t.string),
    topicDataPosition = t.optional(t.number),
    refSongId = if FFlagEnableTopSongsSort then t.optional(t.string) else nil,
    isSdui = t.optional(t.boolean),
    contentType = t.optional(t.string),
    actionType = t.optional(t.string),
    interactionUuid = t.optional(t.string),
    positionInRow = t.optional(t.number),
    rowNumber = t.optional(t.number),
    heroUnitId = t.optional(t.string),
    loadSource = t.optional(t.string),
    tileType = t.optional(t.string),
    sortSubId = t.optional(t.string),
    analyticsData = t.optional(t.table),
    seeAllFlag = t.optional(t.number)
})

local function addMobileAdvertisingIdToEventParams(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    local mobileAdvertisingId = AppStorageService:GetItem("MobileAdvertisingId")
    if mobileAdvertisingId and mobileAdvertisingId ~= "" then
        arg1.mobileAdvertisingId = mobileAdvertisingId
    end
end

return function(arg1, eventContext: string, customFields)
    local var2, var3 = var1(customFields)
    if not var2 then
        DiscoveryEventErrorLogger.reportError("GameDetailReferralInvalidInterface", var3)
    end

    if not customFields.interactionUuid then
        customFields.interactionUuid = HttpService:GenerateGUID(false)
    end

    if not customFields.contentType then
        customFields.contentType = "Game"
    end

    if not customFields.actionType then
        customFields.actionType = "OpenGameDetails"
    end

    if FFlagLuaAppGameDetailEventMobileAdsId then
        addMobileAdvertisingIdToEventParams(customFields)
    end

    if customFields.analyticsData then
        local analyticsData = customFields.analyticsData
        customFields = Cryo.Dictionary.join(analyticsData, customFields, { analyticsData = Cryo.None })
    end

    if FFlagLuaAppMigrateGameEventsTelemetryService then
        customFields.isSdui = if customFields.isSdui == true then "true" elseif customFields.isSdui == false then "false" else nil

        customFields.isAd = if customFields.isAd == true then "true" elseif customFields.isAd == false then "false" else nil

        TelemetryService:LogEvent(config, {
            eventContext = eventContext,
            standardizedFields = { "addSessionInfo", "addSessionId", "addOSInfo" },
            customFields = customFields,
            legacyOverrideTargetForEventIngest = getPlatformTarget()
        })
    else
        arg1:sendEventDeferred(eventContext, "gameDetailReferral", customFields)
    end

    if not FFlagLuaAppGameEventsTelemetryServiceShadowTraffic then
        return
    end
    local var4 = table.clone(customFields)
    var4.isSdui = if var4.isSdui == true then "true" elseif var4.isSdui == false then "false" else var4.isSdui
    var4.isAd = if var4.isAd == true then "true" elseif var4.isAd == false then "false" else var4.isAd

    TelemetryService:LogEvent(config2, {
        eventContext = eventContext,
        standardizedFields = { "addSessionInfo", "addSessionId", "addOSInfo" },
        customFields = var4,
        legacyOverrideTargetForEventIngest = getPlatformTarget()
    })
end
