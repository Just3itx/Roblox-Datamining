-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T21:20:30Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local UserInputService = game:GetService("UserInputService")
local VRService = game:GetService("VRService")

local Symbol = require(CorePackages.Workspace.Packages.AppCommonLib).Symbol
local MouseIconOverrideService = require(CorePackages.Workspace.Packages.CoreScriptsCommon).MouseIconOverrideService

local InGameMenuDependencies = require(CorePackages.Packages.InGameMenuDependencies)
local Roact = InGameMenuDependencies.Roact
local RoactRodux = InGameMenuDependencies.RoactRodux
local t = InGameMenuDependencies.t

local scriptParentParentParent = script.Parent.Parent.Parent

local Constants = require(scriptParentParentParent.Resources.Constants)
local ExternalEventConnection = require(scriptParentParentParent.Utility.ExternalEventConnection)

local InGameMenuCursorOverride = Symbol.named("InGameMenuCursorOverride")

local InputType = Constants.InputType

local var1 = Roact.PureComponent:extend("MouseOverrideManager")

var1.validateProps = t.strictInterface({ menuOpen = t.boolean, exitModalOpen = t.boolean, inputType = t.string })

function var1.render(arg1)
    local exitModalOpen = arg1.props.exitModalOpen

    return Roact.createElement(ExternalEventConnection, {
        event = UserInputService:GetPropertyChangedSignal("OverrideMouseIconBehavior"),
        callback = function()
            if (arg1.props.menuOpen or exitModalOpen)
                and UserInputService.OverrideMouseIconBehavior == Enum.OverrideMouseIconBehavior.None
            then
                arg1:updateMouseIconOverride()
            end
        end
    })
end

function var1.init(arg1)
    arg1.didOverrideMouse = false
end

function var1.updateMouseIconOverride(arg1)
    local exitModalOpen = arg1.props.exitModalOpen

    if arg1.props.menuOpen or exitModalOpen then
        arg1.didOverrideMouse = true
        if arg1.props.inputType == InputType.Gamepad or VRService.VREnabled then
            MouseIconOverrideService.push(InGameMenuCursorOverride, Enum.OverrideMouseIconBehavior.ForceHide)
            return
        end
        MouseIconOverrideService.push(InGameMenuCursorOverride, Enum.OverrideMouseIconBehavior.ForceShow)
        return
    end
    if arg1.didOverrideMouse then
        arg1.didOverrideMouse = false
        MouseIconOverrideService.pop(InGameMenuCursorOverride)
    end
end

function var1.didMount(arg1)
    arg1:updateMouseIconOverride()
end

function var1.didUpdate(arg1)
    arg1:updateMouseIconOverride()
end

return RoactRodux.UNSTABLE_connect2(function(arg1)
    local closingApp = arg1.nativeClosePrompt.closingApp

    return {
        menuOpen = arg1.isMenuOpen,
        exitModalOpen = closingApp,
        inputType = arg1.displayOptions.inputType
    }
end, nil)(var1)
