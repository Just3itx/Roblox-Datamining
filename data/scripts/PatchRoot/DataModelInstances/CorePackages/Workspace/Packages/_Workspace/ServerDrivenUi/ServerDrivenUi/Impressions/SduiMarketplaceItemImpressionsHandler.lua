-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T13:31:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ServerDrivenUi = script:FindFirstAncestor("ServerDrivenUi")
local ServerDrivenUiParent = ServerDrivenUi.Parent

local AvatarExperienceAnalytics = require(ServerDrivenUiParent.AvatarExperienceAnalytics)
local AXUnifiedEventFilter = AvatarExperienceAnalytics.AXUnifiedEventFilter
local UnifiedEventLogEnums = AvatarExperienceAnalytics.UnifiedEventLogEnums
local sendUnifiedEventLog = AvatarExperienceAnalytics.sendUnifiedEventLog
local sendPassthroughUnifiedEventLog = AvatarExperienceAnalytics.sendPassthroughUnifiedEventLog
local UnifiedEventLoggingUtils = AvatarExperienceAnalytics.Utils.UnifiedEventLoggingUtils
local FFlagAXUnifiedEventCounters = AvatarExperienceAnalytics.Flags.FFlagAXUnifiedEventCounters
local FFlagAXUnifiedEventStrictPayloads = AvatarExperienceAnalytics.Flags.FFlagAXUnifiedEventStrictPayloads
local UnifiedLoggingSurface = require(ServerDrivenUiParent.AvatarExperienceNavigation).Enums.UnifiedLoggingSurface

local SduiCoreSystem = require(ServerDrivenUiParent.SduiCoreSystem)
local SduiErrors = SduiCoreSystem.SduiErrors
local SduiLogger = SduiCoreSystem.SduiLogger
local findAnalyticsFieldInAncestors = SduiCoreSystem.findAnalyticsFieldInAncestors

local findCollectionItemInstances = require(ServerDrivenUi.Analytics.findCollectionItemInstances)

local tbl1 = {}

local MarketplaceUnifiedAction = UnifiedEventLogEnums.MarketplaceUnifiedAction
local MarketplaceUnifiedItemType = UnifiedEventLogEnums.MarketplaceUnifiedItemType

local function gridPosition(num1: number, num2: number?) -- Luacid: Inlined by compiler; 1 call site recovered
    if not num2 or num2 <= 0 then
        return 1, num1
    end
    return math.ceil(num1 / num2), (num1 - 1) % num2 + 1
end

local function SduiMarketplaceItemImpressionsHandler(arg1, tbl2, tbl3, analyticsData, num1: number?, str1: string?)
    if #tbl2 == 0 or #(tbl3 or tbl1) == 0 then
        SduiLogger.reportError(SduiErrors.SduiErrorType.FailedToLogMarketplaceItemImpressions, {
            name = "SduiMarketplaceItemImpressionsHandler",
            message = `No entries to log: impressionIndexes={#tbl2}, itemAnalyticsDatas={#(tbl3 or tbl1)}`
        }, arg1.appPage)
        return 0
    end

    local tbl4 = { analyticsData = analyticsData }
    local analyticsFieldInAncestors = findAnalyticsFieldInAncestors("surface", tbl4)
    local analyticsFieldInAncestors2 = findAnalyticsFieldInAncestors("itemType", tbl4)
    local analyticsFieldInAncestors3 = findAnalyticsFieldInAncestors("universeId", tbl4)
    local analyticsFieldInAncestors4 = findAnalyticsFieldInAncestors("itemsPerRow", tbl4)
    local universeId = if analyticsFieldInAncestors3 == nil then nil else tonumber(analyticsFieldInAncestors3)
    local var2 = if analyticsFieldInAncestors4 == nil then nil else tonumber(analyticsFieldInAncestors4)
    local surface = if analyticsFieldInAncestors == nil then nil else UnifiedLoggingSurface[analyticsFieldInAncestors]
    local itemType = if analyticsFieldInAncestors2 == nil then nil else MarketplaceUnifiedItemType[analyticsFieldInAncestors2]

    if not surface then
        SduiLogger.reportError(SduiErrors.SduiErrorType.FailedToLogMarketplaceItemImpressions, {
            name = "SduiMarketplaceItemImpressionsHandler",
            message = `Missing or unknown surface on analytics data: {tostring(analyticsFieldInAncestors)}`
        }, arg1.appPage)
        return 0
    end
    if not itemType then
        SduiLogger.reportError(SduiErrors.SduiErrorType.FailedToLogMarketplaceItemImpressions, {
            name = "SduiMarketplaceItemImpressionsHandler",
            message = `Missing or unknown itemType on analytics data: {tostring(analyticsFieldInAncestors2)}`
        }, arg1.appPage)
        return 0
    end

    local collectionItemInstances = findCollectionItemInstances(str1)
    local num2 = 0

    for _, value in tbl2 do
        local var5 = tbl3[value]
        if var5 == nil then
            continue
        end

        local gridPositionRow, gridPositionColumn = gridPosition((num1 or 0) + value, var2)

        if FFlagAXUnifiedEventStrictPayloads then
            local var6 = collectionItemInstances[value]
            local screenSize = if var6 then UnifiedEventLoggingUtils.getScreenSize(var6) else nil
            local elementSizeAndPosition = if var6 then UnifiedEventLoggingUtils.getElementSizeAndPosition(var6) else nil
            local tbl5 = {
                action = MarketplaceUnifiedAction.ITEM_IMPRESSION,
                surface = surface,
                itemType = itemType,
                itemId = var5.id,
                universeId = universeId,
                gridPositionRow = gridPositionRow,
                gridPositionColumn = gridPositionColumn,
                screenSizeWidth = if screenSize then screenSize.screenSizeWidth else nil,
                screenSizeHeight = if screenSize then screenSize.screenSizeHeight else nil,
                elementSizeWidth = if elementSizeAndPosition then elementSizeAndPosition.elementSizeWidth else nil,
                elementSizeHeight = if elementSizeAndPosition then elementSizeAndPosition.elementSizeHeight else nil,
                elementCoordinatesX = if elementSizeAndPosition then elementSizeAndPosition.elementCoordinatesX else nil,
                elementCoordinatesY = if elementSizeAndPosition then elementSizeAndPosition.elementCoordinatesY else nil,
                elementRelativePositionX = if elementSizeAndPosition then elementSizeAndPosition.elementRelativePositionX else nil,
                elementRelativePositionY = if elementSizeAndPosition then elementSizeAndPosition.elementRelativePositionY else nil
            }

            local var7 = nil
            if FFlagAXUnifiedEventCounters then
                var7 = AXUnifiedEventFilter.filter(tbl5)
            else
                AXUnifiedEventFilter.filter(tbl5)
            end

            sendPassthroughUnifiedEventLog(tbl5, nil, FFlagAXUnifiedEventCounters and { filterPassed = var7 } or nil)

            num2 += 1
        else
            local tbl5 = {
                action = MarketplaceUnifiedAction.ITEM_IMPRESSION,
                surface = surface,
                itemType = itemType,
                itemId = var5.id,
                universeId = universeId,
                gridPositionRow = gridPositionRow,
                gridPositionColumn = gridPositionColumn
            }
            local var6 = collectionItemInstances[value]
            if var6 then
                for value2, value3 in (UnifiedEventLoggingUtils.getScreenSize(var6)) do
                    tbl5[value2] = value3
                end
                for value2, value3 in (UnifiedEventLoggingUtils.getElementSizeAndPosition(var6)) do
                    tbl5[value2] = value3
                end
            end

            local var7 = nil
            if FFlagAXUnifiedEventCounters then
                var7 = AXUnifiedEventFilter.filter(tbl5)
            else
                AXUnifiedEventFilter.filter(tbl5)
            end
            sendUnifiedEventLog(tbl5, nil, FFlagAXUnifiedEventCounters and { filterPassed = var7 } or nil)

            num2 += 1
        end
    end
    if num2 == 0 then
        SduiLogger.reportError(
            SduiErrors.SduiErrorType.FailedToLogMarketplaceItemImpressions,
            {
                name = "SduiMarketplaceItemImpressionsHandler",
                message = "No valid items found for impression indexes"
            },
            arg1.appPage
        )
    end
    return num2
end

return SduiMarketplaceItemImpressionsHandler
