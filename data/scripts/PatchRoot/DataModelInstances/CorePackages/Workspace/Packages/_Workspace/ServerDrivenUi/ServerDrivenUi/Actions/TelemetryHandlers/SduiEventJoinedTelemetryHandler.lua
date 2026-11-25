-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T13:11:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ServerDrivenUiParent = script:FindFirstAncestor("ServerDrivenUi").Parent

local VirtualEvents = require(ServerDrivenUiParent.VirtualEvents)

local SduiCoreSystem = require(ServerDrivenUiParent.SduiCoreSystem)
local SduiErrorType = SduiCoreSystem.SduiErrors.SduiErrorType
local getActionTelemetryFieldValue = SduiCoreSystem.getActionTelemetryFieldValue

return function(arg1, arg2, arg3)
    local virtualEventId = getActionTelemetryFieldValue(arg1, arg2, "eventId")
    if virtualEventId == nil then
        arg3.dependencies.logger.reportError(
            SduiErrorType.InvalidActionParams,
            { name = "EventJoined", message = "Missing eventId for EventJoined telemetry" },
            arg3.appPage
        )
        return
    end

    local actionTelemetryFieldValue2 = getActionTelemetryFieldValue(arg1, arg2, "universeId", "")
    local actionTelemetryFieldValue3 = getActionTelemetryFieldValue(arg1, arg2, "channel", "")

    VirtualEvents.fireVirtualEventJoined({
        virtualEventId = virtualEventId,
        universeId = tostring(actionTelemetryFieldValue2),
        channel = tostring(actionTelemetryFieldValue3)
    })
end
