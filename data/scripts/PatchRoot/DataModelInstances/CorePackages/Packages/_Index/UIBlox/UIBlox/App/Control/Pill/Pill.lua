-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:31:34Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent
local scriptParentParentParentParentParent = scriptParentParentParentParent.Parent
local Core = scriptParentParentParentParent.Core

local Roact = require(scriptParentParentParentParentParent.Roact)
local t = require(scriptParentParentParentParentParent.t)
local Foundation = require(scriptParentParentParentParentParent.Foundation)

local IconSize = require(scriptParentParentParent.ImageSet.Enum.IconSize)
local getIconSize = require(scriptParentParentParent.ImageSet.getIconSize)
local withStyle = require(Core.Style.withStyle)
local validateImageSetData = require(Core.ImageSet.Validator.validateImageSetData)
local ControlState = require(Core.Control.Enum.ControlState)
local Interactable = require(Core.Control.Interactable)
local getContentStyle = require(Core.Button.getContentStyle)

local GenericTextLabel = require(Core.Text.GenericTextLabel.GenericTextLabel)
local ImageSetComponent = require(scriptParentParentParentParent.Core.ImageSet.ImageSetComponent)
local Skeleton = Foundation.Skeleton
local Radius = Foundation.Enums.Radius
local GetTextSize = require(scriptParentParentParentParent.Core.Text.GetTextSize)
local GetFontFromFontStyle = require(scriptParentParentParentParent.Core.Text.GetFontFromFontStyle)

local var1 = Roact.PureComponent:extend("Pill")

var1.validateProps = t.strictInterface({
    text = t.optional(t.string),
    isSelected = t.optional(t.boolean),
    isDisabled = t.optional(t.boolean),
    isLoading = t.optional(t.boolean),
    icon = t.union(t.string, validateImageSetData),
    onActivated = t.callback
})

var1.defaultProps = { text = "", isSelected = false, isDisabled = false, isLoading = false }

function var1.init(arg1)
    arg1.state = {
        controlState = ControlState.Initialize
    }
end

function var1.render(arg1)
    return withStyle(function(arg2)
        local font = arg2.Font

        local isSelected = arg1.props.isSelected
        local isDisabled = arg1.props.isDisabled
        local isLoading = arg1.props.isLoading
        local icon = arg1.props.icon
        local text = arg1.props.text
        local onActivated = arg1.props.onActivated

        local tbl1 = {
            [ControlState.Default] = if isSelected then "SystemPrimaryContent" else "IconDefault",
            [ControlState.Hover] = if isSelected then "SystemPrimaryContent" else "IconEmphasis"
        }
        local tbl2 = {
            [ControlState.Default] = if isSelected then "SystemPrimaryContent" else "TextDefault",
            [ControlState.Hover] = if isSelected then "SystemPrimaryContent" else "TextEmphasis"
        }
        local tbl3 = {
            [ControlState.Default] = if isSelected then "SystemPrimaryDefault" else "BackgroundUIDefault",
            [ControlState.Hover] = if isSelected then "SystemPrimaryOnHover" else "BackgroundUIDefault"
        }

        local contentStyle = getContentStyle(tbl1, arg1.state.controlState, arg2)
        local colorStyle = getContentStyle(tbl2, arg1.state.controlState, arg2)
        local contentStyle3 = getContentStyle(tbl3, arg1.state.controlState, arg2)

        local iconSize = getIconSize(IconSize.Small)
        local baseSize = font.BaseSize
        local yOffset = font.CaptionHeader.RelativeSize * baseSize

        local textSizeX = GetTextSize(text, yOffset, GetFontFromFontStyle(font.CaptionHeader), Vector2.new(10000, 10000)).X

        local var2 = textSizeX + 24
        local xOffset = 240 - (28 + iconSize)
        local element

        if not isLoading then
            local createElement = Roact.createElement
            local var3 = Interactable
            local tbl4 = {
                Size = nil,
                Size = UDim2.new(0, var2 + 4 + iconSize, 0, 28),
                BackgroundColor3 = contentStyle3.Color,
                BackgroundTransparency = contentStyle3.Transparency,
                AutoButtonColor = false,
                BorderSizePixel = 0,
                LayoutOrder = 1,
                isDisabled = isDisabled,
                [Roact.Event.Activated] = not isLoading and onActivated or nil
            }

            function tbl4.onStateChanged(_, controlState)
                arg1:setState({ controlState = controlState })
            end

            local tbl5 = {
                UIListLayout = Roact.createElement("UIListLayout", {
                    Padding = UDim.new(0, 0),
                    FillDirection = Enum.FillDirection.Horizontal,
                    VerticalAlignment = Enum.VerticalAlignment.Center,
                    HorizontalAlignment = Enum.HorizontalAlignment.Center
                }),
                Content = 0,
                UICorner = 0,
                UISizeConstraint = 0
            }
            local createElement2 = Roact.createElement
            local str1 = "Frame"
            local tbl6 = {
                Size = UDim2.new(0, textSizeX + 4 + iconSize, 1, 0),
                ClipsDescendants = true,
                BackgroundTransparency = 1
            }

            local tbl7 = {
                UIListLayout = Roact.createElement("UIListLayout", {
                    Padding = UDim.new(0, 4),
                    FillDirection = Enum.FillDirection.Horizontal,
                    VerticalAlignment = Enum.VerticalAlignment.Center,
                    HorizontalAlignment = Enum.HorizontalAlignment.Center
                }),
                Icon = Roact.createElement(ImageSetComponent.Label, {
                    AnchorPoint = Vector2.new(0.5, 0.5),
                    Size = UDim2.fromOffset(iconSize, iconSize),
                    BackgroundTransparency = 1,
                    Image = icon,
                    ImageColor3 = contentStyle.Color,
                    ImageTransparency = contentStyle.Transparency
                }),
                TextArea = 0,
                UISizeConstraint = 0
            }
            local var4

            if string.len(text) > 0 then
                local createElement3 = Roact.createElement
                local tbl8 = {
                    Size = UDim2.fromOffset(textSizeX, yOffset),
                    LayoutOrder = 2,
                    BackgroundTransparency = 1
                }

                local tbl9 = {
                    PillText = Roact.createElement(GenericTextLabel, {
                        Text = text,
                        BackgroundTransparency = 1,
                        fontStyle = font.CaptionHeader,
                        colorStyle = colorStyle,
                        TextTruncate = Enum.TextTruncate.AtEnd,
                        Size = UDim2.fromOffset(xOffset, yOffset),
                        TextXAlignment = Enum.TextXAlignment.Left,
                        TextYAlignment = Enum.TextYAlignment.Center,
                        [Roact.Ref] = arg1.PillText
                    }),
                    Roact.createElement("UISizeConstraint", { MaxSize = Vector2.new(xOffset, 28) })
                }
                var4 = createElement3("Frame", tbl8, tbl9)
            else
                var4 = false
            end

            tbl7.TextArea = var4

            tbl7.UISizeConstraint = Roact.createElement("UISizeConstraint", { MaxSize = Vector2.new(216, 28) })
            tbl5.Content = createElement2(str1, tbl6, tbl7)

            tbl5.UICorner = Roact.createElement("UICorner", { CornerRadius = UDim.new(1, 0) })

            tbl5.UISizeConstraint = Roact.createElement("UISizeConstraint", { MaxSize = Vector2.new(240, 28) })
            element = createElement(var3, tbl4, tbl5)

            if element then
                return element
            end
        end

        element = Roact.createElement(Skeleton, { Size = UDim2.fromOffset(var2 + 4 + iconSize, 28), radius = Radius.Circle })
        return element
    end)
end

return var1
