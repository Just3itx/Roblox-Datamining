-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T13:00:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ServerDrivenUiParent = script:FindFirstAncestor("ServerDrivenUi").Parent
local CloseCentralOverlay = require(ServerDrivenUiParent.CentralOverlay).Thunks.CloseCentralOverlay

local SduiCoreSystem = require(ServerDrivenUiParent.SduiCoreSystem)
local SduiErrorType = SduiCoreSystem.SduiErrors.SduiErrorType
local SduiActionType = SduiCoreSystem.SduiActionType

return function(arg1, _, arg2, _)
    local actionParams = arg1 and arg1.actionParams or nil
    if actionParams == nil then
        arg2.dependencies.logger.reportError(
            SduiErrorType.InvalidActionParams,
            {
                name = SduiActionType.DismissDialog,
                message = "Missing actionParams"
            },
            arg2.appPage
        )
        return
    end

    assert(actionParams, "actionParams must exist")
    if actionParams.dialogType == "centralOverlay" then
        arg2.dependencies.dispatch(CloseCentralOverlay())
    end
end
