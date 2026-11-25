-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T13:01:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ServerDrivenUiParent = script:FindFirstAncestor("ServerDrivenUi").Parent
local CentralOverlayType = require(ServerDrivenUiParent.RobloxAppEnums).CentralOverlayType
local SetCentralOverlay = require(ServerDrivenUiParent.CentralOverlay).Actions.SetCentralOverlay

local SduiCoreSystem = require(ServerDrivenUiParent.SduiCoreSystem)
local SduiActionType = SduiCoreSystem.SduiActionType
local SduiErrorType = SduiCoreSystem.SduiErrors.SduiErrorType

return function(arg1, _, arg2, arg3)
    local actionParams = arg1 and arg1.actionParams or nil
    if actionParams == nil then
        arg2.dependencies.logger.reportError(
            SduiErrorType.InvalidActionParams,
            {
                name = SduiActionType.OpenJoinFriends,
                message = "Missing actionParams"
            },
            arg2.appPage
        )
        return
    end

    assert(actionParams, "actionParams must exist")
    local placeId = actionParams.placeId
    if placeId == nil then
        arg2.dependencies.logger.reportError(
            SduiErrorType.InvalidActionParams,
            {
                name = SduiActionType.OpenJoinFriends,
                message = `Missing placeId: {placeId}`,
                propName = "placeId"
            },
            arg2.appPage
        )
        return
    end

    local universeId = actionParams.universeId
    if universeId == nil then
        arg2.dependencies.logger.reportError(SduiErrorType.InvalidActionParams, {
            name = SduiActionType.OpenJoinFriends,
            message = `Missing universeId: {universeId}`,
            propName = "universeId"
        }, arg2.appPage)
        return
    end

    if not arg3 then
        arg2.dependencies.logger.reportError(
            SduiErrorType.FailedToExecuteAction,
            {
                name = SduiActionType.OpenJoinFriends,
                message = "Failed to execute -- missing guiObject anchor"
            },
            arg2.appPage
        )
        return
    end

    local absoluteSize = arg3.AbsoluteSize
    local absolutePosition = arg3.AbsolutePosition
    local game = {
        placeId = tostring(placeId),
        universeId = tostring(universeId)
    }
    arg2.dependencies.dispatch(
        SetCentralOverlay(
            CentralOverlayType.PlacesList,
            { game = game, anchorSpaceSize = absoluteSize, anchorSpacePosition = absolutePosition }
        )
    )
end
