-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T13:01:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ServerDrivenUiParent = script:FindFirstAncestor("ServerDrivenUi").Parent

local Game = require(ServerDrivenUiParent.DataHydration).Game

local SduiCoreSystem = require(ServerDrivenUiParent.SduiCoreSystem)
local SduiActionType = SduiCoreSystem.SduiActionType
local SduiErrorType = SduiCoreSystem.SduiErrors.SduiErrorType
local getSduiClientPageScope = SduiCoreSystem.getSduiClientPageScope

local function SduiDismissGameFeedbackAction(arg1, _, arg2)
    local actionParams = arg1 and arg1.actionParams or nil
    if actionParams == nil then
        arg2.dependencies.logger.reportError(
            SduiErrorType.InvalidActionParams,
            {
                name = SduiActionType.DismissGameFeedback,
                message = "Missing actionParams"
            },
            arg2.appPage
        )
        return
    end

    local rootPlaceId = actionParams.rootPlaceId
    if rootPlaceId == nil or typeof(rootPlaceId) ~= "string" then
        arg2.dependencies.logger.reportError(
            SduiErrorType.InvalidActionParams,
            {
                name = SduiActionType.DismissGameFeedback,
                message = "Missing or invalid rootPlaceId"
            },
            arg2.appPage
        )
        return
    end

    Game.getUserVoteFeedbackMetadataStore(false).clearItem(rootPlaceId)

    if arg2.configKey then
        getSduiClientPageScope(arg2.configKey).set("showPlayerFeedback", false)
    end
end

return SduiDismissGameFeedbackAction
