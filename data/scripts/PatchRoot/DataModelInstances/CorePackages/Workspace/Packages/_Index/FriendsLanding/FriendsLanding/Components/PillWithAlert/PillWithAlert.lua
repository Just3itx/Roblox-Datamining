-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T15:50:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FriendsLanding = script:FindFirstAncestor("FriendsLanding")
local dependencies = require(FriendsLanding.dependencies)

local Roact = dependencies.Roact
local t = dependencies.t
local TextService = dependencies.TextService
local UIBlox = dependencies.UIBlox
local Foundation = dependencies.Foundation
local Radius = Foundation.Enums.Radius
local Skeleton = Foundation.Skeleton

local IconSize = UIBlox.App.ImageSet.Enum.IconSize
local getIconSize = UIBlox.App.ImageSet.getIconSize
local withStyle = UIBlox.Core.Style.withStyle
local validateImage = UIBlox.Core.ImageSet.Validator.validateImage
local ControlState = UIBlox.Core.Control.Enum.ControlState
local Interactable = UIBlox.Core.Control.Interactable
local Badge = UIBlox.App.Indicator.Badge
local BadgeStates = UIBlox.App.Indicator.Enum.BadgeStates

local StyledTextLabel = UIBlox.App.Text.StyledTextLabel
local ImageSetLabel = UIBlox.Core.ImageSet.ImageSetLabel

local function func1(tbl1, controlState, arg1)
    local var1 = tbl1[controlState] or tbl1[ControlState.Default]

    local tbl2 = {
        Color = arg1.Theme[var1].Color,
        Transparency = arg1.Theme[var1].Transparency
    }

    if controlState == ControlState.Disabled or controlState == ControlState.Pressed then
        tbl2.Transparency = 0.5 * tbl2.Transparency + 0.5
    end

    return tbl2
end

local var1 = Roact.PureComponent:extend("Pill")

var1.validateProps = t.strictInterface({
    text = t.optional(t.string),
    isSelected = t.optional(t.boolean),
    isDisabled = t.optional(t.boolean),
    isLoading = t.optional(t.boolean),
    icon = t.union(t.string, validateImage),
    onActivated = t.callback
})

function var1.init(arg1)
    arg1.state = {
        controlState = ControlState.Initialize
    }

    function arg1.onStateChanged(_, controlState)
        arg1:setState({ controlState = controlState })
    end
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

        local tbl4 = func1(tbl1, arg1.state.controlState, arg2)
        local colorStyle = func1(tbl2, arg1.state.controlState, arg2)
        local tbl6 = func1(tbl3, arg1.state.controlState, arg2)

        local iconSize = getIconSize(IconSize.Small)
        local yOffset = font.CaptionHeader.RelativeSize * font.BaseSize
        local textSizeX = TextService:GetTextSize(text, yOffset, font.CaptionHeader.Font, Vector2.new(10000, 10000)).X

        local var2 = textSizeX + 24
        local xOffset = 240 - (32 + iconSize + 12)
        if isLoading then
            return nil
        end

        local createElement = Roact.createElement
        local var3 = Interactable
        local tbl7 = {
            Size = UDim2.new(0, var2 + 8 + iconSize + 12, 0, 28),
            BackgroundColor3 = tbl6.Color,
            BackgroundTransparency = tbl6.Transparency,
            AutoButtonColor = false,
            BorderSizePixel = 0,
            LayoutOrder = 1,
            isDisabled = isDisabled,
            [Roact.Event.Activated] = not isLoading and onActivated or nil,
            onStateChanged = arg1.onStateChanged
        }
        local tbl8 = {
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
        local tbl9 = {
            Size = UDim2.new(0, textSizeX + 8 + iconSize + 12, 1, 0),
            ClipsDescendants = true,
            BackgroundTransparency = 1
        }

        local tbl10 = {
            UIListLayout = Roact.createElement("UIListLayout", {
                Padding = UDim.new(0, 4),
                SortOrder = Enum.SortOrder.LayoutOrder,
                FillDirection = Enum.FillDirection.Horizontal,
                VerticalAlignment = Enum.VerticalAlignment.Center,
                HorizontalAlignment = Enum.HorizontalAlignment.Center
            }),
            Icon = Roact.createElement(ImageSetLabel, {
                AnchorPoint = Vector2.new(0.5, 0.5),
                Size = UDim2.fromOffset(iconSize, iconSize),
                BackgroundTransparency = 1,
                LayoutOrder = 2,
                Image = icon,
                ImageColor3 = tbl4.Color,
                ImageTransparency = tbl4.Transparency
            }),
            TextArea = 0,
            BadgeFrame = 0,
            UISizeConstraint = 0
        }
        local var4

        if string.len(text) > 0 then
            local createElement3 = Roact.createElement
            local tbl11 = {
                Size = UDim2.fromOffset(textSizeX, yOffset),
                LayoutOrder = 3,
                BackgroundTransparency = 1
            }

            local tbl12 = {
                PillText = Roact.createElement(StyledTextLabel, {
                    text = text,
                    fontStyle = font.CaptionHeader,
                    colorStyle = colorStyle,
                    textTruncate = Enum.TextTruncate.AtEnd,
                    textXAlignment = Enum.TextXAlignment.Left,
                    textYAlignment = Enum.TextYAlignment.Center,
                    size = UDim2.fromOffset(xOffset, yOffset),
                    [Roact.Ref] = arg1.PillText
                }),
                Roact.createElement("UISizeConstraint", { MaxSize = Vector2.new(xOffset, 28) })
            }
            var4 = createElement3("Frame", tbl11, tbl12)
        else
            var4 = false
        end

        tbl10.TextArea = var4

        tbl10.BadgeFrame = Roact.createElement(
            "Frame",
            {
                Size = UDim2.fromOffset(12, 12),
                LayoutOrder = 4,
                BackgroundTransparency = 1
            },
            {
                Badge = Roact.createElement(Badge, { value = BadgeStates.isEmpty })
            }
        )
        tbl10.UISizeConstraint = Roact.createElement("UISizeConstraint", { MaxSize = Vector2.new(216, 28) })
        tbl8.Content = createElement2(str1, tbl9, tbl10)

        tbl8.UICorner = Roact.createElement("UICorner", { CornerRadius = UDim.new(1, 0) })

        tbl8.UISizeConstraint = Roact.createElement("UISizeConstraint", { MaxSize = Vector2.new(240, 28) })
        return createElement(var3, tbl7, tbl8)
            or Roact.createElement(Skeleton, { Size = UDim2.new(0, var2 + 4 + iconSize, 0, 28), radius = Radius.Circle })
    end)
end

return var1
