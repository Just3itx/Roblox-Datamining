-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T09:41:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiCoreSystem = script:FindFirstAncestor("SduiCoreSystem")
local SduiCoreSystemParent = SduiCoreSystem.Parent
local FFlagSduiErrorPaths = require(SduiCoreSystemParent.SharedFlags).FFlagSduiErrorPaths
local Cryo = require(SduiCoreSystemParent.Cryo)
local UnifiedLogging = require(SduiCoreSystemParent.UnifiedLogging)

local _SduiBuilderTypes = require(SduiCoreSystem.SduiBuilderTypes)
local _SduiComponentType = require(SduiCoreSystem.SduiComponentType)
local _SduiConfigTypes = require(SduiCoreSystem.SduiConfigTypes)

local SduiErrors = require(SduiCoreSystem.SduiErrors)
local addSduiErrorContextFields = require(SduiCoreSystem.addSduiErrorContextFields)
local validateInterface = require(SduiCoreSystem.validateInterface)
local analyticsConstants = require(SduiCoreSystem.Analytics.analyticsConstants)

local FFlagSduiSkipFeedAnalyticsPosition = require(SduiCoreSystemParent.SharedFlags).FFlagSduiSkipFeedAnalyticsPosition

local tbl1 = {}

local var1 = FFlagSduiSkipFeedAnalyticsPosition and function(tbl2)
    tbl2[analyticsConstants.DoesNotAdvanceStartRow] = nil
end or nil

local DUMMY_ITEM_DATA = { index = -1, id = "unknown", itemComponentType = "unknown" }

local DUMMY_COLLECTION_DATA = {
    collectionId = -1,
    contentType = "unknown",
    itemsPerRow = -1,
    collectionPosition = -1,
    totalNumberOfItems = -1,
    startRowNumber = -1,
    collectionComponentType = "unknown",
    refId = "unknown"
}

return {
    buildAndValidateCollectionAnalyticsData = function(arg1, tbl4, tbl5, arg2, itemsPerRow: number, totalNumberOfItems: number, _: number?, name: string, startRowNumber: number?)
        local var2 = Cryo.Dictionary.join(tbl4 or tbl1, tbl5 or tbl1)
        if FFlagSduiSkipFeedAnalyticsPosition then
            var1(var2)
        end
        local collectionId = var2.collectionId
        var2.collectionId = tonumber(collectionId) or var2.collectionId
        local collectionPosition = var2.collectionPosition
        var2.collectionPosition = tonumber(collectionPosition)
        var2.itemsPerRow = itemsPerRow
        var2.startRowNumber = startRowNumber
        var2.totalNumberOfItems = totalNumberOfItems
        var2.collectionComponentType = arg2
        local collectionAnalyticsDataInterface = UnifiedLogging.SduiAnalyticsTypes.CollectionAnalyticsDataInterface
        local var3, message = validateInterface(var2, collectionAnalyticsDataInterface, true)
        if not var3 then
            arg1.dependencies.logger.reportError(
                SduiErrors.SduiErrorType.InvalidCollectionAnalyticsData,
                { componentType = arg2, name = name, message = message },
                arg1.appPage
            )
            var2 = Cryo.Dictionary.join(DUMMY_COLLECTION_DATA, var2)
        end
        return var2
    end,
    buildAndValidateItemAnalyticsData = function(arg1, tbl4, tbl5, tbl6, name: string, callback: ((...any) -> (...any))?, arg2)
        local var2 = Cryo.Dictionary.join(tbl5 or tbl1, tbl4 or tbl1, tbl6 or tbl1)
        if FFlagSduiSkipFeedAnalyticsPosition then
            var1(var2)
        end

        local itemAnalyticsDataInterface = UnifiedLogging.SduiAnalyticsTypes.ItemAnalyticsDataInterface
        local var3, message = validateInterface(var2, itemAnalyticsDataInterface, true)
        if not var3 then
            if callback then
                callback(message)
            else
                local tbl7 = { name = name, message = message }

                if FFlagSduiErrorPaths then
                    addSduiErrorContextFields(tbl7, arg2)
                end
                arg1.dependencies.logger.reportError(SduiErrors.SduiErrorType.InvalidItemAnalyticsData, tbl7, arg1.appPage)
            end

            var2 = Cryo.Dictionary.join(DUMMY_ITEM_DATA, var2)
        end
        return var2
    end,
    DUMMY_COLLECTION_DATA = DUMMY_COLLECTION_DATA,
    DUMMY_ITEM_DATA = DUMMY_ITEM_DATA
}
