-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T13:10:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ServerDrivenUiParent = script:FindFirstAncestor("ServerDrivenUi").Parent
local SduiCoreSystem = require(ServerDrivenUiParent.SduiCoreSystem)
local SduiErrorType = SduiCoreSystem.SduiErrors.SduiErrorType
local SduiActionType = SduiCoreSystem.SduiActionType
local CloseCentralOverlay = require(ServerDrivenUiParent.CentralOverlay).Thunks.CloseCentralOverlay
local SetCentralOverlay = require(ServerDrivenUiParent.CentralOverlay).Actions.SetCentralOverlay
local CentralOverlayType = require(ServerDrivenUiParent.RobloxAppEnums).CentralOverlayType
local DataHydration = require(ServerDrivenUiParent.DataHydration)
local localizeStrings = require(ServerDrivenUiParent.Localization).localizeStrings

return function(arg1, _, arg2, _)
    local actionParams = arg1 and arg1.actionParams or nil
    if actionParams == nil then
        arg2.dependencies.logger.reportError(
            SduiErrorType.InvalidActionParams,
            {
                name = SduiActionType.RemoveBadgeFromInventory,
                message = "Missing action params"
            },
            arg2.appPage
        )
        return
    end

    assert(actionParams, "actionParams must exist")
    if actionParams.assetId == nil then
        arg2.dependencies.logger.reportError(
            SduiErrorType.InvalidActionParams,
            {
                name = SduiActionType.RemoveBadgeFromInventory,
                message = "Missing actionParam: assetId"
            },
            arg2.appPage
        )
        return
    end

    local assetId = actionParams.assetId

    local localization = arg2.dependencies.localization
    local var1 = localizeStrings(localization, {
        RemoveBadgeTitle = "Feature.Item.Label.DeleteItemUndercase",
        RemoveBadgeBody = "Feature.Item.Label.DeleteFromInventoryConfirmUndercaseDelete"
    })

    local dispatch = arg2.dependencies.dispatch
    dispatch(
        SetCentralOverlay(CentralOverlayType.ConfirmationDialog, {
            title = var1.RemoveBadgeTitle,
            body = var1.RemoveBadgeBody,
            disablePortal = false,
            onConfirm = function()
                DataHydration.Badges.getBadgeInfoStore(false).removeBadge(tostring(assetId))
                dispatch(CloseCentralOverlay())
            end,
            onCancel = function()
                dispatch(CloseCentralOverlay())
            end
        })
    )
end
