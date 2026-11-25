-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T09:41:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiCoreSystem = script:FindFirstAncestor("SduiCoreSystem")
local SduiCoreSystemParent = SduiCoreSystem.Parent
local UnifiedLogging = require(SduiCoreSystemParent.UnifiedLogging)

local SduiCollectionAnalyticsBuilder = require(SduiCoreSystem.Analytics.SduiCollectionAnalyticsBuilder)
local _SduiBuilderTypes = require(SduiCoreSystem.SduiBuilderTypes)
local _SduiConfigTypes = require(SduiCoreSystem.SduiConfigTypes)
local SduiErrors = require(SduiCoreSystem.SduiErrors)
local getSduiImpressionHandlerRegistry = require(SduiCoreSystem.getSduiImpressionHandlerRegistry)
local _SduiImpressionEventType = require(SduiCoreSystem.SduiImpressionEventType)

local function reportUnifiedLoggingImpressions(arg1, tbl1, tbl2, arg2, num1: number?, str1: string?, bool1: boolean?, str2: string?)
    if not arg2 then
        arg1.dependencies.logger.reportError(SduiErrors.SduiErrorType.LogImpressionsMissingCollectionData, {}, arg1.appPage)
    end

    arg2 = arg2 or SduiCollectionAnalyticsBuilder.DUMMY_COLLECTION_DATA
    assert(arg2, "collectionAnalyticsData must exist")
    local var1

    if str1 then
        var1 = getSduiImpressionHandlerRegistry().getImpressionHandlerConfig(str1)

        if var1 then
            if var1.handler then
                var1.handler(arg1, tbl1, tbl2, arg2, num1, str2)
            end
        else
            UnifiedLogging.SendItemImpressions.sendFromServerDrivenUi(
                arg1.dependencies.eventIngest,
                tbl1,
                tbl2,
                arg2,
                arg1.appPage,
                arg2.collectionId,
                arg2.contentType,
                arg2.itemsPerRow,
                arg2.collectionPosition,
                num1,
                str1
            )
        end
    else
        var1 = nil
    end

    if bool1 ~= nil then
        if bool1 then
            return
        end
    elseif var1 and var1.skipItemImpressionsLog then
        return
    end

    UnifiedLogging.SendItemImpressions.sendFromServerDrivenUi(
        arg1.dependencies.eventIngest,
        tbl1,
        tbl2,
        arg2,
        arg1.appPage,
        arg2.collectionId,
        arg2.contentType,
        arg2.itemsPerRow,
        arg2.collectionPosition,
        num1
    )
end

return reportUnifiedLoggingImpressions
