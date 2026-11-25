-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T13:11:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ServerDrivenUiParent = script:FindFirstAncestor("ServerDrivenUi").Parent

local sendOpenLeavingRobloxModalEvent = require(ServerDrivenUiParent.DiscoveryAnalytics).Events.sendOpenLeavingRobloxModalEvent

local SduiCoreSystem = require(ServerDrivenUiParent.SduiCoreSystem)
local SduiErrorType = SduiCoreSystem.SduiErrors.SduiErrorType
local getActionTelemetryFieldValue = SduiCoreSystem.getActionTelemetryFieldValue

local tbl1 = {
    "assignmentId",
    "assignmentType",
    "socialLinkType",
    "socialLinkDisplayType"
}
return function(arg1, arg2, arg3)
    local tbl2 = {}
    for _, value in tbl1 do
        if getActionTelemetryFieldValue(arg1, arg2, value) == nil then
            table.insert(tbl2, value)
        end
    end

    if #tbl2 > 0 then
        arg3.dependencies.logger.reportError(
            SduiErrorType.InvalidActionParams,
            {
                name = "LeavingRobloxTelemetryHandler",
                message = `Missing telemetry fields: {table.concat(tbl2, ", ")}`
            },
            arg3.appPage
        )
    end
    sendOpenLeavingRobloxModalEvent({
        assignment_id = tonumber(getActionTelemetryFieldValue(arg1, arg2, "assignmentId", 0)) or 0,
        assignment_type = getActionTelemetryFieldValue(arg1, arg2, "assignmentType", ""),
        social_link_type = getActionTelemetryFieldValue(arg1, arg2, "socialLinkType", ""),
        social_link_display_type = getActionTelemetryFieldValue(arg1, arg2, "socialLinkDisplayType", "")
    })
end
