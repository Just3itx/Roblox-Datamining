-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T10:50:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiSharedContentParent = script:FindFirstAncestor("SduiSharedContent").Parent

local SduiCoreSystem = require(SduiSharedContentParent.SduiCoreSystem)
local AppPage = require(SduiSharedContentParent.RobloxAppEnums).AppPage

local SduiErrorType = SduiCoreSystem.SduiErrors.SduiErrorType
local SduiActionType = SduiCoreSystem.SduiActionType

local getStringParam = SduiCoreSystem.SduiActionParams.getStringParam

local function SduiNavigateAction(arg1, _, arg2, _)
    local actionParams = arg1 and arg1.actionParams or nil
    if actionParams == nil then
        arg2.dependencies.logger.reportError(
            SduiErrorType.InvalidActionParams,
            {
                name = SduiActionType.Navigate,
                message = "Missing actionParams"
            },
            arg2.appPage
        )
        return
    end

    local stringParam = getStringParam(actionParams, "destination")
    if stringParam == nil then
        arg2.dependencies.logger.reportError(
            SduiErrorType.InvalidActionParams,
            {
                name = SduiActionType.Navigate,
                message = "Missing actionParam: destination",
                propName = "destination"
            },
            arg2.appPage
        )
        return
    end

    local var1 = AppPage[stringParam]
    if var1 ~= nil then
        arg2.dependencies.getNavigation().navigate(var1)
        return
    end

    arg2.dependencies.logger.reportError(
        SduiErrorType.InvalidActionParams,
        {
            name = SduiActionType.Navigate,
            message = `Unknown destination: {stringParam}`,
            propName = "destination"
        },
        arg2.appPage
    )
end

return SduiNavigateAction
