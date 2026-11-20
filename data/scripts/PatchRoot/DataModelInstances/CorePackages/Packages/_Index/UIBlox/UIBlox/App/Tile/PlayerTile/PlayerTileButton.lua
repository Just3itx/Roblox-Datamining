-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T19:10:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local App = script:FindFirstAncestor("App")
local AppParent = App.Parent
local Core = AppParent.Core
local AppParentParent = AppParent.Parent

local t = require(AppParentParent.t)
local Roact = require(AppParentParent.Roact)

local Button = require(App.Button.Button)
local ButtonType = require(App.Button.Enum.ButtonType)
local ControlState = require(Core.Control.Enum.ControlState)

local var1 = Roact.PureComponent:extend("PlayerTileButton")

var1.validateProps = t.strictInterface({
    buttonHeight = t.optional(t.number),
    buttonWidth = t.optional(t.number),
    outerButtonPadding = t.optional(t.number),
    icon = t.union(t.string, t.table),
    onActivated = t.optional(t.callback),
    isSecondary = t.optional(t.boolean),
    isDisabled = t.optional(t.boolean),
    tileSize = t.optional(t.UDim2),
    mouseEnter = t.optional(t.callback),
    mouseLeave = t.optional(t.callback),
    isRoactGamepadEnabled = t.optional(t.boolean)
})

var1.defaultProps = {
    isSecondary = false,
    isDisabled = false,
    buttonHeight = 36,
    outerButtonPadding = 10,
    tileSize = UDim2.new(0, 150, 0, 150),
    isRoactGamepadEnabled = true
}

function var1.render(arg1)
    local isSecondary = arg1.props.isSecondary
    local onActivated = arg1.props.onActivated
    local isDisabled = arg1.props.isDisabled
    local icon = arg1.props.icon
    local buttonHeight = arg1.props.buttonHeight
    local outerButtonPadding = arg1.props.outerButtonPadding
    local xOffset = arg1.props.tileSize.X.Offset / 2 - outerButtonPadding * 1.5
    local uDim2 = UDim2.new(0, xOffset, 0, buttonHeight)

    local buttonType = isSecondary and ButtonType.Secondary or ButtonType.PrimarySystem

    return Roact.createElement(Button, {
        buttonType = buttonType,
        automaticSize = Enum.AutomaticSize.XY,
        position = UDim2.new(1, 0, 1, 0),
        size = uDim2,
        anchorPoint = Vector2.new(1, 1),
        onActivated = onActivated or function() end,
        isDisabled = isDisabled,
        icon = icon,
        isRoactGamepadEnabled = arg1.props.isRoactGamepadEnabled,
        onStateChanged = function(hover, hover2)
            if hover == ControlState.Hover then
                arg1.props.mouseEnter()
            elseif hover2 == ControlState.Hover then
                arg1.props.mouseLeave()
            end
        end
    })
end

return var1
