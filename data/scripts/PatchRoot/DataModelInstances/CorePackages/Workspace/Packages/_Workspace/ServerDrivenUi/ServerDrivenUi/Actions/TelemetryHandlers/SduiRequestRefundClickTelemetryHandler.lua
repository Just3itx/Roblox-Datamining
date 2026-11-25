-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T13:11:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ServerDrivenUiParent = script:FindFirstAncestor("ServerDrivenUi").Parent
local t = require(ServerDrivenUiParent.t)
local sendRequestRefundClickEvent = require(ServerDrivenUiParent.DiscoveryAnalytics).Events.sendRequestRefundClickEvent

local SduiCoreSystem = require(ServerDrivenUiParent.SduiCoreSystem)
local SduiErrorType = SduiCoreSystem.SduiErrors.SduiErrorType
local getActionTelemetryFieldValue = SduiCoreSystem.getActionTelemetryFieldValue

local var1 = t.strictInterface({ placeId = t.union(t.string, t.number), eventContext = t.string })

return function(arg1, arg2, arg3)
    local placeId = getActionTelemetryFieldValue(arg1, arg2, "placeId")
    local eventContext = getActionTelemetryFieldValue(arg1, arg2, "eventContext")

    local var2, message = var1({ placeId = placeId, eventContext = eventContext })

    if not var2 then
        arg3.dependencies.logger.reportError(
            SduiErrorType.InvalidActionParams,
            { name = "SduiRequestRefundClickTelemetryHandler", message = message },
            arg3.appPage
        )
    end
    sendRequestRefundClickEvent(
        {
            placeId = if placeId then tostring(placeId) else ""
        },
        if eventContext then tostring(eventContext) else ""
    )
end
