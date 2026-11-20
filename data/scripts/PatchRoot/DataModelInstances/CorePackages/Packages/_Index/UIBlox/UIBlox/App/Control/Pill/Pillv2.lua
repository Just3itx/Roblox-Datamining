-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:31:38Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent
local scriptParentParentParentParentParent = scriptParentParentParentParent.Parent
local Core = scriptParentParentParentParent.Core

local Cryo = require(scriptParentParentParentParentParent.Cryo)
local React = require(scriptParentParentParentParentParent.React)
local Foundation = require(scriptParentParentParentParentParent.Foundation)

local Images = require(scriptParentParentParent.ImageSet.Images)
local IconSize = require(scriptParentParentParent.ImageSet.Enum.IconSize)
local getIconSize = require(scriptParentParentParent.ImageSet.getIconSize)
local useSelectionCursor = require(scriptParentParentParent.SelectionImage.useSelectionCursor)
local CursorKind = require(scriptParentParentParent.SelectionImage.CursorKind)
local useStyle = require(Core.Style.useStyle)
local ControlState = require(Core.Control.Enum.ControlState)
local Interactable = require(Core.Control.Interactable)
local useControlState = require(Core.Control.useControlState)
local getContentStyle = require(Core.Button.getContentStyle)

local GenericTextLabel = require(Core.Text.GenericTextLabel.GenericTextLabel)
local ImageSetComponent = require(scriptParentParentParentParent.Core.ImageSet.ImageSetComponent)
local Skeleton = Foundation.Skeleton
local Radius = Foundation.Enums.Radius
local GetTextSize = require(scriptParentParentParentParent.Core.Text.GetTextSize)
local GetFontFromFontStyle = require(scriptParentParentParentParent.Core.Text.GetFontFromFontStyle)

local tbl1 = {
    hasBorder = false,
    isDisabled = false,
    isLoading = false,
    isSelected = false,
    layoutOrder = 1,
    text = ""
}

local tbl2 = {
    [ControlState.Default] = "SystemPrimaryContent",
    [ControlState.Hover] = "SystemPrimaryContent"
}

local tbl3 = {
    [ControlState.Default] = "TextDefault",
    [ControlState.Hover] = "TextEmphasis"
}

local tbl4 = {
    [ControlState.Default] = "SystemPrimaryContent",
    [ControlState.Hover] = "SystemPrimaryContent"
}

local tbl5 = {
    [ControlState.Default] = "BackgroundUIDefault",
    [ControlState.Hover] = "BackgroundUIDefault"
}

local tbl6 = {
    [ControlState.Default] = "SystemPrimaryDefault",
    [ControlState.Hover] = "SystemPrimaryOnHover"
}

local tbl7 = {
    [ControlState.Default] = "BackgroundOnHover",
    [ControlState.Hover] = "BackgroundOnHover"
}

local function Pillv2(tbl8)
    local var1 = Cryo.Dictionary.join(tbl1, tbl8)
    local text = var1.text

    local var2, var3 = useControlState()
    local onStateChanged = React.useCallback(function(arg1, arg2)
        if var1.onStateChanged then
            var1.onStateChanged(arg1, arg2)
        end
        var3(arg1, arg2)
    end, { var1.onStateChanged })

    local var5 = useStyle()
    local font = var5.Font

    local selectionImageObject = useSelectionCursor(CursorKind.SmallPill)
    local tbl9 = if var1.isSelected then tbl4 else tbl3
    local tbl10 = if var1.isSelected then tbl6 else tbl5
    local contentStyle = getContentStyle(tbl2, var2, var5)
    local colorStyle = getContentStyle(tbl9, var2, var5)
    local contentStyle3 = getContentStyle(tbl10, var2, var5)
    local contentStyle4 = getContentStyle(tbl7, var2, var5)

    local iconSize = getIconSize(IconSize.Small)
    local baseSize = font.BaseSize
    local yOffset = font.CaptionHeader.RelativeSize * baseSize

    local textSizeX = GetTextSize(text, yOffset, GetFontFromFontStyle(font.CaptionHeader), Vector2.new(10000, 10000)).X

    local xOffset = textSizeX + 24
    local num1 = 216
    if var1.isSelected then
        local var7 = 4 + iconSize
        xOffset += var7
        num1 -= var7
    end

    if var1.isLoading then
        return React.createElement(
            Skeleton,
            {
                LayoutOrder = var1.layoutOrder,
                Size = UDim2.fromOffset(xOffset, 28),
                radius = Radius.Circle
            }
        )
    end
    local bool1 = not var1.isSelected and var2 == ControlState.Hover

    local createElement = React.createElement
    local var7 = Interactable
    local tbl11 = {
        Size = UDim2.new(0, xOffset, 0, 28),
        BackgroundColor3 = contentStyle3.Color,
        BackgroundTransparency = contentStyle3.Transparency,
        ImageColor3 = contentStyle3.Color,
        ImageTransparency = contentStyle3.Transparency,
        AutoButtonColor = false,
        BorderSizePixel = 0,
        LayoutOrder = var1.layoutOrder,
        ScaleType = Enum.ScaleType.Slice,
        isDisabled = var1.isDisabled,
        SelectionImageObject = selectionImageObject,
        [React.Event.Activated] = if var1.isLoading then nil else var1.onActivated,
        onStateChanged = onStateChanged,
        ref = var1.controlRef,
        NextSelectionLeft = var1.NextSelectionLeft,
        NextSelectionRight = var1.NextSelectionRight,
        NextSelectionUp = var1.NextSelectionUp,
        NextSelectionDown = var1.NextSelectionDown
    }
    local tbl12 = {
        UICorner = React.createElement("UICorner", { CornerRadius = UDim.new(1, 0) }),
        UISizeConstraint = React.createElement("UISizeConstraint", { MinSize = Vector2.new(28, 28), MaxSize = Vector2.new(240, 28) }),
        BackgroundLayer2 = 0
    }
    local createElement2 = React.createElement
    local str1 = "Frame"
    local tbl13 = {
        Size = UDim2.fromScale(1, 1),
        BorderSizePixel = 0,
        BackgroundColor3 = contentStyle4.Color,
        BackgroundTransparency = if bool1 then contentStyle4.Transparency else 1
    }
    local tbl14 = {
        UICorner = React.createElement("UICorner", { CornerRadius = UDim.new(1, 0) }),
        UIStroke = if var1.hasBorder then React.createElement(
            "UIStroke",
            {
                Color = var5.Theme.Divider.Color,
                Transparency = var5.Theme.Divider.Transparency,
                Thickness = 1
            }
        ) else nil,
        Content = 0
    }

    local createElement3 = React.createElement
    local str2 = "Frame"
    local tbl15 = {
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.new(0, textSizeX + 4 + iconSize, 1, 0),
        ClipsDescendants = true,
        BackgroundTransparency = 1
    }

    local tbl16 = {
        UIListLayout = React.createElement("UIListLayout", {
            Padding = UDim.new(0, 4),
            FillDirection = Enum.FillDirection.Horizontal,
            SortOrder = Enum.SortOrder.LayoutOrder,
            VerticalAlignment = Enum.VerticalAlignment.Center,
            HorizontalAlignment = Enum.HorizontalAlignment.Center
        }),
        TextArea = 0,
        CloseIcon = 0,
        UISizeConstraint = 0
    }
    local element

    if string.len(text) > 0 then
        element = React.createElement(
            "Frame",
            {
                Size = UDim2.fromOffset(textSizeX, yOffset),
                LayoutOrder = 1,
                BackgroundTransparency = 1
            },
            {
                PillText = React.createElement(GenericTextLabel, {
                    Text = text,
                    BackgroundTransparency = 1,
                    fontStyle = font.CaptionHeader,
                    colorStyle = colorStyle,
                    TextTruncate = Enum.TextTruncate.AtEnd,
                    Size = UDim2.fromOffset(num1, yOffset),
                    TextXAlignment = Enum.TextXAlignment.Left,
                    TextYAlignment = Enum.TextYAlignment.Center
                }),
                React.createElement("UISizeConstraint", { MaxSize = Vector2.new(num1, 28) })
            }
        )
    else
        element = false
    end

    tbl16.TextArea = element

    tbl16.CloseIcon = var1.isSelected
        and React.createElement(ImageSetComponent.Label, {
            LayoutOrder = 2,
            AnchorPoint = Vector2.new(0.5, 0.5),
            Size = UDim2.fromOffset(iconSize, iconSize),
            BackgroundTransparency = 1,
            Image = Images["icons/navigation/close_small"],
            ImageColor3 = contentStyle.Color,
            ImageTransparency = contentStyle.Transparency
        })
    tbl16.UISizeConstraint = React.createElement("UISizeConstraint", { MaxSize = Vector2.new(216, 28) })
    tbl14.Content = createElement3(str2, tbl15, tbl16)
    tbl12.BackgroundLayer2 = createElement2(str1, tbl13, tbl14)
    return createElement(var7, tbl11, tbl12)
end

return React.forwardRef(function(arg1, controlRef)
    return React.createElement(Pillv2, Cryo.Dictionary.join(arg1, { controlRef = controlRef }))
end)
