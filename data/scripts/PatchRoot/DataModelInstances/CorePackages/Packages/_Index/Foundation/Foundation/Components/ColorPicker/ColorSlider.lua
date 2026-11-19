-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T07:40:30Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent
local React = require(FoundationParent.React)

local _Types = require(Foundation.Components.Types)
local useTokens = require(Foundation.Providers.Style.useTokens)

local Image = require(Foundation.Components.Image)
local Knob = require(Foundation.Components.Knob)
local Slider = require(Foundation.Components.Slider)
local View = require(Foundation.Components.View)

local ColorSliderType = require(Foundation.Enums.ColorSliderType)
local InputSize = require(Foundation.Enums.InputSize)
local SliderVariant = require(Foundation.Enums.SliderVariant)
local Visibility = require(Foundation.Enums.Visibility)

local withCommonProps = require(Foundation.Utility.withCommonProps)
local withDefaults = require(Foundation.Utility.withDefaults)

local colorSequence = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.new(1, 0, 0)),
    ColorSequenceKeypoint.new(1 / 6, Color3.new(1, 1, 0)),
    ColorSequenceKeypoint.new(1 / 3, Color3.new(0, 1, 0)),
    ColorSequenceKeypoint.new(0.5, Color3.new(0, 1, 1)),
    ColorSequenceKeypoint.new(2 / 3, Color3.new(0, 0, 1)),
    ColorSequenceKeypoint.new(5 / 6, Color3.new(1, 0, 1)),
    ColorSequenceKeypoint.new(1, Color3.new(1, 0, 0))
})

local function createAlphaGradient(color: Color3): ColorSequence
    return ColorSequence.new({ ColorSequenceKeypoint.new(0, color), ColorSequenceKeypoint.new(1, color) })
end

local tbl1 = {
    sliderType = ColorSliderType.Hue,
    baseColor = React.createBinding(Color3.new(1, 1, 1))
}

local function ColorSlider(arg1)
    local var1 = withDefaults(arg1, tbl1)
    local var2 = useTokens()

    local sliderType = var1.sliderType
    local value = var1.value
    local onValueChanged = var1.onValueChanged
    local var3 = if sliderType == ColorSliderType.Hue then colorSequence else var1.baseColor:map(createAlphaGradient)
    local var4 = nil
    local var5 = nil
    if sliderType == ColorSliderType.Hue then
        var4 = value:map(function(hue: number)
            return {
                Color3 = Color3.fromHSV(hue, 1, 1),
                Transparency = 0
            }
        end)
    elseif sliderType == ColorSliderType.Alpha then
        var5 = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(1, 0) })

        var4 = React.joinBindings({ baseColor = var1.baseColor, value = value }):map(function(arg2)
            return {
                Color3 = arg2.baseColor,
                Transparency = 1 - arg2.value
            }
        end)
    end

    local bool1 = sliderType == ColorSliderType.Alpha

    local slider = React.createElement(Slider, {
        value = value,
        onValueChanged = onValueChanged,
        onDragStarted = var1.onDragStarted,
        onDragEnded = var1.onDragEnded,
        size = InputSize.Medium,
        variant = SliderVariant.Utility,
        isContained = true,
        width = UDim.new(1, 0),
        knobVisibility = Visibility.Always,
        knob = React.createElement(Knob, {
            size = InputSize.Small,
            style = var4,
            stroke = {
                Color = var2.Color.System.Contrast.Color3,
                Thickness = var2.Stroke.Thicker,
                Transparency = var2.Color.System.Contrast.Transparency
            },
            hasShadow = true
        })
    })

    if not bool1 then
        return React.createElement(
            View,
            withCommonProps(var1, {
                tag = "row align-y-center size-full-300 stroke-standard stroke-emphasis radius-circle",
                backgroundStyle = var2.Color.Extended.White.White_100
            }),
            {
                Gradient = React.createElement("UIGradient", { Color = var3 }),
                Slider = slider
            }
        )
    end

    return React.createElement(View, withCommonProps(var1, { tag = "size-full-300" }), {
        Background = React.createElement(
            View,
            {
                tag = "size-full stroke-standard stroke-emphasis radius-circle",
                ClipsDescendants = true,
                ZIndex = 1
            },
            {
                Checkerboard = React.createElement(Image, {
                    Image = "component_assets/checkerboard_12",
                    ScaleType = Enum.ScaleType.Tile,
                    TileSize = UDim2.fromOffset(var2.Size.Size_300, var2.Size.Size_300),
                    cornerRadius = UDim.new(1, 0),
                    tag = "size-full",
                    ZIndex = 1
                }),
                GradientOverlay = React.createElement(
                    View,
                    {
                        tag = "size-full",
                        backgroundStyle = {
                            Color3 = Color3.new(1, 1, 1),
                            Transparency = 0
                        },
                        cornerRadius = UDim.new(1, 0),
                        ZIndex = 2
                    },
                    {
                        Gradient = React.createElement("UIGradient", { Color = var3, Transparency = var5 })
                    }
                )
            }
        ),
        SliderContainer = React.createElement(View, { tag = "row align-y-center size-full", ZIndex = 2 }, { Slider = slider })
    })
end

return ColorSlider
