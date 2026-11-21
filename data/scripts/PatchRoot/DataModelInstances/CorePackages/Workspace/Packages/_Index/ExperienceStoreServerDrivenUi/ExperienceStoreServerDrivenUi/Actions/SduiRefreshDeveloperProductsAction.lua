-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T13:11:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExperienceStoreServerDrivenUiParent = script:FindFirstAncestor("ExperienceStoreServerDrivenUi").Parent

local DataHydration = require(ExperienceStoreServerDrivenUiParent.DataHydration)

local SduiCoreSystem = require(ExperienceStoreServerDrivenUiParent.SduiCoreSystem)
local SduiErrorType = SduiCoreSystem.SduiErrors.SduiErrorType
local SduiActionType = SduiCoreSystem.SduiActionType

local Players = game:GetService("Players")

local function SduiRefreshDeveloperProductsAction(arg1, _, arg2)
    local actionParams = arg1 and arg1.actionParams
    if actionParams == nil then
        arg2.dependencies.logger.reportError(
            SduiErrorType.InvalidActionParams,
            {
                name = SduiActionType.RefreshDeveloperProducts,
                message = "Missing actionParams"
            },
            arg2.appPage
        )
        return
    end

    local placeId = actionParams.placeId
    if placeId == nil then
        arg2.dependencies.logger.reportError(
            SduiErrorType.InvalidActionParams,
            {
                name = SduiActionType.RefreshDeveloperProducts,
                message = "Missing placeId"
            },
            arg2.appPage
        )
        return
    end

    local localPlayer = Players.LocalPlayer
    local userId = localPlayer and localPlayer.UserId
    if userId == nil then
        return
    end

    DataHydration.Game.getGameDeveloperProductStore(false).fetchStatuses(tostring(userId), tostring(placeId))
end

return SduiRefreshDeveloperProductsAction
