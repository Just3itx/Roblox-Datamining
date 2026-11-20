-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:40:41Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local App = script:FindFirstAncestor("App")
local AppParent = App.Parent
local Core = AppParent.Core
local AppParentParent = AppParent.Parent

local t = require(AppParentParent.t)
local Roact = require(AppParentParent.Roact)

local ControlState = require(Core.Control.Enum.ControlState)
local GenericTextLabel = require(Core.Text.GenericTextLabel.GenericTextLabel)
local withStyle = require(Core.Style.withStyle)
local getContentStyle = require(Core.Button.getContentStyle)
local getIconSize = require(App.ImageSet.getIconSize)
local ImageSetComponent = require(AppParent.Core.ImageSet.ImageSetComponent)
local IconSize = require(App.ImageSet.Enum.IconSize)
local validateFontInfo = require(AppParent.Core.Style.Validator.validateFontInfo)
local validateTypographyInfo = require(AppParent.Core.Style.Validator.validateTypographyInfo)
local validateColorInfo = require(AppParent.Core.Style.Validator.validateColorInfo)

local var1 = Roact.PureComponent:extend("PlayerContext")

local tbl1 = {
    [ControlState.Default] = "TextDefault"
}

local tbl2 = {
    [ControlState.Default] = "IconOnHover",
    [ControlState.Hover] = "IconDefault"
}

var1.validateProps = t.strictInterface({
    text = t.optional(t.string),
    icon = t.optional(t.union(t.string, t.table)),
    iconSize = t.optional(t.intersection(t.UDim2, function(arg1) -- name: doesNotUseScale
        if arg1.X.Scale ~= 0 or arg1.Y.Scale ~= 0 then
            return false, "Only Offset values are allowed"
        end

        return true
    end)),
    iconColor = t.optional(t.Color3),
    iconTransparency = t.optional(t.number),
    onActivated = t.optional(t.callback),
    Selectable = t.optional(t.boolean),
    fontStyle = t.optional(t.union(validateFontInfo, validateTypographyInfo)),
    textHeight = t.optional(t.number),
    textColorStyle = t.optional(validateColorInfo),
    iconPadding = t.optional(t.number),
    iconTextSpacing = t.optional(t.number),
    layoutOrder = t.optional(t.number),
    horizontalAlignment = t.optional(t.EnumItem),
    textXAlignment = t.optional(t.EnumItem)
})

var1.defaultProps = {
    text = "",
    icon = nil,
    Selectable = true,
    iconSize = UDim2.fromOffset(getIconSize(IconSize.Small), getIconSize(IconSize.Small)),
    textHeight = 28,
    iconPadding = 4,
    iconTextSpacing = 4,
    layoutOrder = 1,
    horizontalAlignment = Enum.HorizontalAlignment.Left,
    textXAlignment = Enum.TextXAlignment.Left
}

function var1.init(arg1)
    arg1.state = {}
end

function var1.render(arg1)
    local controlState = arg1.state.controlState
    local text = arg1.props.text
    local icon = arg1.props.icon
    local iconSize = arg1.props.iconSize
    local horizontalAlignment = arg1.props.horizontalAlignment

    local onActivated = arg1.props.onActivated

    return withStyle(function(arg2)
        local contentStyle = getContentStyle(tbl2, controlState, arg2)
        local contentStyle2 = getContentStyle(tbl1, controlState, arg2)
        local var2 = onActivated and contentStyle or contentStyle2

        local iconTransparency = arg1.props.iconTransparency
        if not arg1.props.iconTransparency then
            iconTransparency = if arg1.props.iconColor then 0 else var2.Transparency
        end

        local iconColor = arg1.props.iconColor
        if not arg1.props.iconColor then
            iconColor = var2.Color
        end

        local textHeight = arg1.props.textHeight

        local textColorStyle = arg1.props.textColorStyle

        if textColorStyle then
            contentStyle2 = textColorStyle
        elseif onActivated then
            contentStyle2 = contentStyle
        end

        local iconPadding = arg1.props.iconPadding
        local iconTextSpacing = arg1.props.iconTextSpacing

        local xOffset = iconSize.X.Offset + iconPadding * 2
        local yOffset = iconSize.Y.Offset + iconPadding * 2

        local fontStyle = arg1.props.fontStyle or arg2.Font.CaptionHeader
        return Roact.createElement("ImageButton", {
            Size = UDim2.new(1, 0, 0, textHeight),
            BackgroundTransparency = 1,
            Selectable = arg1.props.Selectable,
            Active = not not onActivated,
            LayoutOrder = arg1.props.layoutOrder,
            [Roact.Event.Activated] = onActivated
        }, {
            UIListLayout = Roact.createElement("UIListLayout", {
                FillDirection = Enum.FillDirection.Horizontal,
                VerticalAlignment = Enum.VerticalAlignment.Center,
                HorizontalAlignment = horizontalAlignment,
                SortOrder = Enum.SortOrder.LayoutOrder,
                Padding = UDim.new(0, iconTextSpacing)
            }),
            IconFrame = icon
                and Roact.createElement("Frame", {
                    Size = UDim2.fromOffset(xOffset, yOffset),
                    BackgroundTransparency = 1
                }, {
                    layout = Roact.createElement(
                        "UIListLayout",
                        {
                            VerticalAlignment = Enum.VerticalAlignment.Center,
                            HorizontalAlignment = Enum.HorizontalAlignment.Center
                        }
                    ),
                    icon = Roact.createElement(ImageSetComponent.Label, {
                        AnchorPoint = Vector2.new(0.5, 0.5),
                        Size = iconSize,
                        BackgroundTransparency = 1,
                        Image = icon,
                        ImageColor3 = iconColor,
                        ImageTransparency = iconTransparency
                    })
                }),
            Text = text
                and Roact.createElement(GenericTextLabel, {
                    AutomaticSize = Enum.AutomaticSize.Y,
                    Size = UDim2.new(1, if icon then -(xOffset + iconTextSpacing) else 0, 0, 0),
                    Text = text,
                    TextWrapped = true,
                    TextXAlignment = arg1.props.textXAlignment,
                    fontStyle = fontStyle,
                    colorStyle = contentStyle2,
                    LayoutOrder = 2,
                    TextTruncate = Enum.TextTruncate.AtEnd
                })
        })
    end)
end

return var1
