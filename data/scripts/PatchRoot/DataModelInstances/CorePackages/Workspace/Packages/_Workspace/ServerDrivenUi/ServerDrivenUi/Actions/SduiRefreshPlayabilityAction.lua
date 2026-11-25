-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T13:10:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ServerDrivenUiParent = script:FindFirstAncestor("ServerDrivenUi").Parent

local FetchGamePlayabilityAndProductInfo = require(ServerDrivenUiParent.GameDetailRodux).FetchGamePlayabilityAndProductInfo
local GamePlayButton = require(ServerDrivenUiParent.GamePlayButton)

local SduiCoreSystem = require(ServerDrivenUiParent.SduiCoreSystem)
local SduiErrorType = SduiCoreSystem.SduiErrors.SduiErrorType
local SduiActionType = SduiCoreSystem.SduiActionType

local function SduiRefreshPlayabilityAction(arg1, _, arg2)
    local actionParams = arg1 and arg1.actionParams or nil
    if actionParams == nil then
        arg2.dependencies.logger.reportError(
            SduiErrorType.InvalidActionParams,
            {
                name = SduiActionType.RefreshPlayability,
                message = "Missing actionParams"
            },
            arg2.appPage
        )
        return
    end

    local universeId = actionParams.universeId
    if universeId == nil or GamePlayButton.Flags.GetFFlagLuaAppFetchPlayabilityKillSwitch() then
        return
    end

    local networking = arg2.dependencies.networking
    if networking ~= nil then
        arg2.dependencies.dispatch(FetchGamePlayabilityAndProductInfo.Fetch(networking, universeId))
        return
    end

    arg2.dependencies.logger.reportError(
        SduiErrorType.GetNilDependencies,
        {
            message = "RefreshPlayability requires networking dependency",
            name = SduiActionType.RefreshPlayability
        },
        arg2.appPage
    )
end
return SduiRefreshPlayabilityAction
