-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T13:11:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ServerDrivenUiParent = script:FindFirstAncestor("ServerDrivenUi").Parent

local EdpStoreAnalytics = require(ServerDrivenUiParent.EdpStoreAnalytics)
local EdpStoreAnalyticsLogger = EdpStoreAnalytics.EdpStoreAnalyticsLogger
local StoreEnums = EdpStoreAnalytics.Constants.StoreEnums

local getActionTelemetryFieldValue = require(ServerDrivenUiParent.SduiCoreSystem).getActionTelemetryFieldValue

local function SduiEdpStoreItemClickTelemetryHandler(arg1, arg2, _)
    local actionTelemetryFieldValue = getActionTelemetryFieldValue(arg1, arg2, "productType")
    if actionTelemetryFieldValue == nil then
        return
    end

    local actionTelemetryFieldValue2 = getActionTelemetryFieldValue(arg1, arg2, "edpLocationType")
    local actionTelemetryFieldValue3 = getActionTelemetryFieldValue(arg1, arg2, "universeId")
    local actionTelemetryFieldValue4 = getActionTelemetryFieldValue(arg1, arg2, "productId")

    EdpStoreAnalyticsLogger.logEvent(
        StoreEnums.ActionType.ItemClick,
        actionTelemetryFieldValue,
        actionTelemetryFieldValue2,
        tonumber(actionTelemetryFieldValue3),
        tonumber(actionTelemetryFieldValue4),
        tostring(actionTelemetryFieldValue4)
    )
end

return SduiEdpStoreItemClickTelemetryHandler
