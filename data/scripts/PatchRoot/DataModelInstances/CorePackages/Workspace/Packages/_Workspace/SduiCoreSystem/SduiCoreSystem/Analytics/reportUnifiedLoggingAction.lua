-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T09:41:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiCoreSystem = script:FindFirstAncestor("SduiCoreSystem")
local SduiCoreSystemParent = SduiCoreSystem.Parent
local UnifiedLogging = require(SduiCoreSystemParent.UnifiedLogging)

local SduiCollectionAnalyticsBuilder = require(SduiCoreSystem.Analytics.SduiCollectionAnalyticsBuilder)
local _SduiBuilderTypes = require(SduiCoreSystem.SduiBuilderTypes)
local _SduiConfigTypes = require(SduiCoreSystem.SduiConfigTypes)
local SduiErrors = require(SduiCoreSystem.SduiErrors)

local function reportUnifiedLoggingAction(arg1, arg2, arg3)
    local collectionData = arg3.getCollectionData and arg3.getCollectionData() or nil

    local andValidateItemAnalyticsData = SduiCollectionAnalyticsBuilder.buildAndValidateItemAnalyticsData(
        arg1,
        arg3.analyticsData,
        arg3.ancestorAnalyticsData,
        nil,
        arg2.actionType,
        function(_: string?)
            if collectionData ~= nil then
                arg1.dependencies.logger.reportCounter(SduiErrors.SduiCounterName.LogActionInvalidItemData, { name = arg2.actionType })
            end
        end
    )

    assert(andValidateItemAnalyticsData, "itemAnalyticsData must exist")
    collectionData = collectionData or SduiCollectionAnalyticsBuilder.DUMMY_COLLECTION_DATA

    assert(collectionData, "collectionAnalyticsData must exist")

    UnifiedLogging.SendItemActionEvent.sendFromServerDrivenUi(
        arg1.dependencies.eventIngest,
        andValidateItemAnalyticsData,
        andValidateItemAnalyticsData.itemPosition,
        collectionData,
        arg1.appPage,
        collectionData.collectionId,
        collectionData.contentType,
        collectionData.itemsPerRow,
        collectionData.collectionPosition,
        collectionData.totalNumberOfItems,
        nil,
        arg2.actionType,
        arg2.actionParams,
        collectionData.startRowNumber
    )
end

return reportUnifiedLoggingAction
