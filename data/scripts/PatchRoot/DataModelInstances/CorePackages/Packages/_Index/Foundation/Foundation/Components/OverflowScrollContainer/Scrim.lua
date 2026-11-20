-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T05:11:35Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local _Otter = require(FoundationParent.Otter)
local React = require(FoundationParent.React)
local ReactOtter = require(FoundationParent.ReactOtter)

local BackgroundStyleContext = require(Foundation.Providers.Style.BackgroundStyleContext)
local Icon = require(Foundation.Components.Icon)
local _InputSize = require(Foundation.Enums.InputSize)
local Tokens = require(Foundation.Providers.Style.Tokens)
local _Types = require(Foundation.Components.Types)
local View = require(Foundation.Components.View)
local useBackgroundStyle = BackgroundStyleContext.useBackgroundStyle
local StateLayerAffordance = require(Foundation.Enums.StateLayerAffordance)
local useScrimVariants = require(script.Parent.useScrimVariants)
local useTokens = require(Foundation.Providers.Style.useTokens)
local withCommonProps = require(Foundation.Utility.withCommonProps)

local tbl1 = {
    easingStyle = Tokens.defaultTokens.Ease.StandardOut,
    duration = Tokens.defaultTokens.Time.Time_200
}

local function lerpNumberSequence(gradient, hoverGradient, num1: number): NumberSequence
    local keypoints = gradient.Keypoints
    local keypoints2 = hoverGradient.Keypoints
    local keypoints3 = ({})
    for k, keypoint in keypoints do
        local keypoint2 = keypoints2[k]
        keypoints3[k] = NumberSequenceKeypoint.new(
            keypoint.Time + (keypoint2.Time - keypoint.Time) * num1,
            keypoint.Value + (keypoint2.Value - keypoint.Value) * num1
        )
    end
    return NumberSequence.new(keypoints3)
end

local function Scrim(arg1)
    local var1 = useTokens()
    local backgroundStyle = useBackgroundStyle()
    local var3 = useScrimVariants(var1, arg1.alignment, arg1.preferredInput)

    local bool1 = arg1.alignment == Enum.HorizontalAlignment.Right
    local bool2 = arg1.preferredInput == Enum.PreferredInput.Touch or arg1.preferredInput == Enum.PreferredInput.Gamepad

    local var4, var5 = ReactOtter.useAnimatedBinding(if arg1.isHovered then 1 else 0)
    React.useEffect(function()
        var5(ReactOtter.ease(if arg1.isHovered then 1 else 0, tbl1))
    end, { arg1.isHovered })

    local var6 = var4:map(function(arg2): UDim2
        if bool2 then
            return UDim2.fromScale(0.5, 0.5)
        end
        return UDim2.fromScale(0.5 + (if bool1 then 1 else -1) * (1 - arg2), 0.5)
    end)

    local var7 = arg1.rowHeight:map(function(num1: number): UDim2
        return UDim2.new(0, num1 + var3.fade, 1, 0)
    end)

    local var8 = var4:map(function(arg2)
        if bool2 then
            return var3.hoverGradient
        end
        return lerpNumberSequence(var3.gradient, var3.hoverGradient, arg2)
    end)

    local groupTransparency, var10 = ReactOtter.useAnimatedBinding(if arg1.isVisible then 0 else 1)
    React.useEffect(function()
        var10(ReactOtter.ease(if arg1.isVisible then 0 else 1, tbl1))
    end, { arg1.isVisible })

    return React.createElement(View, withCommonProps(arg1, { Size = var7, GroupTransparency = groupTransparency }), {
        Scrim = React.createElement(View, {
            tag = "size-full",
            backgroundStyle = backgroundStyle,
            onActivated = arg1.onActivated,
            stateLayer = {
                affordance = StateLayerAffordance.None
            },
            onStateChanged = arg1.onStateChanged,
            isDisabled = not arg1.isVisible,
            selection = { Selectable = false },
            testId = `{arg1.testId}--button`
        }, {
            Gradient = React.createElement("UIGradient", { Transparency = var8 }),
            DirectionIcon = React.createElement(View, {
                tag = var3.iconAlignmentTag,
                Size = UDim2.fromScale(0, 1),
                aspectRatio = {
                    AspectRatio = 1,
                    AspectType = Enum.AspectType.ScaleWithParentSize,
                    DominantAxis = Enum.DominantAxis.Height
                },
                ZIndex = 2
            }, {
                Icon = React.createElement(Icon, {
                    AnchorPoint = Vector2.new(0.5, 0.5),
                    Position = var6,
                    size = arg1.size,
                    name = var3.directionIcon,
                    testId = `{arg1.testId}--direction-indicator`
                })
            })
        })
    })
end

return Scrim
