-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T01:20:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local HttpService = game:GetService("HttpService")
local TelemetryService = game:GetService("TelemetryService")
local UnifiedLogging = script:FindFirstAncestor("UnifiedLogging")
local UnifiedLoggingParent = UnifiedLogging.Parent

local Cryo = require(UnifiedLoggingParent.Cryo)
local getPlatformTarget = require(UnifiedLoggingParent.Analytics).getPlatformTarget
local t = require(UnifiedLoggingParent.t)
local DiscoveryEventErrorLogger = require(UnifiedLoggingParent.DiscoveryUtils).DiscoveryEventErrorLogger

local ContentType = require(UnifiedLogging.ContentType)

local FFlagLuaAppLoosenCollectionIdTypeInterface = require(UnifiedLoggingParent.SharedFlags).FFlagLuaAppLoosenCollectionIdTypeInterface
local FFlagProfilePlatformEnableImpressions = require(UnifiedLoggingParent.SharedFlags).FFlagProfilePlatformEnableImpressions
local FFlagItemImpressionsAddGameMetadata = require(UnifiedLoggingParent.SharedFlags).FFlagItemImpressionsAddGameMetadata
local FFlagEnableTopSongsSort = require(UnifiedLoggingParent.SharedFlags).FFlagEnableTopSongsSort

local FFlagLuaAppMigrateItemEventsTelemetryService = require(UnifiedLoggingParent.SharedFlags).FFlagLuaAppMigrateItemEventsTelemetryService

local FFlagLuaAppItemEventsTelemetryServiceShadowTraffic = require(UnifiedLoggingParent.SharedFlags).FFlagLuaAppItemEventsTelemetryServiceShadowTraffic
local FFlagLuaAppItemImpressionsInteractionUuid = require(script.Parent.FFlagLuaAppItemImpressionsInteractionUuid)

local throttlingPercentage = game:DefineFastInt("LuaAppItemImpressionsEventThrottlingHundredthsPercent", 10000)

local num1 = game:DefineFastInt("LuaAppItemImpressionsShadowThrottlingHundredthsPercent", 10000)

local config = nil
config = FFlagLuaAppMigrateItemEventsTelemetryService
    and {
        eventName = "itemImpressions",
        backends = { "EventIngest" },
        throttlingPercentage = throttlingPercentage,
        lastUpdated = { 26, 2, 4 },
        description = "Fires when items become visible to the user, primarily through SDUI"
    }
    or config

local config2 = nil
config2 = FFlagLuaAppItemEventsTelemetryServiceShadowTraffic
    and {
        eventName = "itemImpressionsShadow",
        backends = { "EventIngest" },
        throttlingPercentage = num1,
        lastUpdated = { 26, 3, 4 },
        description = "Shadow traffic for itemImpressions event recovery percentage"
    }
    or config2

local var1 = nil

local var2 = t.union(
    t.interface({
        collectionId = if FFlagLuaAppLoosenCollectionIdTypeInterface then t.union(t.string, t.number) else t.number,
        collectionIdStr = t.optional(t.string)
    }),
    t.interface({
        collectionId = t.optional(if FFlagLuaAppLoosenCollectionIdTypeInterface then t.union(t.string, t.number) else t.number),
        collectionIdStr = t.string
    })
)

local tbl1 = {
    collectionPosition = t.number,
    totalNumberOfItems = t.number,
    contentType = t.string,
    interactionUuid = if FFlagLuaAppItemImpressionsInteractionUuid then t.optional(t.string) else nil,
    itemIds = t.string,
    itemPositions = t.string,
    rowNumbers = t.optional(t.string),
    feedRowNumbers = t.optional(t.string),
    positionsInRow = t.optional(t.string),
    positionsInTopic = t.optional(t.string)
}

local var3 = t.intersection(var2, t.interface(tbl1))
local var4 = t.intersection(
    var2,
    t.interface(
        Cryo.Dictionary.join(
            tbl1,
            {
                sourceCarousel = t.string,
                friendStatuses = t.string,
                presences = t.string,
                presenceUniverseIds = t.string
            }
        )
    )
)

if FFlagItemImpressionsAddGameMetadata then
    var1 = t.intersection(var2, t.interface(Cryo.Dictionary.join(tbl1, { universeId_arr = t.string, placeId_arr = t.string })))
end

local tbl2 = {
    [ContentType.User] = var4
}
local Game = ContentType.Game

if not (FFlagItemImpressionsAddGameMetadata and FFlagProfilePlatformEnableImpressions) then
    if FFlagProfilePlatformEnableImpressions then
        var1 = var3
    else
        var1 = nil
    end
end

tbl2[Game] = var1

local Song = ContentType.Song
tbl2[Song] = if FFlagEnableTopSongsSort then var3 else nil
tbl2[ContentType.Badge] = var3

return function(arg1, eventContext: string, str1: string, customFields)
    if FFlagLuaAppItemImpressionsInteractionUuid and not customFields.interactionUuid then
        customFields.interactionUuid = HttpService:GenerateGUID(false)
    end

    local var5 = tbl2[str1] or var3

    if var5 then
        local var6, var7 = var5(customFields)
        if not var6 then
            DiscoveryEventErrorLogger.reportError("ItemImpressionsEventInvalidInterface", var7)
        end
    end

    if FFlagLuaAppMigrateItemEventsTelemetryService then
        for k, customField in customFields do
            if type(customField) == "boolean" then
                customFields[k] = if customField == true then "true" elseif customField == false then "false" else nil
            end
        end

        TelemetryService:LogEvent(config, {
            eventContext = eventContext,
            standardizedFields = { "addSessionInfo", "addSessionId", "addOSInfo" },
            customFields = customFields,
            legacyOverrideTargetForEventIngest = getPlatformTarget()
        })
    else
        arg1:sendEventDeferred(eventContext, "itemImpressions", customFields)
    end

    if not FFlagLuaAppItemEventsTelemetryServiceShadowTraffic then
        return
    end
    local var6 = table.clone(customFields)
    for value, value2 in var6 do
        if type(value2) == "boolean" then
            var6[value] = if value2 == true then "true" elseif value2 == false then "false" else nil
        end
    end

    TelemetryService:LogEvent(config2, {
        eventContext = eventContext,
        standardizedFields = { "addSessionInfo", "addSessionId", "addOSInfo" },
        customFields = var6,
        legacyOverrideTargetForEventIngest = getPlatformTarget()
    })
end
