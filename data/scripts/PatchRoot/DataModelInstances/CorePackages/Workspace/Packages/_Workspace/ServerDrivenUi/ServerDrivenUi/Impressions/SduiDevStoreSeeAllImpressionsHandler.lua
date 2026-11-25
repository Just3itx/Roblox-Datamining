-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T13:31:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ServerDrivenUi = script:FindFirstAncestor("ServerDrivenUi")
local ServerDrivenUiParent = ServerDrivenUi.Parent

local EdpStoreAnalytics = require(ServerDrivenUiParent.EdpStoreAnalytics)
local EdpStoreAnalyticsLogger = EdpStoreAnalytics.EdpStoreAnalyticsLogger
local StoreEnums = EdpStoreAnalytics.Constants.StoreEnums

local UnifiedEventLogEnums = require(ServerDrivenUiParent.AvatarExperienceAnalytics).UnifiedEventLogEnums

local SduiCoreSystem = require(ServerDrivenUiParent.SduiCoreSystem)
local SduiErrors = SduiCoreSystem.SduiErrors
local SduiLogger = SduiCoreSystem.SduiLogger
local findAnalyticsFieldInAncestors = SduiCoreSystem.findAnalyticsFieldInAncestors
local getSduiClientPageScope = SduiCoreSystem.getSduiClientPageScope
local FFlagSduiErrorPaths = require(ServerDrivenUiParent.SharedFlags).FFlagSduiErrorPaths

local SduiMarketplaceItemImpressionsHandler = require(ServerDrivenUi.Impressions.SduiMarketplaceItemImpressionsHandler)

local MarketplaceUnifiedItemType = UnifiedEventLogEnums.MarketplaceUnifiedItemType

local var1 = (setmetatable({}, { __mode = "k" }))

local function SduiDevStoreSeeAllImpressionsHandler(arg1, tbl1, tbl2, analyticsData, num1: number?, str1: string?)
    if #tbl1 == 0 then
        return
    end

    local tbl3 = { analyticsData = analyticsData }

    local analyticsFieldInAncestors = findAnalyticsFieldInAncestors("itemType", tbl3)

    if if analyticsFieldInAncestors == nil then nil else MarketplaceUnifiedItemType[analyticsFieldInAncestors] then
        SduiMarketplaceItemImpressionsHandler(arg1, tbl1, tbl2, analyticsData, num1, str1)
    end

    local productType = findAnalyticsFieldInAncestors("experienceStoreProductType", tbl3)
    if not productType then
        SduiLogger.reportError(SduiErrors.SduiErrorType.FailedToLogExperienceStoreImpressions, {
            name = "SduiDevStoreSeeAllImpressionsHandler",
            message = "Missing experienceStoreProductType on collectionAnalyticsData"
        }, arg1.appPage)
        return
    end

    local str2 = tostring(productType)
    local sduiClientPageScope = if FFlagSduiErrorPaths and arg1.configKey then getSduiClientPageScope(arg1.configKey) else nil
    local tbl4 = if sduiClientPageScope then sduiClientPageScope.get("devStoreSectionsFired") else var1[arg1]

    if not tbl4 then
        tbl4 = {}
        if sduiClientPageScope then
            sduiClientPageScope.set("devStoreSectionsFired", tbl4)
        else
            var1[arg1] = tbl4
        end
    end
    if tbl4[str2] then
        return
    end
    tbl4[str2] = true

    local locationType = findAnalyticsFieldInAncestors("edpLocationType", tbl3)
    local analyticsFieldInAncestors4 = findAnalyticsFieldInAncestors("universeId", tbl3)
    local var2 = if analyticsFieldInAncestors4 == nil then nil else tonumber(tostring(analyticsFieldInAncestors4))
    EdpStoreAnalyticsLogger.logImpression({
        actionType = StoreEnums.ActionType.Impression,
        productType = productType,
        locationType = locationType,
        universeId = var2,
        layoutOrder = 1
    })

    EdpStoreAnalyticsLogger.logExperienceStoreExposure()
end

return SduiDevStoreSeeAllImpressionsHandler
