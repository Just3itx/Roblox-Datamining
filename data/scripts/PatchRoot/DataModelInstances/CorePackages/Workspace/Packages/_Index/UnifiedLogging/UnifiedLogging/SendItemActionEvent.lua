-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T01:20:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppStorageService = game:GetService("AppStorageService")
local UnifiedLogging = script:FindFirstAncestor("UnifiedLogging")
local UnifiedLoggingParent = UnifiedLogging.Parent

local Cryo = require(UnifiedLoggingParent.Cryo)
local DiscoveryEventErrorLogger = require(UnifiedLoggingParent.DiscoveryUtils).DiscoveryEventErrorLogger

local ContentType = require(UnifiedLogging.ContentType)
local itemActionEvent = require(UnifiedLogging.itemActionEvent)
local userEntryUtils = require(UnifiedLogging.userEntryUtils)
local _SduiAnalyticsTypes = require(UnifiedLogging.SduiAnalyticsTypes)
local calculateRowPositionFields = require(UnifiedLogging.calculateRowPositionFields)

local function func1(arg1, num1: number, rowNumber: number, contentType: string, collectionPosition: number, collectionId, totalNumberOfItems: number, actionType: string, collectionComponentType: string?, itemComponentType: string?, positionInRow: number?, feedRowNumber: number?)
    if not arg1 then
        DiscoveryEventErrorLogger.reportError(
            "SendItemActionEventNilEntry",
            `Entry at index {num1} was nil when sending item action event for collection {collectionId}`,
            { entryIndex = num1, collectionId = collectionId }
        )

        return {}
    end

    return {
        collectionComponentType = collectionComponentType,
        itemComponentType = itemComponentType,
        collectionId = collectionId,
        collectionPosition = collectionPosition,
        totalNumberOfItems = totalNumberOfItems,
        contentType = contentType,
        itemId = arg1.id,
        itemPosition = num1,
        positionInRow = positionInRow,
        rowNumber = rowNumber,
        feedRowNumber = feedRowNumber,
        positionInTopic = num1,
        actionType = actionType
    }
end

local function func2(arg1, sourceCarousel: string) -- Luacid: Inlined by compiler; 1 call site recovered
    local var1 = userEntryUtils.extractFieldsFromUserEntry(arg1)

    return {
        sourceCarousel = sourceCarousel,
        presence = var1.presence,
        friendStatus = var1.friendStatus,
        presenceUniverseId = var1.presenceUniverseId
    }
end

return {
    sendFromItemCollection = require(UnifiedLoggingParent.SharedFlags).FFlagEnableTopSongsSort and function(eventIngest, appAnalytics, arg1, rowNumber: number, num1: number, arg2, collectionPosition: number, collectionId: string, totalNumberOfItems: number, contentType: string, actionType: string)
        if eventIngest and appAnalytics then
            local var1 = func1(arg1, num1, rowNumber, contentType, collectionPosition, collectionId, totalNumberOfItems, actionType)

            itemActionEvent(eventIngest, arg2, contentType, var1)
            return
        end

        DiscoveryEventErrorLogger.reportError(
            "SendItemActionEventNilServiceItemCollection",
            "Event Ingest or App Analytics was nil when trying to send an itemActionEvent for collection",
            { eventIngest = eventIngest, appAnalytics = appAnalytics }
        )
    end or nil,
    sendFromFriendsCarousel = function(eventIngest, appAnalytics, arg1, num1: number, arg2, collectionPosition: number, sortId, totalNumberOfItems: number, sourceCarousel: string, actionType: string)
        if not (eventIngest and appAnalytics) then
            DiscoveryEventErrorLogger.reportError(
                "SendItemActionEventNilService",
                `Event Ingest or App Analytics was nil when trying to send an itemActionEvent for collection {sortId}`,
                { eventIngest = eventIngest, appAnalytics = appAnalytics, sortId = sortId }
            )

            return
        end

        local user = ContentType.User

        local var1 = func1(arg1, num1, 1, user, collectionPosition, sortId, totalNumberOfItems, actionType)
        local tbl1 = func2(arg1, sourceCarousel)
        local var2 = Cryo.Dictionary.union(var1, tbl1)

        itemActionEvent(eventIngest, arg2, user, var2)
    end,
    sendFromServerDrivenUi = function(eventIngest, arg1, num1: number, arg2, str1: string, collectionId, contentType: string, num2: number, collectionPosition: number, totalNumberOfItems: number, _: number?, actionType: string, tbl1, num3: number?)
        if not eventIngest then
            DiscoveryEventErrorLogger.reportError(
                "SendItemActionEventFromSduiNilService",
                `Event Ingest was nil when trying to send an itemActionEvent for collection {collectionId}`,
                { eventIngest = eventIngest, collectionId = collectionId }
            )

            return
        end

        local rowPositionFields = calculateRowPositionFields(num1, num2, num3)

        local var1 = func1(
            arg1,
            num1,
            rowPositionFields.rowInSort,
            contentType,
            collectionPosition,
            collectionId,
            totalNumberOfItems,
            actionType,
            arg2.collectionComponentType,
            arg1.itemComponentType,
            rowPositionFields.positionInRow,
            rowPositionFields.rowOnPage
        )

        local var2 = Cryo.Dictionary.join(arg2, arg1, tbl1 or {}, var1)

        local mobileAdvertisingId = AppStorageService:GetItem("MobileAdvertisingId")
        if mobileAdvertisingId and mobileAdvertisingId ~= "" then
            var2.mobileAdvertisingId = mobileAdvertisingId
        end

        if var2.collectionId and type(var2.collectionId) == "string" and type(tonumber(var2.collectionId)) ~= "number" then
            var2.collectionIdStr = var2.collectionId
            var2.collectionId = nil
        end

        itemActionEvent(eventIngest, str1, contentType, var2)
    end
}
