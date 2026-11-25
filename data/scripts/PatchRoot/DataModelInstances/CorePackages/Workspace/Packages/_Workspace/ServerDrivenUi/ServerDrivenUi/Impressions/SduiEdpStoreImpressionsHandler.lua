-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T13:31:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ServerDrivenUi = script:FindFirstAncestor("ServerDrivenUi")
local ServerDrivenUiParent = ServerDrivenUi.Parent

local EdpStoreAnalytics = require(ServerDrivenUiParent.EdpStoreAnalytics)
local EdpStoreAnalyticsLogger = EdpStoreAnalytics.EdpStoreAnalyticsLogger
local StoreEnums = EdpStoreAnalytics.Constants.StoreEnums

local SduiCoreSystem = require(ServerDrivenUiParent.SduiCoreSystem)
local SduiErrors = SduiCoreSystem.SduiErrors
local SduiLogger = SduiCoreSystem.SduiLogger
local findAnalyticsFieldInAncestors = SduiCoreSystem.findAnalyticsFieldInAncestors

local SduiMarketplaceItemImpressionsHandler = require(ServerDrivenUi.Impressions.SduiMarketplaceItemImpressionsHandler)

local function SduiEdpStoreImpressionsHandler(arg1, tbl1, tbl2, analyticsData, num1: number?, str1: string?)
    if SduiMarketplaceItemImpressionsHandler(arg1, tbl1, tbl2, analyticsData, num1, str1) == 0 then
        return
    end

    local tbl3 = { analyticsData = analyticsData }
    local productType = findAnalyticsFieldInAncestors("itemType", tbl3)
    local locationType = findAnalyticsFieldInAncestors("edpLocationType", tbl3)
    local analyticsFieldInAncestors3 = findAnalyticsFieldInAncestors("universeId", tbl3)
    local universeId = if analyticsFieldInAncestors3 == nil then nil else tonumber(analyticsFieldInAncestors3)

    if not productType then
        SduiLogger.reportError(
            SduiErrors.SduiErrorType.FailedToLogExperienceStoreImpressions,
            {
                name = "SduiEdpStoreImpressionsHandler",
                message = "Missing itemType on collectionAnalyticsData"
            },
            arg1.appPage
        )
        return
    end

    for _, value in tbl1 do
        if tbl2[value] == nil then
            continue
        end

        local layoutOrder = (num1 or 0) + value

        EdpStoreAnalyticsLogger.logImpression({
            actionType = StoreEnums.ActionType.Impression,
            productType = productType,
            locationType = locationType,
            universeId = universeId,
            layoutOrder = layoutOrder
        })
    end

    EdpStoreAnalyticsLogger.logExperienceStoreExposure()
end

return SduiEdpStoreImpressionsHandler
