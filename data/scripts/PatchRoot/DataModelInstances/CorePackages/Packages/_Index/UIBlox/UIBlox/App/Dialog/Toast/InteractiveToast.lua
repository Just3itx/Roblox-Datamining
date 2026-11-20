-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:38:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local scriptParentParentParent = scriptParent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent
local scriptParentParentParentParentParent = scriptParentParentParentParent.Parent

local Roact = require(scriptParentParentParentParentParent.Roact)
local t = require(scriptParentParentParentParentParent.t)

local ImageSetComponent = require(scriptParentParentParentParent.Core.ImageSet.ImageSetComponent)
local Images = require(scriptParentParentParentParent.App.ImageSet.Images)
local withStyle = require(scriptParentParentParentParent.Core.Style.withStyle)
local SpringAnimatedItem = require(scriptParentParentParentParent.Utility.SpringAnimatedItem)
local ButtonType = require(scriptParentParentParent.Button.Enum.ButtonType)

local ToastFrame = require(scriptParent.ToastFrame)
local ToastIcon = require(scriptParent.ToastIcon)
local ToastText = require(scriptParent.ToastText)

local springOptions = { dampingRatio = 1, frequency = 4 }

local component_assetsCircle_21 = Images["component_assets/circle_21"]
local rect = Rect.new(10, 10, 11, 11)

local var1 = Roact.PureComponent:extend("InteractiveToast")

var1.validateProps = t.strictInterface({
    anchorPoint = t.optional(t.Vector2),
    buttonProps = t.optional(
        t.strictInterface({
            buttonDimensions = t.Vector2,
            buttonText = t.string,
            onActivated = t.callback,
            buttonType = t.optional(ButtonType.isEnumValue)
        })
    ),
    iconProps = t.optional(ToastIcon.validateProps),
    iconChildren = t.optional(t.table),
    isCompact = t.optional(t.boolean),
    layoutOrder = t.optional(t.integer),
    padding = t.optional(t.numberMin(0)),
    position = t.optional(t.UDim2),
    pressed = t.optional(t.boolean),
    pressedScale = t.number,
    size = t.UDim2,
    subtitleTextProps = t.optional(ToastText.validateProps),
    textFrameSize = t.optional(t.UDim2),
    titleTextProps = ToastText.validateProps
})

var1.defaultProps = {
    anchorPoint = Vector2.new(0.5, 0.5),
    layoutOrder = 1,
    position = UDim2.new(0.5, 0, 0.5, 0),
    pressedScale = 0.95,
    size = UDim2.new(1, 0, 1, 0)
}

function var1.render(arg1)
    return withStyle(function(arg2)
        local theme = arg2.Theme

        return Roact.createElement(ImageSetComponent.Label, {
            AnchorPoint = arg1.props.anchorPoint,
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            Image = component_assetsCircle_21,
            ImageColor3 = theme.BackgroundUIDefault.Color,
            ImageTransparency = theme.BackgroundUIDefault.Transparency,
            LayoutOrder = arg1.props.layoutOrder,
            Position = arg1.props.position,
            ScaleType = Enum.ScaleType.Slice,
            Size = arg1.props.size,
            SliceCenter = rect
        }, {
            Scaler = Roact.createElement(SpringAnimatedItem.AnimatedUIScale, {
                springOptions = springOptions,
                animatedValues = {
                    scale = arg1.props.pressed and arg1.props.pressedScale or 1
                },
                mapValuesToProps = function(arg3)
                    return {
                        Scale = arg3.scale
                    }
                end
            }),
            ToastFrame = Roact.createElement(ToastFrame, {
                buttonProps = arg1.props.buttonProps,
                iconProps = arg1.props.iconProps,
                iconChildren = arg1.props.iconChildren,
                isCompact = arg1.props.isCompact,
                padding = arg1.props.padding,
                subtitleTextProps = arg1.props.subtitleTextProps,
                textFrameSize = arg1.props.textFrameSize,
                titleTextProps = arg1.props.titleTextProps
            })
        })
    end)
end

return var1
