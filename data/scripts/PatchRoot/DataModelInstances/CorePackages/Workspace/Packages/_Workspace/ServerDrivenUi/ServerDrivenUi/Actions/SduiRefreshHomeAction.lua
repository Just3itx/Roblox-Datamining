-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T13:10:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ServerDrivenUiParent = script:FindFirstAncestor("ServerDrivenUi").Parent

local refreshHomePage = require(ServerDrivenUiParent.Home).refreshHomePage
local SduiCoreSystem = require(ServerDrivenUiParent.SduiCoreSystem)
local SduiActionType = SduiCoreSystem.SduiActionType
local SduiErrorType = SduiCoreSystem.SduiErrors.SduiErrorType

local function reportInvalidActionParams(arg1, message: string, propName: string?) -- Luacid: Inlined by compiler; 1 call site recovered
    arg1.dependencies.logger.reportError(
        SduiErrorType.InvalidActionParams,
        {
            name = SduiActionType.RefreshHome,
            message = message,
            propName = propName
        },
        arg1.appPage
    )
end

local function SduiRefreshHomeAction(arg1, _, arg2)
    local actionParams = if arg1 then arg1.actionParams or nil else nil
    local requestIntent = if actionParams then actionParams.requestIntent else nil

    if requestIntent ~= nil and (typeof(requestIntent) ~= "string" or requestIntent == "") then
        reportInvalidActionParams(arg2, `Invalid requestIntent: {tostring(requestIntent)}`, "requestIntent")
        requestIntent = nil
    end

    return refreshHomePage(requestIntent)
end

return SduiRefreshHomeAction
