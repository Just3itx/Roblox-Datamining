-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:31:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent
local scriptParentParentParentParentParent = scriptParentParentParentParent.Parent
local Core = scriptParentParentParentParent.Core

local React = require(scriptParentParentParentParentParent.React)
local Foundation = require(scriptParentParentParentParentParent.Foundation)

local ControlState = require(Core.Control.Enum.ControlState)
local getContentStyle = require(Core.Button.getContentStyle)

local Interactable = require(Core.Control.Interactable)

local useStyle = require(Core.Style.useStyle)
local ImageSetComponent = require(Core.ImageSet.ImageSetComponent)
local Skeleton = Foundation.Skeleton
local GenericTextLabel = require(Core.Text.GenericTextLabel.GenericTextLabel)
local Images = require(scriptParentParentParent.ImageSet.Images)
local IconSize = require(scriptParentParentParent.ImageSet.Enum.IconSize)
local getIconSize = require(scriptParentParentParent.ImageSet.getIconSize)

local component_assetsCircle_9 = Images["component_assets/circle_9"]
local component_assetsCircle_9_stroke_1 = Images["component_assets/circle_9_stroke_1"]

local tbl1 = {
    [ControlState.Default] = "SecondaryDefault",
    [ControlState.Hover] = "SecondaryOnHover"
}

local tbl2 = {
    [ControlState.Default] = "SecondaryDefault",
    [ControlState.Hover] = "SecondaryDefault"
}

local tbl3 = {
    [ControlState.Default] = "TextDefault",
    [ControlState.Hover] = "TextEmphasis"
}

local tbl4 = {
    [ControlState.Default] = "TextEmphasis",
    [ControlState.Hover] = "TextEmphasis"
}

local tbl5 = {
    [ControlState.Default] = "BackgroundMuted"
}

local tbl6 = {
    [ControlState.Default] = "PlaceHolder"
}

local tbl7 = {
    [ControlState.Default] = "PlaceHolder"
}

local tbl8 = {
    [ControlState.Default] = "TextEmphasis"
}

local function TileSlot(tbl9)
    local var1, var2 = React.useState(ControlState.Initialize)
    local var3, var4 = React.useState(false)

    local var5 = React.useCallback(function()
        tbl9.onActivated(tbl9.index)
    end, { tbl9.onActivated, tbl9.index })

    local onStateChanged = React.useCallback(function(arg1, hover)
        var2(hover)

        if hover == ControlState.Hover then
            var4(true)
        else
            var4(false)
        end

        if tbl9.onStateChanged then
            tbl9.onStateChanged(arg1, hover)
        end
    end, { tbl9.onStateChanged })

    local var7 = useStyle()

    local isDisabled = tbl9.isDisabled
    local isLoading = tbl9.isLoading
    if isDisabled then
        var1 = ControlState.Disabled or var1
    end

    local isSelected = tbl9.isSelected

    local contentStyle = isSelected and getContentStyle(tbl2, var1, var7) or getContentStyle(tbl1, var1, var7)
    local colorStyle = isSelected and getContentStyle(tbl4, var1, var7) or getContentStyle(tbl3, var1, var7)
    local contentStyle3 = getContentStyle(tbl8, var1, var7)

    local contentStyle4 = isSelected and getContentStyle(tbl6, var1, var7) or getContentStyle(tbl5, var1, var7)
    local contentStyle5 = getContentStyle(tbl7, var1, var7)
    local subHeader1 = var7.Font.SubHeader1
    local thumbnail = tbl9.thumbnail

    local bool1 = tbl9.thumbnail ~= nil
    local bool2 = tbl9.displayText ~= nil
    local var8 = isDisabled or isLoading
    local var9 = not var8 and (var3 or isSelected)
    local createElement = React.createElement
    local var10 = Interactable
    local tbl10 = {
        Size = UDim2.fromOffset(48, 48),
        Position = tbl9.position or UDim2.fromScale(0, 0),
        BackgroundTransparency = 1,
        onStateChanged = onStateChanged,
        [React.Event.Activated] = if var8 then nil else var5 or nil
    }
    local tbl11 = { Button = 0 }
    local createElement2 = React.createElement
    local str1 = "Frame"
    local tbl12 = {
        Size = UDim2.fromScale(1, 1),
        BackgroundTransparency = 1
    }
    local tbl13 = {
        Background = React.createElement(ImageSetComponent.Label, {
            Size = UDim2.fromScale(1, 1),
            Position = UDim2.fromScale(0, 0),
            BackgroundTransparency = 1,
            Image = component_assetsCircle_9,
            ImageColor3 = bool2 and contentStyle4.Color or contentStyle5.Color,
            ImageTransparency = bool2 and contentStyle4.Transparency or contentStyle5.Transparency,
            ScaleType = Enum.ScaleType.Slice,
            SliceCenter = Rect.new(4, 4, 5, 5),
            ZIndex = 1
        }),
        Border = 0,
        ButtonContentLayer = 0
    }
    local element

    if var9 then
        element = React.createElement(ImageSetComponent.Label, {
            Size = UDim2.fromScale(1, 1),
            Position = UDim2.fromScale(0, 0),
            BackgroundTransparency = 1,
            Image = component_assetsCircle_9_stroke_1,
            ImageColor3 = contentStyle.Color,
            ImageTransparency = contentStyle.Transparency,
            ScaleType = Enum.ScaleType.Slice,
            SliceCenter = Rect.new(4, 4, 5, 5),
            ZIndex = 2
        })
    else
        element = nil
    end

    tbl13.Border = element

    local createElement3 = React.createElement
    local str2 = "Frame"
    local tbl14 = {
        Size = UDim2.fromScale(1, 1),
        Position = UDim2.fromScale(0, 0),
        BackgroundTransparency = 1,
        ZIndex = 3
    }

    local tbl15 = { Thumbnail = 0, Text = 0, LoadingShimmer = 0 }
    local element2

    if isLoading or not bool1 then
        element2 = nil
    else
        element2 = React.createElement(ImageSetComponent.Label, {
            Size = UDim2.fromOffset(getIconSize(IconSize.Medium), getIconSize(IconSize.Medium)),
            BackgroundTransparency = 1,
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.fromScale(0.5, 0.5),
            Image = thumbnail,
            ImageColor3 = contentStyle3.Color,
            ImageTransparency = contentStyle3.Transparency,
            ZIndex = 3
        })
    end

    tbl15.Thumbnail = element2

    tbl15.Text = if isLoading or not bool2 then nil else React.createElement(GenericTextLabel, {
        Size = UDim2.new(1, -24, 1, -24),
        BackgroundTransparency = 1,
        Text = tbl9.displayText,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
        fontStyle = subHeader1,
        colorStyle = colorStyle,
        ZIndex = 3
    })

    tbl15.LoadingShimmer = if isLoading then React.createElement(Skeleton, { Size = UDim2.fromScale(1, 1) }) else nil
    tbl13.ButtonContentLayer = createElement3(str2, tbl14, tbl15)
    tbl11.Button = createElement2(str1, tbl12, tbl13)
    return createElement(var10, tbl10, tbl11)
end

return TileSlot
