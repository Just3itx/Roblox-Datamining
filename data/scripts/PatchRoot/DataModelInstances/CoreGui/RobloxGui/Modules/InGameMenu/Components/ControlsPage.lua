-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T21:20:35Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local GuiService = game:GetService("GuiService")

local VRService = require(CorePackages.Workspace.Packages.MockableProxyServices).VRService
local InGameMenuDependencies = require(CorePackages.Packages.InGameMenuDependencies)
local Roact = InGameMenuDependencies.Roact
local RoactRodux = InGameMenuDependencies.RoactRodux
local t = InGameMenuDependencies.t

local scriptParentParent = script.Parent.Parent

local Controls = require(scriptParentParent.Resources.Controls)

local KeyboardControls = require(script.ControlLayouts.KeyboardControls)
local GamepadControls = require(script.ControlLayouts.GamepadControls)
local VRGamepadControlsWrapper = require(script.ControlLayouts.VRGamepadControlsWrapper)

local VRUtil = require(CorePackages.Workspace.Packages.VrCommon).VRUtil

local FocusHandler = require(scriptParentParent.Components.Connection.FocusHandler)

local var1 = Roact.PureComponent:extend("ControlsPage")

var1.validateProps = t.strictInterface(
    {
        pageTitle = t.string,
        controlLayout = t.optional(t.string),
        canCaptureFocus = t.optional(t.boolean)
    }
)
function var1.init(arg1)
    arg1.closeButtonRef = Roact.createRef()
end

function var1.render(arg1)
    local controlLayout = arg1.props.controlLayout

    if controlLayout == Controls.ControlLayouts.KEYBOARD then
        return Roact.createElement(KeyboardControls)
    elseif controlLayout == Controls.ControlLayouts.GAMEPAD then
        if VRService.VREnabled and VRUtil.getCurrentControllerType() == "Touch" then
            return Roact.createElement(VRGamepadControlsWrapper)
        end
        return Roact.createFragment({
            GamepadControls = Roact.createElement(GamepadControls, { closeButtonRef = arg1.closeButtonRef }),
            FocusHandler = Roact.createElement(FocusHandler, {
                isFocused = arg1.props.canCaptureFocus,
                didFocus = function()
                    local selectedCoreObject = arg1.closeButtonRef:getValue()
                    GuiService:AddSelectionParent("IGMControlsPage_CloseButtonSelectionGroup", selectedCoreObject)
                    GuiService.SelectedCoreObject = selectedCoreObject
                end,
                didBlur = function()
                    GuiService:RemoveSelectionGroup("IGMControlsPage_CloseButtonSelectionGroup")
                end
            })
        })
    else
        return nil
    end
end

return RoactRodux.UNSTABLE_connect2(function(arg1)
    return {
        controlLayout = arg1.controlLayout,
        canCaptureFocus = arg1.menuPage == "Controls"
    }
end)(var1)
