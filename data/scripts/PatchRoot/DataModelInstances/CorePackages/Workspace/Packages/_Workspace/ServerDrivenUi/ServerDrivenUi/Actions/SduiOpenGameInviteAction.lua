-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T13:01:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ServerDrivenUiParent = script:FindFirstAncestor("ServerDrivenUi").Parent

local SduiCoreSystem = require(ServerDrivenUiParent.SduiCoreSystem)
local SduiActionType = SduiCoreSystem.SduiActionType
local SduiErrorType = SduiCoreSystem.SduiErrors.SduiErrorType

local GameInvite = require(ServerDrivenUiParent.GameInvite)
local GameInviteModalManager = GameInvite.GameInviteModalManager
local GameInviteAnalyticsManager = GameInvite.GameInviteAnalyticsManager

return function(arg1, _, arg2)
    local actionParams = arg1 and arg1.actionParams or nil
    if actionParams == nil then
        arg2.dependencies.logger.reportError(
            SduiErrorType.InvalidActionParams,
            {
                name = SduiActionType.OpenGameInvite,
                message = "Missing actionParams"
            },
            arg2.appPage
        )
        return
    end

    assert(actionParams, "actionParams must exist")
    local universeId = actionParams.universeId
    local rootPlaceId = actionParams.rootPlaceId
    local trigger = actionParams.trigger
    local buttonName = actionParams.buttonName

    if typeof(rootPlaceId) ~= "string" or rootPlaceId == "" then
        arg2.dependencies.logger.reportError(SduiErrorType.InvalidActionParams, {
            name = SduiActionType.OpenGameInvite,
            message = `Invalid or missing rootPlaceId: {rootPlaceId}`,
            propName = "rootPlaceId"
        }, arg2.appPage)
        return
    end

    if typeof(trigger) ~= "string" or trigger == "" then
        arg2.dependencies.logger.reportError(SduiErrorType.InvalidActionParams, {
            name = SduiActionType.OpenGameInvite,
            message = `Invalid or missing trigger: {trigger}`,
            propName = "trigger"
        }, arg2.appPage)
        return
    end

    if typeof(buttonName) == "string" and buttonName ~= "" then
        GameInviteAnalyticsManager:withButtonName(buttonName)
        GameInviteAnalyticsManager:inputShareGameEntryPoint(rootPlaceId, universeId)
    end

    GameInviteModalManager:openModal({ trigger = trigger, rootPlaceId = rootPlaceId, universeId = universeId })
end
