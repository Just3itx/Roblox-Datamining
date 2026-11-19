-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T21:31:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RunService = game:GetService("RunService")
local CorePackages = game:GetService("CorePackages")

local InGameMenuDependencies = require(CorePackages.Packages.InGameMenuDependencies)
local Roact = InGameMenuDependencies.Roact
local RoactRodux = InGameMenuDependencies.RoactRodux
local t = InGameMenuDependencies.t

local scriptParentParent = script.Parent.Parent

local withLocalization = require(scriptParentParent.Localization.withLocalization)

local CancelLeavingGame = require(scriptParentParent.Actions.CancelLeavingGame)

local GlobalConfig = require(scriptParentParent.GlobalConfig)

local ConfirmationDialog = require(script.Parent.ConfirmationDialog)

local Constants = require(scriptParentParent.Resources.Constants)

local SendAnalytics = require(scriptParentParent.Utility.SendAnalytics)

local GetDefaultQualityLevel = require(CorePackages.Workspace.Packages.AppCommonLib).GetDefaultQualityLevel

local var1 = t.strictInterface({ isLeavingGame = t.boolean, onCancel = t.callback, sendAnalytics = t.callback })

return RoactRodux.UNSTABLE_connect2(function(arg1, _)
    return {
        isLeavingGame = arg1.leavingGame
    }
end, function(callback)
    return {
        onCancel = function()
            callback(CancelLeavingGame())
            SendAnalytics(
                Constants.AnalyticsInGameMenuName,
                Constants.AnalyticsLeaveGameName,
                {
                    confirmed = Constants.AnalyticsCancelledName
                }
            )
        end
    }
end)(function(arg1) -- name: LeaveGameDialog
    if GlobalConfig.propValidation then
        assert(var1(arg1))
    end

    return withLocalization({
        bodyText = "CoreScripts.InGameMenu.ConfirmLeaveGame",
        confirmText = "CoreScripts.InGameMenu.Leave",
        titleText = "CoreScripts.InGameMenu.LeaveGameQuestion",
        cancelText = "CoreScripts.InGameMenu.Cancel"
    })(
        function(arg2)
            return Roact.createElement(ConfirmationDialog, {
                bodyText = arg2.bodyText,
                confirmText = arg2.confirmText,
                titleText = arg2.titleText,
                cancelText = arg2.cancelText,
                bindReturnToConfirm = true,
                onCancel = arg1.onCancel,
                onConfirm = function()
                    SendAnalytics(
                        Constants.AnalyticsInGameMenuName,
                        Constants.AnalyticsLeaveGameName,
                        {
                            confirmed = Constants.AnalyticsConfirmedName
                        }
                    )
                    RunService.Heartbeat:Wait()
                    game:Shutdown()
                    settings().Rendering.QualityLevel = GetDefaultQualityLevel()
                end,
                blurBackground = true,
                visible = arg1.isLeavingGame
            })
        end
    )
end)
