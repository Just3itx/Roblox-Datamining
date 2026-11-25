-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T13:01:28Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ServerDrivenUiParent = script:FindFirstAncestor("ServerDrivenUi").Parent
local SduiCoreSystem = require(ServerDrivenUiParent.SduiCoreSystem)
local SduiActionType = SduiCoreSystem.SduiActionType
local SduiErrorType = SduiCoreSystem.SduiErrors.SduiErrorType

local CentralOverlayType = require(ServerDrivenUiParent.RobloxAppEnums).CentralOverlayType
local SetCentralOverlay = require(ServerDrivenUiParent.CentralOverlay).Actions.SetCentralOverlay

local function SduiOpenSduiOverlayAction(arg1, _, arg2)
    local actionParams = arg1 and arg1.actionParams or nil
    if actionParams == nil then
        arg2.dependencies.logger.reportError(
            SduiErrorType.InvalidActionParams,
            {
                name = SduiActionType.OpenSduiOverlay,
                message = "Missing actionParams"
            },
            arg2.appPage
        )
        return
    end

    assert(actionParams, "actionParams must exist")
    local configKey = actionParams.configKey
    local identifier = actionParams.identifier

    if not configKey then
        arg2.dependencies.logger.reportError(
            SduiErrorType.InvalidActionParams,
            {
                name = SduiActionType.OpenSduiOverlay,
                message = "Missing configKey in action params"
            },
            arg2.appPage
        )
        return
    end

    if not identifier then
        arg2.dependencies.logger.reportError(
            SduiErrorType.InvalidActionParams,
            {
                name = SduiActionType.OpenSduiOverlay,
                message = "Missing identifier in action params"
            },
            arg2.appPage
        )
    else
        arg2.dependencies.dispatch(
            SetCentralOverlay(
                CentralOverlayType.SduiOverlay,
                {
                    configKey = configKey,
                    identifier = identifier,
                    appPage = arg2.appPage
                }
            )
        )
    end
end

return SduiOpenSduiOverlayAction
