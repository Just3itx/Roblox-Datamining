-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T17:21:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local LocalizationService = game:GetService("LocalizationService")
local GameCollections = script:FindFirstAncestor("GameCollections")
local AppStorageService = game:GetService("AppStorageService")
local IXPService = game:GetService("IXPService")
local GameCollectionsParent = GameCollections.Parent
local ArgCheck = require(GameCollectionsParent.ArgCheck)
local LoggingProtocol = require(GameCollectionsParent.LoggingProtocol)
local Cryo = require(GameCollectionsParent.Cryo)
local getGameTileLayoutData = require(GameCollectionsParent.GameTile).getGameTileLayoutData
local getValidTileBadges = require(GameCollectionsParent.GameTile).getValidTileBadges
local getTileBadgeByPositionConfigFromEntry = require(GameCollectionsParent.GameTile).getTileBadgeByPositionConfigFromEntry
local GameTile = require(GameCollectionsParent.GameTile)
local ItemLayoutDataParsingUtils = GameTile.ItemLayoutDataParsingUtils
local calculateRowPositionFields = require(GameCollectionsParent.UnifiedLogging).calculateRowPositionFields
local DiscoveryEventErrorLogger = require(GameCollectionsParent.DiscoveryUtils).DiscoveryEventErrorLogger

local GameCollectionItemTypes = require(GameCollectionsParent.DiscoveryTypes).GameCollectionItemTypes

local AppPage = require(GameCollectionsParent.RobloxAppEnums).AppPage
local AppUserLayers = require(GameCollectionsParent.ExperimentLayers).AppUserLayers
local gameImpressionsEvent = require(script.Parent.gameImpressionsEvent)
local reportGameImpressionCounts = require(script.Parent.reportGameImpressionCounts)
local FeedItemRowDataHitCounter = require(script.Parent.FeedItemRowDataHitCounter)
local FeedItemRowDataMissingCounter = require(script.Parent.FeedItemRowDataMissingCounter)
local FFlagLuaAppGameImpressionsMobileAdsId = require(GameCollectionsParent.SharedFlags).FFlagLuaAppGameImpressionsMobileAdsId
local FFlagTraversalHistoryDiscoveryTelemetry = require(GameCollectionsParent.SharedFlags).FFlagTraversalHistoryDiscoveryTelemetry

local FFlagLuaAppGameImpressionsAddUnifiedFields = require(GameCollectionsParent.SharedFlags).FFlagLuaAppGameImpressionsAddUnifiedFields
local FFlagSduiFixSearchTelemetry = require(GameCollectionsParent.SharedFlags).FFlagSduiFixSearchTelemetry
local FFlagLuaAppSponsoredGamePreviewVideo = require(GameCollectionsParent.SharedFlags).FFlagLuaAppSponsoredGamePreviewVideo
local FFlagLuaAppHomeMomentVideoFallback = require(GameCollectionsParent.SharedFlags).FFlagLuaAppHomeMomentVideoFallback
local FFlagLuaAppDiscoveryMomentVideoTelemetry = require(GameCollectionsParent.SharedFlags).FFlagLuaAppDiscoveryMomentVideoTelemetry

local function logSponsoredGamePreviewVideoExposureIfEligible(tbl1, tbl2, pageContext: string)
    for _, entryIndex in ipairs(tbl1) do
        local var1 = tbl2[entryIndex]
        if not var1 or not var1.isSponsored or var1.sponsoredGamePreviewVideoEligible ~= true then
            continue
        end

        if pageContext == AppPage.Home then
            IXPService:LogUserLayerExposure(AppUserLayers.SponsoredGamePreviewVideo)
            return
        end
        DiscoveryEventErrorLogger.reportError(
            "SponsoredGamePreviewVideoEligibleImpressionOutsideHome",
            "A sponsored GPV-eligible tile was impressed outside Home; exposure was suppressed",
            { pageContext = pageContext, entryIndex = entryIndex }
        )

        return
    end
end

local function addGameFields(tbl1, tbl2, arg1, arg2, arg3, gameSortId: string?, tbl3, arg4, pageContext: string?)
    local tbl4 = {}
    local tbl5 = {}
    local tbl6 = {}
    local tbl7 = {}
    local tbl8 = {}
    local tbl9 = {}
    local tbl10 = {}
    local var1 = FFlagLuaAppDiscoveryMomentVideoTelemetry and {} or nil
    local tbl11 = {}
    local tbl12 = {}
    local tbl13 = {}
    local tbl14 = {}
    local tbl15 = {}
    local tbl16 = {}
    local tbl17 = {}
    local tbl18 = {}
    local tbl19 = {}
    local tbl20 = {}
    local tbl21 = ({})

    local bool1 = false
    for _, entryIndex in ipairs(tbl1) do
        local var2 = tbl2[entryIndex]

        if var2 == nil then
            continue
        end

        if var2.gameCollectionItemTypeOverride == GameCollectionItemTypes.GameCollectionItemType.Blank then
            DiscoveryEventErrorLogger.reportError(
                "InvalidGameImpressionCollectionItemType",
                "An impression for a blank tile was attempted to be logged, which should not happen.",
                {
                    entryIndex = entryIndex,
                    pageContext = pageContext,
                    emphasisFlag = if arg4 then arg4.emphasisFlag else nil,
                    sortPos = if arg4 then arg4.sortPos else nil,
                    gameSortId = gameSortId
                }
            )
        else
            local var3 = var2.uiIndex or entryIndex
            local var4 = var2.topicContentsIndex or entryIndex

            table.insert(tbl4, var2.placeId or 0)
            table.insert(tbl5, entryIndex)
            table.insert(tbl7, var2.universeId or 0)
            table.insert(tbl6, var4)

            if var2.isSponsored then
                table.insert(tbl11, 1)
                table.insert(tbl12, var2.adId or 0)
                bool1 = true
            else
                table.insert(tbl11, 0)
                table.insert(tbl12, 0)
            end

            table.insert(tbl19, var2.gameCollectionItemTypeOverride or GameCollectionItemTypes.GameCollectionItemType.GameTile)

            local rowPositionFields = calculateRowPositionFields(var3, arg1, arg3)

            if arg1 and arg1 > 0 then
                table.insert(tbl13, rowPositionFields.rowInSort)

                if arg3 then
                    table.insert(tbl14, rowPositionFields.rowOnPage)
                    table.insert(tbl15, rowPositionFields.positionInRow)
                end
            else
                ArgCheck.assert(arg1 ~= 0)

                if arg3 then
                    table.insert(tbl14, arg3)
                    table.insert(tbl15, var3)
                end
            end

            local gameTileLayoutData = getGameTileLayoutData(var2, gameSortId)

            local var5 = getTileBadgeByPositionConfigFromEntry(var2) or gameTileLayoutData.tileBadgesByPosition

            local tileBadgeIds = nil

            if var2.tileBadgeIds then
                tileBadgeIds = var2.tileBadgeIds
            elseif var5 then
                local tbl22 = {}

                for value2, value3 in (getValidTileBadges(var5)) do
                    local var6 = Cryo.List.map(value3, function(arg5)
                        return arg5.analyticsId
                    end)

                    if #var6 > 0 then
                        table.insert(tbl22, value2 .. "=" .. table.concat(var6, "+"))
                    end
                end

                if #tbl22 > 0 then
                    tileBadgeIds = table.concat(tbl22, "&")
                end
            end

            table.insert(tbl16, tileBadgeIds or "0")

            if arg2 then
                if var2 and var2.thumbnailAssetId then
                    table.insert(tbl8, var2.thumbnailAssetId)
                else
                    local var6 = if var2 and var2.primaryWideImageAssetId then var2.primaryWideImageAssetId else ItemLayoutDataParsingUtils.getWideImageAssetId(gameTileLayoutData)

                    if not var6 then
                        if var2 then
                            var6 = var2.primaryWideAssetId or nil
                        else
                            var6 = nil
                        end
                    end

                    table.insert(tbl8, var6 or "0")
                end

                if var2 and var2.thumbnailListId then
                    table.insert(tbl9, var2.thumbnailListId)
                else
                    table.insert(
                        tbl9,
                        (if var2 and var2.primaryWideImageListId then var2.primaryWideImageListId else gameTileLayoutData and gameTileLayoutData.primaryMediaAsset and gameTileLayoutData.primaryMediaAsset.wideImageListId)
                            or var2 and var2.primaryWideListId
                            or "0"
                    )
                end
                if var2 and var2.videoThumbnailAssetId then
                    table.insert(tbl10, var2.videoThumbnailAssetId)
                    if FFlagLuaAppDiscoveryMomentVideoTelemetry then
                        table.insert(var1, "0")
                    end
                else
                    local var6

                    if FFlagLuaAppHomeMomentVideoFallback then
                        local layoutDataVideo = GameTile.getLayoutDataVideo(gameTileLayoutData, var2 and var2.primaryWideVideoAssetId)
                        var6 = layoutDataVideo and layoutDataVideo.assetId
                        if FFlagLuaAppDiscoveryMomentVideoTelemetry then
                            table.insert(var1, if layoutDataVideo and layoutDataVideo.isMoment then "1" else "0")
                        end
                    elseif var2 and var2.primaryWideVideoAssetId then
                        var6 = var2.primaryWideVideoAssetId
                    else
                        var6 = gameTileLayoutData and gameTileLayoutData.primaryMediaAsset and gameTileLayoutData.primaryMediaAsset.wideVideoAssetId
                    end

                    table.insert(tbl10, var6 or "0")
                end

                local analytics = nil
                if var2 and var2.footer and var2.footer.analytics then
                    analytics = var2.footer.analytics
                elseif gameTileLayoutData and gameTileLayoutData.footer and gameTileLayoutData.footer.analytics then
                    analytics = gameTileLayoutData.footer.analytics
                end

                if analytics and analytics.textLiteral then
                    table.insert(tbl17, analytics.textLiteral)
                else
                    table.insert(tbl17, "0")
                end

                if analytics and analytics.locKey then
                    table.insert(tbl18, analytics.locKey)
                else
                    table.insert(tbl18, "0")
                end
            end

            local analyticsData = var2.analyticsData
            if analyticsData then
                for value2 in analyticsData do
                    tbl21[value2] = true
                end
            end
            table.insert(tbl20, analyticsData or {})
        end
    end

    local num1 = #tbl4
    ArgCheck.assert(num1 == #tbl5)
    ArgCheck.assert(num1 == #tbl6)
    ArgCheck.assert(num1 == #tbl7)
    ArgCheck.assert(num1 == #tbl11)
    ArgCheck.assert(num1 == #tbl12)
    if #tbl13 > 0 then
        ArgCheck.assert(num1 == #tbl13)
    end
    if #tbl14 > 0 then
        ArgCheck.assert(num1 == #tbl14)
    end
    if #tbl15 > 0 then
        ArgCheck.assert(num1 == #tbl15)
    end

    local tbl22 = {
        rootPlaceIds = table.concat(tbl4, ","),
        absPositions = table.concat(tbl5, ","),
        topicDataPositions = table.concat(tbl6, ","),
        universeIds = table.concat(tbl7, ",")
    }
    if bool1 then
        tbl22.adFlags = table.concat(tbl11, ",")
        tbl22.adIds = table.concat(tbl12, ",")
    end
    if FFlagLuaAppGameImpressionsAddUnifiedFields then
        tbl22.hasSponsoredContent = bool1
    end
    if #tbl13 > 0 then
        tbl22.rows = table.concat(tbl13, ",")
    end
    if #tbl14 > 0 then
        tbl22.rowsOnPage = table.concat(tbl14, ",")
    end
    if #tbl15 > 0 then
        tbl22.positionsInRows = table.concat(tbl15, ",")
    end

    if arg2 and #tbl8 > 0 then
        tbl22.thumbnailAssetIds = table.concat(tbl8, ",")
    end

    if arg2 and #tbl9 > 0 then
        tbl22.thumbnailListIds = table.concat(tbl9, ",")
    end

    if arg2 and #tbl10 > 0 then
        tbl22.videoThumbnailAssetIds = table.concat(tbl10, ",")
    end

    if FFlagLuaAppDiscoveryMomentVideoTelemetry and #var1 > 0 and not tbl21.videoIsMoment then
        tbl22.videoIsMoment_arr = table.concat(var1, ",")
    end

    if #tbl16 > 0 then
        tbl22.tileBadgeContexts = table.concat(tbl16, ",")
    end

    if tbl17 and #tbl17 > 0 then
        tbl22.footerTextLiterals = table.concat(tbl17, ",")
    end

    if tbl18 and #tbl18 > 0 then
        tbl22.footerLocalizationKeys = table.concat(tbl18, ",")
    end

    if #tbl19 > 0 then
        tbl22.tileTypes = table.concat(tbl19, ",")
    end

    local tbl23 = {}

    if next(tbl21) then
        for value in tbl21 do
            local tbl24 = {}
            for _, value2 in tbl20 do
                table.insert(tbl24, value2[value] or "0")
            end
            tbl23[`{value}_arr`] = table.concat(tbl24, ",")
        end
    end

    local analyticsData = Cryo.Dictionary.join(tbl23, tbl3 or {})

    if next(analyticsData) then
        tbl22.analyticsData = analyticsData
    end

    return tbl22, num1
end

local function addMobileAdvertisingIdToEventParams(arg1) -- Luacid: Inlined by compiler; 4 call sites recovered
    local mobileAdvertisingId = AppStorageService:GetItem("MobileAdvertisingId")
    if mobileAdvertisingId and mobileAdvertisingId ~= "" then
        arg1.mobileAdvertisingId = mobileAdvertisingId
    end
end

local function hasNoEntries(arg1): boolean -- Luacid: Inlined by compiler; 3 call sites recovered
    if FFlagSduiFixSearchTelemetry then
        return not arg1 or next(arg1) == nil
    end

    return not arg1 or #arg1 == 0
end

return {
    sendFromTopicContents = function(arg1, arg2, tbl1, arg3, pageContext: string, gameSetTypeId: string, sortPos: number, num1: number?, gameSetTargetId: number?, pageId: string?, num2: number?, bool1: boolean?, componentType: string?, appliedFilters: string?, loadSource: string?, callback: ((...any) -> (...any))?, sortSubId: string?, tbl2)
        if not (arg1 and arg2) then
            if callback then
                callback(`Missing analytics service eventIngest: {arg1} appAnalytics: {arg2}`)
            end

            return
        end

        if not tbl1 or #tbl1 == 0 then
            if callback then
                callback(`Missing impressionsToSend or impressionsToSend == 0 {tbl1}`)
            end

            return
        end

        if hasNoEntries(arg3) then
            if callback then
                callback(`Missing topicContentsEntries or topicContentsEntries == 0 {arg3}`)
            end

            return
        end

        if FFlagLuaAppSponsoredGamePreviewVideo then
            logSponsoredGamePreviewVideoExposureIfEligible(tbl1, arg3, pageContext)
        end

        if num1 then
            LoggingProtocol.default:logRobloxTelemetryCounter(FeedItemRowDataHitCounter)
        else
            LoggingProtocol.default:logRobloxTelemetryCounter(FeedItemRowDataMissingCounter)
        end

        local tbl3, num3 = addGameFields(tbl1, arg3, num2, bool1, num1, gameSetTypeId, tbl2)

        local var1 = Cryo.Dictionary.join(tbl3, {
            sortPos = sortPos,
            gameSetTypeId = gameSetTypeId,
            gameSetTargetId = gameSetTargetId,
            pageId = pageId,
            componentType = componentType,
            locale = LocalizationService.RobloxLocaleId,
            appliedFilters = appliedFilters,
            loadSource = loadSource,
            sortSubId = sortSubId
        })

        if FFlagLuaAppGameImpressionsMobileAdsId then
            addMobileAdvertisingIdToEventParams(var1)
        end

        gameImpressionsEvent(arg1, pageContext, var1)
        reportGameImpressionCounts(arg2, pageContext, num3)
    end,
    sendFromSearch = function(arg1, arg2, tbl1, arg3, pageContext: string, arg4, arg5, arg6, bool1: boolean?, componentType: string?)
        if not arg1 or not arg2 or not tbl1 or #tbl1 == 0 or hasNoEntries(arg3) then
            return
        end

        local tbl2, num1 = addGameFields(tbl1, arg3, arg5, bool1, arg6, nil, nil, arg4, pageContext)

        local var1 = Cryo.Dictionary.join(tbl2, arg4, { locale = LocalizationService.RobloxLocaleId, componentType = componentType })

        if FFlagLuaAppGameImpressionsMobileAdsId then
            addMobileAdvertisingIdToEventParams(var1)
        end

        gameImpressionsEvent(arg1, pageContext, var1)
        reportGameImpressionCounts(arg2, pageContext, num1)
    end,
    sendFromGameDetails = function(arg1, arg2, tbl1, arg3, refId)
        local tbl2, num1 = addGameFields(tbl1, arg3)
        tbl2.locale = LocalizationService.RobloxLocaleId
        tbl2.refId = refId

        if FFlagLuaAppGameImpressionsMobileAdsId then
            addMobileAdvertisingIdToEventParams(tbl2)
        end

        gameImpressionsEvent(arg1, "recommended", tbl2)
        reportGameImpressionCounts(arg2, "recommended", num1)
    end,
    sendFromSeeAll = function(arg1, arg2, tbl1, arg3, pageContext: string, gameSetTypeId: string, gameSetTargetId: number?, pageId: string?, appliedFilters: string?, bool1: boolean?)
        if not arg1 or not arg2 or not tbl1 or #tbl1 == 0 or hasNoEntries(arg3) then
            return
        end

        if FFlagLuaAppSponsoredGamePreviewVideo then
            logSponsoredGamePreviewVideoExposureIfEligible(tbl1, arg3, pageContext)
        end

        local tbl2, num1 = addGameFields(tbl1, arg3, nil, bool1)

        local var1 = Cryo.Dictionary.join(tbl2, {
            gameSetTypeId = gameSetTypeId,
            gameSetTargetId = gameSetTargetId,
            pageId = pageId,
            locale = LocalizationService.RobloxLocaleId,
            seeAllFlag = 1,
            appliedFilters = appliedFilters
        })

        if FFlagLuaAppGameImpressionsMobileAdsId then
            addMobileAdvertisingIdToEventParams(var1)
        end

        gameImpressionsEvent(arg1, pageContext, var1)
        reportGameImpressionCounts(arg2, pageContext, num1, 1)
    end,
    sendFromTraversalHistoryPage = FFlagTraversalHistoryDiscoveryTelemetry and function(arg1, arg2, tbl1, tbl2, num1: number, num2: number)
        if not (arg1 and arg2) then
            return
        end

        local tbl3, num3 = addGameFields(tbl1, tbl2, num1, false, num2)
        local var1 = Cryo.Dictionary.join(tbl3, { locale = LocalizationService.RobloxLocaleId })

        gameImpressionsEvent(arg1, "InExpHistoryPage", var1)
        reportGameImpressionCounts(arg2, "InExpHistoryPage", num3)
    end or nil
}
