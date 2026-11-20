-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:21:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent

local Roact = require(scriptParentParentParentParent.Roact)
local t = require(scriptParentParentParentParent.t)

local withStyle = require(scriptParentParentParent.Core.Style.withStyle)
local GenericTextLabel = require(scriptParentParentParent.Core.Text.GenericTextLabel.GenericTextLabel)
local KeyLabel = require(scriptParentParent.Menu.KeyLabel.KeyLabel)

local ControllerBarHintInternalPadding = require(script.Parent.BarConstants).ControllerBarHintInternalPadding

local var1 = Roact.PureComponent:extend("ControllerBarHint")

var1.validateProps = t.strictInterface({
    layoutOrder = t.optional(t.integer),
    keyCode = t.enum(Enum.KeyCode),
    text = t.string,
    maxWidth = t.optional(t.number),
    hintTextSize = t.optional(t.number)
})

function var1.render(arg1)
    return withStyle(function(arg2)
        local theme = arg2.Theme
        local font = arg2.Font

        local createElement = Roact.createElement
        local str1 = "Frame"
        local tbl1 = {
            LayoutOrder = arg1.props.layoutOrder,
            BackgroundTransparency = 1,
            AutomaticSize = Enum.AutomaticSize.X
        }
        local tbl2 = {
            Layout = Roact.createElement("UIListLayout", {
                SortOrder = Enum.SortOrder.LayoutOrder,
                FillDirection = Enum.FillDirection.Horizontal,
                HorizontalAlignment = Enum.HorizontalAlignment.Left,
                VerticalAlignment = Enum.VerticalAlignment.Center,
                Padding = UDim.new(0, ControllerBarHintInternalPadding)
            }),
            ControllerBarHintIcon = Roact.createElement(KeyLabel, { keyCode = arg1.props.keyCode, LayoutOrder = 1, iconThemeKey = "IconEmphasis" }),
            ControllerBarHintText = Roact.createElement(GenericTextLabel, {
                TextSize = arg1.props.hintTextSize,
                maxSize = arg1.props.maxWidth and Vector2.new(arg1.props.maxWidth) or nil,
                BackgroundTransparency = 1,
                LayoutOrder = 2,
                fontStyle = font.Header2,
                colorStyle = theme.TextEmphasis,
                AutomaticSize = if arg1.props.maxWidth then nil else Enum.AutomaticSize.X or nil,
                TextTransparency = theme.TextEmphasis.TextTransparency,
                fluidSizing = not not arg1.props.maxWidth,
                Text = arg1.props.text,
                TextTruncate = arg1.props.maxWidth and Enum.TextTruncate.AtEnd or nil,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextYAlignment = Enum.TextYAlignment.Center
            })
        }
        return createElement(str1, tbl1, tbl2)
    end)
end

return var1
