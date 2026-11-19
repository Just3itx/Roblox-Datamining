-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T21:31:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RunService = game:GetService("RunService")
local CorePackages = game:GetService("CorePackages")

local LinkingProtocol = require(CorePackages.Workspace.Packages.LinkingProtocol)
local DeepLinkSource = LinkingProtocol.Enums.DeepLinkSource
local LinkingProtocol2 = LinkingProtocol.LinkingProtocol

local InGameMenuDependencies = require(CorePackages.Packages.InGameMenuDependencies)
local Roact = InGameMenuDependencies.Roact
local RoactRodux = InGameMenuDependencies.RoactRodux
local t = InGameMenuDependencies.t

local LeavePrompt = require(script.Parent.LeavePrompt)

local scriptParentParentParentParent = script.Parent.Parent.Parent.Parent
local withLocalization = require(scriptParentParentParentParent.Localization.withLocalization)

local CloseMenu = require(scriptParentParentParentParent.Thunks.CloseMenu)
local SendAnalytics = require(scriptParentParentParentParent.Utility.SendAnalytics)
local Constants = require(scriptParentParentParentParent.Resources.Constants)

local var1 = Roact.PureComponent:extend("LeaveToAppPrompt")

var1.validateProps = t.strictInterface({
    closeMenu = t.callback,
    canGamepadCaptureFocus = t.optional(t.boolean),
    canKeyboardCaptureFocus = t.optional(t.boolean),
    onConfirm = t.optional(t.callback),
    linkingProtocol = t.table
})

var1.defaultProps = {
    linkingProtocol = LinkingProtocol2.default
}

function var1.init(arg1)
    function arg1.goToHomePage()
        SendAnalytics(
            Constants.AnalyticsLeaveToHomeName,
            Constants.AnalyticsLeaveToHomeName,
            {
                confirmed = Constants.AnalyticsLeaveToHomeName
            }
        )

        if arg1.props.linkingProtocol:isInternalDlicEnabled() then
            local var2 = arg1.props.linkingProtocol:createInternalDlic("roblox://navigation/home", DeepLinkSource.LuaInternal)

            RunService.Heartbeat:Wait()
            arg1.props.linkingProtocol:detectDeeplinkIntent(var2)
        else
            RunService.Heartbeat:Wait()
            arg1.props.linkingProtocol:detectURL("roblox://navigation/home")
        end

        game:Shutdown()
    end
end

function var1.render(arg1)
    return withLocalization({
        titleText = "CoreScripts.InGameMenu.Prompt.LeaveGameTitle",
        bodyText = "CoreScripts.InGameMenu.Prompt.LeaveGameBodyText",
        confirmText = "CoreScripts.InGameMenu.Prompt.BackToHome",
        cancelText = "CoreScripts.InGameMenu.Prompt.ResumeGame"
    })(
        function(arg2)
            return Roact.createElement(LeavePrompt, {
                titleText = arg2.titleText,
                bodyText = arg2.bodyText,
                confirmText = arg2.confirmText,
                cancelText = arg2.cancelText,
                onConfirm = arg1.props.onConfirm or arg1.goToHomePage,
                onCancel = arg1.props.closeMenu,
                canGamepadCaptureFocus = arg1.props.canGamepadCaptureFocus,
                canKeyboardCaptureFocus = arg1.props.canKeyboardCaptureFocus
            })
        end
    )
end
return RoactRodux.UNSTABLE_connect2(function(arg1, _)
    return {
        canGamepadCaptureFocus = arg1.menuPage == Constants.LeaveToAppPromptPageKey
            and arg1.displayOptions.inputType == Constants.InputType.Gamepad
            and not arg1.respawn.dialogOpen
            and arg1.currentZone == 1,
        canKeyboardCaptureFocus = arg1.menuPage == Constants.LeaveToAppPromptPageKey
            and arg1.displayOptions.inputType == Constants.InputType.MouseAndKeyboard
            and not arg1.respawn.dialogOpen
    }
end, function(callback)
    return {
        closeMenu = function()
            callback(CloseMenu)
        end
    }
end)(var1)
