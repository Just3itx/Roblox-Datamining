-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T21:11:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local GuiService = game:GetService("GuiService")

local InGameMenuDependencies = require(CorePackages.Packages.InGameMenuDependencies)
local Roact = InGameMenuDependencies.Roact
local RoactRodux = InGameMenuDependencies.RoactRodux
local t = InGameMenuDependencies.t

local scriptParentParentParent = script.Parent.Parent.Parent
local InputType = require(scriptParentParentParent.Resources.Constants).InputType
local GetFFlagIGMGamepadSelectionHistory = require(scriptParentParentParent.Flags.GetFFlagIGMGamepadSelectionHistory)
local FocusHandler = require(script.Parent.FocusHandler)

local var1 = Roact.PureComponent:extend("FocusHighlightManager")

var1.validateProps = t.strictInterface({ menuOpen = t.boolean, inputType = t.string })

function var1.render(arg1)
    if GetFFlagIGMGamepadSelectionHistory() then
        return Roact.createElement(FocusHandler, {
            isFocused = not arg1.props.menuOpen or arg1.props.inputType ~= InputType.Gamepad,
            didFocus = function()
                GuiService.SelectedCoreObject = nil
            end
        })
    end
    return Roact.createElement(FocusHandler, {
        isFocused = arg1.props.menuOpen and arg1.props.inputType == InputType.Gamepad,
        didBlur = function()
            GuiService.SelectedCoreObject = nil
        end
    })
end

return RoactRodux.UNSTABLE_connect2(function(arg1)
    return {
        menuOpen = arg1.isMenuOpen,
        inputType = arg1.displayOptions.inputType
    }
end)(var1)
