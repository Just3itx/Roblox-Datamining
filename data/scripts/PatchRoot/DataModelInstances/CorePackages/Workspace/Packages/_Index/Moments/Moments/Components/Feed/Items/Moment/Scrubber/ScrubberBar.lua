-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:20:37Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsParent = script:FindFirstAncestor("Moments").Parent

local Foundation = require(MomentsParent.Foundation)
local React = require(MomentsParent.React)
local MomentsCommon = require(MomentsParent.MomentsCommon)
local ReactOtter = require(MomentsParent.ReactOtter)

local View = Foundation.View
local useTokens = Foundation.Hooks.useTokens

return React.memo(function(tbl1) -- name: Scrubber
    local var1 = useTokens()

    local var2 = tbl1.isHovering or tbl1.isPressed

    local var3, var4 = ReactOtter.useAnimatedBinding(0)
    React.useEffect(function()
        var4(
            ReactOtter.ease(if var2 then 1 else 0, { duration = if var2 then 0.12 else 0.08, easingStyle = Enum.EasingStyle.Quad })
        )
    end, { var2 })

    local backgroundStyle = var3:map(function(num1: number)
        return {
            Color3 = MomentsCommon.Utils.Oklab.lerp(var1.Color.System.Neutral.Color3, var1.Color.System.Emphasis.Color3, num1),
            Transparency = math.lerp(var1.Color.System.Neutral.Transparency, var1.Color.System.Emphasis.Transparency, num1)
        }
    end)

    local var6 = var3:map(function(num1: number): UDim2
        local yOffset = math.lerp(var1.Size.Size_100, var1.Size.Size_150, num1)
        return UDim2.new(1, 0, 0, yOffset)
    end)

    local var7 = var3:map(function(num1: number): UDim2
        local num2 = math.lerp(0, var1.Size.Size_300, num1)
        return UDim2.fromOffset(num2, num2)
    end)

    return React.createElement(
        View,
        {
            tag = "position-center-center anchor-center-center radius-circle bg-shift-100",
            Size = var6
        },
        {
            ProgressSegment = React.createElement(View, {
                tag = "radius-circle clip",
                Size = tbl1.progressRatio:map(function(xScale: number): UDim2
                    return UDim2.fromScale(xScale, 1)
                end),
                backgroundStyle = backgroundStyle
            }, {
                EndCap = React.createElement(
                    View,
                    {
                        tag = "position-center-right anchor-center-right size-250-full",
                        backgroundStyle = backgroundStyle
                    }
                )
            }),
            Handle = React.createElement(View, {
                tag = "anchor-center-center radius-circle bg-contrast",
                Size = var7,
                Position = tbl1.progressRatio:map(function(xScale: number): UDim2
                    return UDim2.fromScale(xScale, 0.5)
                end),
                ZIndex = 2
            })
        }
    )
end)
