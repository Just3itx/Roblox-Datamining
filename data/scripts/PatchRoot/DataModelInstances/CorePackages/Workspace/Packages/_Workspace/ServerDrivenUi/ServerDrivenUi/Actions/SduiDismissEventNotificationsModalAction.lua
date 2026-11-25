-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T13:01:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ServerDrivenUiParent = script:FindFirstAncestor("ServerDrivenUi").Parent

local SduiCoreSystem = require(ServerDrivenUiParent.SduiCoreSystem)
local VirtualEvents = require(ServerDrivenUiParent.VirtualEvents)
local CloseCentralOverlay = require(ServerDrivenUiParent.CentralOverlay).Thunks.CloseCentralOverlay

local SduiErrorType = SduiCoreSystem.SduiErrors.SduiErrorType
local SduiParseHelpers = SduiCoreSystem.SduiParseHelpers

local function SduiDismissEventNotificationsModalAction(arg1, _, arg2)
    local actionParams = arg1 and arg1.actionParams or nil
    if actionParams == nil then
        arg2.dependencies.logger.reportError(
            SduiErrorType.InvalidActionParams,
            { name = "DismissEventNotificationsModal", message = "Missing actionParams" },
            arg2.appPage
        )
        return
    end

    assert(actionParams, "actionParams must exist")

    if actionParams.eventId == nil then
        arg2.dependencies.logger.reportError(
            SduiErrorType.InvalidActionParams,
            {
                name = "DismissEventNotificationsModal",
                message = "Missing eventId",
                propName = "eventId"
            },
            arg2.appPage
        )
    end
    local networking = arg2.dependencies.networking

    VirtualEvents.neverShowNotificationsModalAgain(networking):catch(function(arg3)
        arg2.dependencies.logger.reportError(SduiErrorType.ActionNetworkRequestFailed, {
            name = "DismissEventNotificationsModal",
            message = "neverShowNotificationsModalAgain failed: " .. SduiParseHelpers.stringifyValue(arg3)
        }, arg2.appPage)
    end)

    arg2.dependencies.dispatch(CloseCentralOverlay())
end

return SduiDismissEventNotificationsModalAction
