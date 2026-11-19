-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T21:31:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RunService = game:GetService("RunService")
local CorePackages = game:GetService("CorePackages")
local RobloxGui = game:GetService("CoreGui"):WaitForChild("RobloxGui")

local InGameMenuDependencies = require(CorePackages.Packages.InGameMenuDependencies)
local Roact = InGameMenuDependencies.Roact
local RoactRodux = InGameMenuDependencies.RoactRodux
local t = InGameMenuDependencies.t

local LeavePrompt = require(script.Parent.LeavePrompt)

local scriptParentParentParentParent = script.Parent.Parent.Parent.Parent
local withLocalization = require(scriptParentParentParentParent.Localization.withLocalization)

local Constants = require(scriptParentParentParentParent.Resources.Constants)
local CloseMenu = require(scriptParentParentParentParent.Thunks.CloseMenu)
local SendAnalytics = require(scriptParentParentParentParent.Utility.SendAnalytics)

local GetDefaultQualityLevel = require(CorePackages.Workspace.Packages.AppCommonLib).GetDefaultQualityLevel

local GetFFlagEnableVRFTUXExperience = require(RobloxGui.Modules.FTUX.Flags.GetFFlagEnableVRFTUXExperience)
local IsFTUXExperience = require(RobloxGui.Modules.FTUX.Utility.IsFTUXExperience)
local PlatformEnum = require(RobloxGui.Modules.FTUX.Enums.PlatformEnum)

local var1 = Roact.PureComponent:extend("LeaveGamePrompt")

var1.validateProps = t.strictInterface({
    closeMenu = t.callback,
    canGamepadCaptureFocus = t.optional(t.boolean),
    canKeyboardCaptureFocus = t.optional(t.boolean),
    onConfirm = t.optional(t.callback)
})

function var1.init(arg1)
    function arg1.leaveGameConfirm()
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
    end
end

function var1.render(arg1)
    return withLocalization({
        titleText = "CoreScripts.InGameMenu.Prompt.LeaveGameTitle",
        bodyText = if GetFFlagEnableVRFTUXExperience() and IsFTUXExperience(PlatformEnum.QuestVR) then "CoreScripts.InGameMenu.Prompt.VRFTUXLeaveGameBodyText" else "CoreScripts.InGameMenu.Prompt.LeaveGameBodyText",
        confirmText = "CoreScripts.InGameMenu.Prompt.LeaveGame",
        cancelText = "CoreScripts.InGameMenu.Prompt.ResumeGame"
    })(
        function(arg2)
            return Roact.createElement(LeavePrompt, {
                titleText = arg2.titleText,
                bodyText = arg2.bodyText,
                confirmText = arg2.confirmText,
                cancelText = arg2.cancelText,
                onConfirm = arg1.props.onConfirm or arg1.leaveGameConfirm,
                onCancel = arg1.props.closeMenu,
                canGamepadCaptureFocus = arg1.props.canGamepadCaptureFocus,
                canKeyboardCaptureFocus = arg1.props.canKeyboardCaptureFocus
            })
        end
    )
end
return RoactRodux.UNSTABLE_connect2(function(arg1, _)
    return {
        canGamepadCaptureFocus = arg1.menuPage == Constants.LeaveGamePromptPageKey
            and arg1.displayOptions.inputType == Constants.InputType.Gamepad
            and not arg1.respawn.dialogOpen
            and arg1.currentZone == 1,
        canKeyboardCaptureFocus = arg1.menuPage == Constants.LeaveGamePromptPageKey
            and arg1.displayOptions.inputType == Constants.InputType.MouseAndKeyboard
            and not arg1.respawn.dialogOpen
    }
end, function(callback)
    return {
        closeMenu = function()
            callback(CloseMenu)
            SendAnalytics(
                Constants.AnalyticsInGameMenuName,
                Constants.AnalyticsLeaveGameName,
                {
                    confirmed = Constants.AnalyticsCancelledName
                }
            )
        end
    }
end)(var1)
