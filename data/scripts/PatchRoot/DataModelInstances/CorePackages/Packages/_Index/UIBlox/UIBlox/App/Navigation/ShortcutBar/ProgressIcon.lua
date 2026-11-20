-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:50:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent
local scriptParentParentParentParentParent = scriptParentParentParentParent.Parent

local React = require(scriptParentParentParentParentParent.React)
local useStyle = require(scriptParentParentParentParent.Core.Style.useStyle)
local ImageSetComponent = require(scriptParentParentParentParent.Core.ImageSet.ImageSetComponent)
local Images = require(scriptParentParentParentParentParent.UIBlox.App.ImageSet.Images)
local _ImagesTypes = require(scriptParentParentParent.ImageSet.ImagesTypes)
local _StyleTypes = require(scriptParentParentParentParent.App.Style.StyleTypes)

local function renderHalfCircle(tbl1, arg1)
    local layoutOrder = tbl1.layoutOrder
    local isLeft = tbl1.isLeft
    local rotation = tbl1.rotation
    local progressImage = tbl1.progressImage

    local iconDefault = arg1.Theme.IconDefault
    local divider = arg1.Theme.Divider

    local createElement = React.createElement
    local str1 = "Frame"
    local tbl2 = {
        LayoutOrder = layoutOrder,
        Size = UDim2.fromScale(0.5, 1),
        BorderSizePixel = 0,
        BackgroundTransparency = 1,
        ClipsDescendants = true
    }

    local tbl3 = {
        CircleImage = React.createElement(ImageSetComponent.Label, {
            Size = UDim2.fromScale(2, 1),
            AnchorPoint = if isLeft then nil else Vector2.new(0.5, 0),
            Image = progressImage,
            BackgroundTransparency = 1
        }, {
            UIGradient = React.createElement("UIGradient", {
                Rotation = rotation,
                Color = ColorSequence.new({
                    ColorSequenceKeypoint.new(0, iconDefault.Color),
                    ColorSequenceKeypoint.new(0.499, iconDefault.Color),
                    ColorSequenceKeypoint.new(0.5, divider.Color),
                    ColorSequenceKeypoint.new(1, divider.Color)
                }),
                Transparency = NumberSequence.new({
                    NumberSequenceKeypoint.new(0, iconDefault.Transparency),
                    NumberSequenceKeypoint.new(0.499, iconDefault.Transparency),
                    NumberSequenceKeypoint.new(0.5, divider.Transparency),
                    NumberSequenceKeypoint.new(1, divider.Transparency)
                })
            })
        })
    }
    return createElement(str1, tbl2, tbl3)
end

local function ProgressIcon(tbl1)
    local progress = tbl1.progress
    local isHolding = tbl1.isHolding
    local image = if isHolding then tbl1.iconHolding else tbl1.icon
    local progressImage = if isHolding then Images["icons/controls/keys/hold_button_assets/hold_Pressed_RadialFill"] else Images["icons/controls/keys/hold_button_assets/hold_Unpressed_RadialFill"]
    local var1 = if isHolding then Images["icons/controls/keys/hold_button_assets/hold_Pressed_Arrow"] else Images["icons/controls/keys/hold_button_assets/hold_Unpressed_Arrow"]
    local var4 = useStyle()

    local rotation = React.useMemo(function()
        return progress:map(function(arg1): number
            return math.clamp((arg1 or 0) * 314 + 23, 180, 337)
        end)
    end, { progress })

    local var2 = React.useMemo(function()
        return progress:map(function(arg1): number
            return math.clamp((arg1 or 0) * 314 + 23, 23, 180)
        end)
    end, { progress })

    local imageTransparency = React.useMemo(function()
        return progress:map(function(num1: number?): number
            if not num1 then
                return 0
            end

            return math.clamp(0.8 - num1 * 0.8, 0, 0.8)
        end)
    end, { progress })

    return React.createElement(
        "Frame",
        {
            Size = UDim2.fromScale(1, 1),
            BorderSizePixel = 0,
            BackgroundTransparency = 1
        },
        {
            Progress = React.createElement(
                "Frame",
                {
                    Size = UDim2.fromScale(1, 1),
                    BorderSizePixel = 0,
                    BackgroundTransparency = 1,
                    ZIndex = 1
                },
                {
                    UIListLayout = React.createElement("UIListLayout", {
                        SortOrder = Enum.SortOrder.LayoutOrder,
                        FillDirection = Enum.FillDirection.Horizontal,
                        VerticalAlignment = Enum.VerticalAlignment.Center
                    }),
                    Left = renderHalfCircle({ layoutOrder = 1, isLeft = true, progressImage = progressImage, rotation = rotation }, var4),
                    Right = renderHalfCircle({ layoutOrder = 2, progressImage = progressImage, rotation = var2 }, var4)
                }
            ),
            Icon = React.createElement(ImageSetComponent.Label, {
                Size = UDim2.fromScale(1, 1),
                AnchorPoint = Vector2.new(0.5, 0.5),
                Position = UDim2.fromScale(0.5, 0.5),
                Image = image,
                ImageColor3 = var4.Theme.IconEmphasis.Color,
                ImageTransparency = imageTransparency,
                BackgroundTransparency = 1,
                ZIndex = 2
            }),
            Arrow = React.createElement(ImageSetComponent.Label, {
                Size = UDim2.fromScale(1, 1),
                AnchorPoint = Vector2.new(0.5, 0),
                Position = UDim2.fromScale(0.5, 0),
                Image = var1,
                ImageColor3 = var4.Theme.IconEmphasis.Color,
                ImageTransparency = 0,
                BackgroundTransparency = 1,
                ZIndex = 3
            })
        }
    )
end

return ProgressIcon
