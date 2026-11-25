-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T13:01:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ServerDrivenUiParent = script:FindFirstAncestor("ServerDrivenUi").Parent

local CentralOverlay = require(ServerDrivenUiParent.CentralOverlay)
local SetCentralOverlay = CentralOverlay.Actions.SetCentralOverlay
local CloseCentralOverlay = CentralOverlay.Thunks.CloseCentralOverlay
local CentralOverlayType = require(ServerDrivenUiParent.RobloxAppEnums).CentralOverlayType
local SduiCoreSystem = require(ServerDrivenUiParent.SduiCoreSystem)
local SduiActionType = SduiCoreSystem.SduiActionType
local SduiErrorType = SduiCoreSystem.SduiErrors.SduiErrorType
local FFlagSafetyResourceBannerTelemetry = require(ServerDrivenUiParent.SharedFlags).FFlagSafetyResourceBannerTelemetry
local SduiActionParams = SduiCoreSystem.SduiActionParams

local FFlagLuaAppSduiOpenExternalLinkSkipLeaveConfirmation = require(ServerDrivenUiParent.SharedFlags).FFlagLuaAppSduiOpenExternalLinkSkipLeaveConfirmation

return function(arg1, _, arg2, _)
    local actionParams = if arg1 then arg1.actionParams or nil else nil

    if actionParams == nil then
        arg2.dependencies.logger.reportError(
            SduiErrorType.InvalidActionParams,
            {
                name = SduiActionType.OpenExternalLink,
                message = "Missing actionParams"
            },
            arg2.appPage
        )
        return
    end

    assert(actionParams, "actionParams must exist")
    local url = actionParams.url
    if typeof(url) ~= "string" or url == "" then
        arg2.dependencies.logger.reportError(
            SduiErrorType.InvalidActionParams,
            {
                name = SduiActionType.OpenExternalLink,
                message = `Invalid or missing url: {url}`,
                propName = "url"
            },
            arg2.appPage
        )
        return
    end

    local dispatch = arg2.dependencies.dispatch
    local linkingProtocol = arg2.dependencies.linkingProtocol
    local onContinue = if FFlagSafetyResourceBannerTelemetry then actionParams.onContinue else nil

    local function openInBrowser() -- Luacid: Inlined by compiler; 2 call sites recovered
        linkingProtocol:openURL(url):catch(function(arg3)
            arg2.dependencies.logger.reportError(
                SduiErrorType.FailedToOpenLink,
                {
                    name = SduiActionType.OpenExternalLink,
                    message = if typeof(arg3) ~= "string" then "Unknown reason" else arg3
                },
                arg2.appPage
            )
        end)
    end

    if FFlagLuaAppSduiOpenExternalLinkSkipLeaveConfirmation
        and SduiActionParams.getBooleanParam(actionParams, "skipLeaveConfirmation", false)
    then
        openInBrowser()
        return
    end

    dispatch(SetCentralOverlay(CentralOverlayType.LeaveRobloxAlert, {
        continueFunc = function()
            openInBrowser()
            dispatch(CloseCentralOverlay())

            if not FFlagSafetyResourceBannerTelemetry or typeof(onContinue) ~= "function" then
                return
            end

            local success, result = pcall(onContinue)
            if not success then
                arg2.dependencies.logger.reportError(
                    SduiErrorType.FailedToExecuteAction,
                    {
                        name = SduiActionType.OpenExternalLink,
                        message = `onContinue failed: {tostring(result)}`
                    },
                    arg2.appPage
                )
            end
        end
    }))
end
