-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T13:10:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ServerDrivenUiParent = script:FindFirstAncestor("ServerDrivenUi").Parent

local DataHydration = require(ServerDrivenUiParent.DataHydration)

local SduiCoreSystem = require(ServerDrivenUiParent.SduiCoreSystem)
local SduiErrorType = SduiCoreSystem.SduiErrors.SduiErrorType
local SduiActionType = SduiCoreSystem.SduiActionType

local function SduiRefreshGamePassesAction(arg1, _, arg2)
    local actionParams = arg1 and arg1.actionParams or nil
    if actionParams == nil then
        arg2.dependencies.logger.reportError(
            SduiErrorType.InvalidActionParams,
            {
                name = SduiActionType.RefreshGamePasses,
                message = "Missing actionParams"
            },
            arg2.appPage
        )
        return
    end

    local universeId = actionParams.universeId
    if universeId then
        DataHydration.Game.getGamePassStore(false).fetchPassesForUniverse(universeId)
    end
end

return SduiRefreshGamePassesAction
