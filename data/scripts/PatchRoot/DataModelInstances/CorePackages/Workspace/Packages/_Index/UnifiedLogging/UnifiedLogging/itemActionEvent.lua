-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T01:20:45Z
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
local FFlagLuaAppUnifiedLoggingDialogContentType = require(script.Parent.FFlagLuaAppUnifiedLoggingDialogContentType)

local FFlagLuaAppMigrateItemEventsTelemetryService = require(UnifiedLoggingParent.SharedFlags).FFlagLuaAppMigrateItemEventsTelemetryService

local FFlagLuaAppItemEventsTelemetryServiceShadowTraffic = require(UnifiedLoggingParent.SharedFlags).FFlagLuaAppItemEventsTelemetryServiceShadowTraffic

local throttlingPercentage = game:DefineFastInt("LuaAppItemActionEventThrottlingHundredthsPercent", 10000)

local num1 = game:DefineFastInt("LuaAppItemActionShadowThrottlingHundredthsPercent", 10000)

local config = nil
config = FFlagLuaAppMigrateItemEventsTelemetryService
    and {
        eventName = "itemAction",
        backends = { "EventIngest" },
        throttlingPercentage = throttlingPercentage,
        lastUpdated = { 26, 2, 4 },
        description = "Fires for default user actions, primarily through SDUI"
    }
    or config

local config2 = nil
config2 = FFlagLuaAppItemEventsTelemetryServiceShadowTraffic
    and {
        eventName = "itemActionShadow",
        backends = { "EventIngest" },
        throttlingPercentage = num1,
        lastUpdated = { 26, 3, 4 },
        description = "Shadow traffic for itemAction event recovery percentage"
    }
    or config2

local var1 = t.union(
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
    itemId = t.optional(t.string),
    itemPosition = t.optional(t.number),
    positionInRow = t.optional(t.number),
    rowNumber = t.optional(t.number),
    feedRowNumber = t.optional(t.number),
    positionInTopic = t.optional(t.number),
    actionType = t.string,
    interactionUuid = t.optional(t.string)
}

local var2 = t.intersection(var1, t.interface(tbl1))
local var3 = t.intersection(
    var1,
    t.interface(
        Cryo.Dictionary.join(tbl1, {
            itemId = t.string,
            itemPosition = t.number,
            sourceCarousel = t.string,
            friendStatus = t.string,
            presence = t.string,
            presenceUniverseId = t.string
        })
    )
)
local var4 = if FFlagLuaAppUnifiedLoggingDialogContentType then t.interface({ contentType = t.string, actionType = t.string, interactionUuid = t.optional(t.string) }) else nil
local tbl2 = {
    [ContentType.User] = var3
}
if FFlagLuaAppUnifiedLoggingDialogContentType then
    tbl2[ContentType.Dialog] = var4
end

return function(arg1, eventContext: string, str1: string, customFields)
    local var5 = tbl2[str1] or var2

    if var5 then
        local var6, var7 = var5(customFields)
        if not var6 then
            DiscoveryEventErrorLogger.reportError("ItemActionEventInvalidInterface", var7)
        end
    end

    if not customFields.interactionUuid then
        customFields.interactionUuid = HttpService:GenerateGUID(false)
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
        arg1:sendEventDeferred(eventContext, "itemAction", customFields)
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
