-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T21:40:33Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local InGameMenuDependencies = require(CorePackages.Packages.InGameMenuDependencies)
local Roact = InGameMenuDependencies.Roact
local RoactRodux = InGameMenuDependencies.RoactRodux

local IGMRespawnControllerBar = require(script.Parent.IGMRespawnControllerBar)

local scriptParentParent = script.Parent.Parent

local withLocalization = require(scriptParentParent.Localization.withLocalization)

local SetRespawning = require(scriptParentParent.Actions.SetRespawning)
local RespawnPlayer = require(scriptParentParent.Thunks.RespawnPlayer)

local ConfirmationDialog = require(script.Parent.ConfirmationDialog)

local SendAnalytics = require(scriptParentParent.Utility.SendAnalytics)
local Constants = require(scriptParentParent.Resources.Constants)

return RoactRodux.UNSTABLE_connect2(function(arg1, _)
    return {
        isRespawning = arg1.respawn.dialogOpen,
        inputType = arg1.displayOptions.inputType
    }
end, function(callback)
    return {
        onCancel = function()
            callback(SetRespawning(false))
            SendAnalytics(
                Constants.AnalyticsInGameMenuName,
                Constants.AnalyticsRespawnCharacterName,
                {
                    confirmed = Constants.AnalyticsCancelledName
                }
            )
        end,
        onConfirm = function()
            callback(RespawnPlayer)
        end
    }
end)(function(arg1) -- name: RespawnDialog
    local function renderRespawnDialogControllerBar() -- Luacid: Inlined by compiler; 1 call site recovered
        return Roact.createElement(IGMRespawnControllerBar, { inputType = arg1.inputType })
    end

    return withLocalization({
        titleText = "CoreScripts.InGameMenu.RespawnCharacterDialogTitle",
        bodyText = "CoreScripts.InGameMenu.RespawnCharacterDialogBody",
        confirmText = "CoreScripts.InGameMenu.RespawnCharacterDialogConfirm",
        cancelText = "CoreScripts.InGameMenu.Cancel"
    })(
        function(arg2)
            return Roact.createFragment({
                RespawnDialogControllerBar = if arg1.isRespawning then renderRespawnDialogControllerBar() or nil else nil,
                ConfirmationDialog = Roact.createElement(ConfirmationDialog, {
                    visible = arg1.isRespawning,
                    titleText = arg2.titleText,
                    bodyText = arg2.bodyText,
                    confirmText = arg2.confirmText,
                    cancelText = arg2.cancelText,
                    bindReturnToConfirm = true,
                    onCancel = arg1.onCancel,
                    onConfirm = arg1.onConfirm,
                    inputType = arg1.inputType
                })
            })
        end
    )
end)
