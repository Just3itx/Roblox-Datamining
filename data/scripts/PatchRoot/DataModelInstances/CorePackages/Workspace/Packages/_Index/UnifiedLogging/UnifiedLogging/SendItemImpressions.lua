-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T01:20:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppStorageService = game:GetService("AppStorageService")
local UnifiedLogging = script:FindFirstAncestor("UnifiedLogging")
local UnifiedLoggingParent = UnifiedLogging.Parent

local ArgCheck = require(UnifiedLoggingParent.ArgCheck)
local Cryo = require(UnifiedLoggingParent.Cryo)
local DiscoveryEventErrorLogger = require(UnifiedLoggingParent.DiscoveryUtils).DiscoveryEventErrorLogger

local ContentType = require(UnifiedLogging.ContentType)
local itemImpressionsEvent = require(UnifiedLogging.itemImpressionsEvent)
local sduiCustomImpressionsEvent = require(UnifiedLogging.sduiCustomImpressionsEvent)
local userEntryUtils = require(UnifiedLogging.userEntryUtils)
local buildItemMetadataFields = require(UnifiedLogging.buildItemMetadataFields)
local buildGameMetadataFields = require(UnifiedLogging.buildGameMetadataFields)
local _SduiAnalyticsTypes = require(UnifiedLogging.SduiAnalyticsTypes)

local FFlagLuaAppDesktopFriendCarouselClicks = require(UnifiedLoggingParent.SharedFlags).FFlagLuaAppDesktopFriendCarouselClicks
local FFlagProfilePlatformEnableImpressions = require(UnifiedLoggingParent.SharedFlags).FFlagProfilePlatformEnableImpressions
local FFlagItemImpressionsAddGameMetadata = require(UnifiedLoggingParent.SharedFlags).FFlagItemImpressionsAddGameMetadata

local function func1(arg1, arg2, contentType: string, num1: number, collectionPosition: number, collectionId, totalNumberOfItems: number?, collectionComponentType: string?, collectionIdStr: string?, num2: number?)
    local tbl1 = {}
    local tbl2 = {}
    local tbl3 = {}
    local tbl4 = {}
    local tbl5 = {}
    local tbl6 = {}

    for _, value in arg1 do
        local var1 = if arg2 then arg2[value] or nil else nil

        if var1 ~= nil then
            table.insert(tbl1, var1.id)
            table.insert(tbl2, value)
            table.insert(tbl4, value)
            local var2

            if num1 and num1 > 0 then
                var2 = math.ceil(value / num1)
                value %= num1

                if value == 0 then
                    value = num1
                end

                table.insert(tbl3, var2)
            else
                ArgCheck.assert(num1 ~= 0)
                var2 = 1
            end

            if num2 then
                table.insert(tbl5, num2 + var2 - 1)
                table.insert(tbl6, value)
            end
        else
            DiscoveryEventErrorLogger.reportError(
                "SendItemImpressionsEventNilEntry",
                `Entry at index {value} was nil when sending item impressions for collection {collectionId}`,
                { entryIndex = value, collectionId = collectionId }
            )
        end
    end

    local num3 = #tbl1
    ArgCheck.assert(num3 == #tbl2)
    if #tbl3 > 0 then
        ArgCheck.assert(num3 == #tbl3)
    end
    if #tbl5 > 0 then
        ArgCheck.assert(num3 == #tbl5)
    end
    if #tbl6 > 0 then
        ArgCheck.assert(num3 == #tbl6)
    end

    local tbl7 = {
        contentType = contentType,
        itemIds = table.concat(tbl1, ","),
        itemPositions = table.concat(tbl2, ","),
        positionsInTopic = table.concat(tbl4, ","),
        collectionPosition = collectionPosition,
        collectionId = collectionId,
        totalNumberOfItems = totalNumberOfItems or arg2 and #arg2 or 0,
        collectionComponentType = collectionComponentType,
        collectionIdStr = 0
    }

    if not FFlagProfilePlatformEnableImpressions then
        collectionIdStr = nil
    end

    tbl7.collectionIdStr = collectionIdStr

    if #tbl3 > 0 then
        tbl7.rowNumbers = table.concat(tbl3, ",")
    end
    if #tbl5 > 0 then
        tbl7.feedRowNumbers = table.concat(tbl5, ",")
    end
    if #tbl6 > 0 then
        tbl7.positionsInRow = table.concat(tbl6, ",")
    end

    return tbl7
end

local function func2(arg1, arg2, sourceCarousel: string)
    local tbl1 = {}
    local tbl2 = {}
    local tbl3 = {}

    for _, value in arg1 do
        local var1 = if arg2 then arg2[value] or nil else nil

        if var1 == nil then
            continue
        end

        if FFlagLuaAppDesktopFriendCarouselClicks then
            local var2 = userEntryUtils.extractFieldsFromUserEntry(var1)

            table.insert(tbl1, var2.presence)
            table.insert(tbl2, var2.friendStatus)
            table.insert(tbl3, var2.presenceUniverseId)
        else
            table.insert(tbl1, var1.presence and var1.presence.userPresenceType or "")

            table.insert(tbl2, if var1.isFriend then "friend" else "notFriend")

            table.insert(
                tbl3,
                if not var1.presence or not var1.presence.universeId or var1.presence.universeId == "" then "-1" else var1.presence.universeId
            )
        end
    end

    return {
        sourceCarousel = sourceCarousel,
        presences = table.concat(tbl1, ","),
        friendStatuses = table.concat(tbl2, ","),
        presenceUniverseIds = table.concat(tbl3, ",")
    }
end

local function sendFromServerDrivenUi(arg1, tbl1, tbl2, arg2, str1: string, collectionId, contentType: string, num1: number, collectionPosition: number, num2: number?, str2: string?)
    if not arg1 then
        DiscoveryEventErrorLogger.reportError(
            "SendItemImpressionsFromSduiNilService",
            `Event Ingest was nil when trying to send itemImpressions for collection {collectionId}`,
            { collectionId = collectionId }
        )
        return
    end

    if not tbl1 or #tbl1 == 0 or not tbl2 or #tbl2 == 0 or not arg2 then
        return
    end

    local tbl3 = func1(
        tbl1,
        tbl2,
        contentType,
        num1,
        collectionPosition,
        collectionId,
        arg2.totalNumberOfItems,
        arg2.collectionComponentType,
        nil,
        num2
    )

    local itemMetadataFields = buildItemMetadataFields(tbl1, tbl2, collectionId)

    local var1 = Cryo.Dictionary.join(arg2, itemMetadataFields, tbl3)

    local mobileAdvertisingId = AppStorageService:GetItem("MobileAdvertisingId")
    if mobileAdvertisingId and mobileAdvertisingId ~= "" then
        var1.mobileAdvertisingId = mobileAdvertisingId
    end

    if var1.collectionId and type(var1.collectionId) == "string" and type(tonumber(var1.collectionId)) ~= "number" then
        var1.collectionIdStr = var1.collectionId
        var1.collectionId = nil
    end

    if str2 then
        sduiCustomImpressionsEvent(str2, str1, var1)
        return
    end
    itemImpressionsEvent(arg1, str1, contentType, var1)
end

return {
    sendFromFriendsCarousel = function(eventIngest, appAnalytics, arg1, arg2, arg3, collectionPosition: number, sortId, sourceCarousel: string)
        if not (eventIngest and appAnalytics) then
            if FFlagLuaAppDesktopFriendCarouselClicks then
                DiscoveryEventErrorLogger.reportError(
                    "SendItemImpressionsService",
                    `Event Ingest or App Analytics was nil when trying to send itemImpressions for collection {sortId}`,
                    { eventIngest = eventIngest, appAnalytics = appAnalytics, sortId = sortId }
                )
            end
        elseif arg1 and #arg1 ~= 0 and arg2 and #arg2 ~= 0 then
            local num1 = #arg2
            local user = ContentType.User

            local tbl1 = func1(arg1, arg2, user, num1, collectionPosition, sortId)

            local tbl2 = func2(arg1, arg2, sourceCarousel)

            local var1 = Cryo.Dictionary.union(tbl1, tbl2)

            itemImpressionsEvent(eventIngest, arg3, user, var1)
        end
    end,
    sendFromItemCollection = require(UnifiedLoggingParent.SharedFlags).FFlagEnableTopSongsSort and function(eventIngest, appAnalytics, arg1, tbl1, num1: number, arg2, collectionPosition: number, game: string, totalNumberOfItems: number, sortId: number?, str1: string?)
        if not (eventIngest and appAnalytics) then
            DiscoveryEventErrorLogger.reportError(
                "SendItemImpressionsService",
                `Event Ingest or App Analytics was nil when trying to send itemImpressions for collection {sortId}`,
                { eventIngest = eventIngest, appAnalytics = appAnalytics, sortId = sortId }
            )
            return
        end

        if not arg1 or #arg1 == 0 or not tbl1 or #tbl1 == 0 then
            return
        end

        local tbl2 = func1(arg1, tbl1, game, num1, collectionPosition, sortId, totalNumberOfItems, nil, str1)

        if not FFlagItemImpressionsAddGameMetadata then
            itemImpressionsEvent(eventIngest, arg2, game, tbl2)
            return
        end

        if game == ContentType.Game then
            local gameMetadataFields = buildGameMetadataFields(arg1, tbl1, str1)
            tbl2 = Cryo.Dictionary.union(tbl2, gameMetadataFields)
        end
        itemImpressionsEvent(eventIngest, arg2, game, tbl2)
    end or nil,
    sendFromProfile = if FFlagProfilePlatformEnableImpressions then FFlagProfilePlatformEnableImpressions and function(eventIngest, appAnalytics, tbl1, tbl2, num1: number, str1: string, game: string, collectionPosition: number, collectionIdStr: string)
        if not (eventIngest and appAnalytics) then
            DiscoveryEventErrorLogger.reportError(
                "SendItemImpressionsFromProfile",
                `Event Ingest or App Analytics was nil when trying to send itemImpressions for collection {collectionIdStr} on Profile Platform`,
                {
                    eventIngest = eventIngest,
                    appAnalytics = appAnalytics,
                    collectionIdStr = collectionIdStr
                }
            )
            return
        end

        if not tbl1 or #tbl1 == 0 or not tbl2 or #tbl2 == 0 then
            return
        end

        local tbl3 = func1(tbl1, tbl2, game, num1, collectionPosition, nil, #tbl2, nil, collectionIdStr)

        if not FFlagItemImpressionsAddGameMetadata then
            itemImpressionsEvent(eventIngest, str1, game, tbl3)
            return
        end

        if game == ContentType.Game then
            local gameMetadataFields = buildGameMetadataFields(tbl1, tbl2, collectionIdStr)
            tbl3 = Cryo.Dictionary.union(tbl3, gameMetadataFields)
        end

        itemImpressionsEvent(eventIngest, str1, game, tbl3)
    end or nil else nil,
    sendFromServerDrivenUi = sendFromServerDrivenUi
}
