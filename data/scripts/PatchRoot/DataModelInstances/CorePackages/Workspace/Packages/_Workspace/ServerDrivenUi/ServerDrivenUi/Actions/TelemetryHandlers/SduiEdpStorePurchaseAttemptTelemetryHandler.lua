-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T13:11:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ServerDrivenUiParent = script:FindFirstAncestor("ServerDrivenUi").Parent

local EdpStoreAnalytics = require(ServerDrivenUiParent.EdpStoreAnalytics)
local EdpStoreAnalyticsLogger = EdpStoreAnalytics.EdpStoreAnalyticsLogger
local StoreEnums = EdpStoreAnalytics.Constants.StoreEnums

local ProductKind = require(ServerDrivenUiParent.PurchasePromptLite).Enums.ProductKind

local getActionTelemetryFieldValue = require(ServerDrivenUiParent.SduiCoreSystem).getActionTelemetryFieldValue

local tbl1 = {
    [ProductKind.Gamepass] = StoreEnums.ProductType.GamePasses,
    [ProductKind.DeveloperSubscription] = StoreEnums.ProductType.Subscriptions,
    [ProductKind.Product] = StoreEnums.ProductType.DeveloperProducts
}

return function(arg1, arg2, _)
    local actionTelemetryFieldValue = getActionTelemetryFieldValue(arg1, arg2, "kind")
    local var1 = actionTelemetryFieldValue and tbl1[actionTelemetryFieldValue]
    if var1 == nil then
        return
    end

    local actionTelemetryFieldValue2 = getActionTelemetryFieldValue(arg1, arg2, "edpLocationType")
    local actionTelemetryFieldValue3 = getActionTelemetryFieldValue(arg1, arg2, "universeId")
    local actionTelemetryFieldValue4 = getActionTelemetryFieldValue(arg1, arg2, "productId")

    EdpStoreAnalyticsLogger.logEvent(
        StoreEnums.ActionType.PurchaseAttemptClick,
        var1,
        actionTelemetryFieldValue2,
        tonumber(actionTelemetryFieldValue3),
        tonumber(actionTelemetryFieldValue4),
        tostring(actionTelemetryFieldValue4)
    )
end
