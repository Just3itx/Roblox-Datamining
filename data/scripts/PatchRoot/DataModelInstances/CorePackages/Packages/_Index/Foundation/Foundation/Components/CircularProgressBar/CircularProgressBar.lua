-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T07:31:14Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local React = require(FoundationParent.React)

local Image = require(Foundation.Components.Image)
local _Types = require(Foundation.Components.Types)
local View = require(Foundation.Components.View)
local useTokens = require(Foundation.Providers.Style.useTokens)
local withCommonProps = require(Foundation.Utility.withCommonProps)
local withDefaults = require(Foundation.Utility.withDefaults)

local tbl1 = { testId = "--foundation-circular-progress-bar" }

return React.memo(React.forwardRef(function(arg1, ref) -- name: CircularProgressBar
    local var1 = withDefaults(arg1, tbl1)
    local var2 = useTokens()

    local numberSequence = NumberSequence.new({
        NumberSequenceKeypoint.new(0, var2.Color.Content.Emphasis.Transparency),
        NumberSequenceKeypoint.new(0.4999, var2.Color.Content.Emphasis.Transparency),
        NumberSequenceKeypoint.new(0.5, var2.Color.Content.Muted.Transparency),
        NumberSequenceKeypoint.new(1, var2.Color.Content.Muted.Transparency)
    })

    local colorSequence = ColorSequence.new({
        ColorSequenceKeypoint.new(0, var2.Color.Content.Emphasis.Color3),
        ColorSequenceKeypoint.new(0.4999, var2.Color.Content.Emphasis.Color3),
        ColorSequenceKeypoint.new(0.5, var2.Color.Content.Muted.Color3),
        ColorSequenceKeypoint.new(1, var2.Color.Content.Muted.Color3)
    })

    return React.createElement(View, withCommonProps(var1, { tag = "size-full-full", ref = ref }), {
        LeftGradient = React.createElement(View, {
            Size = UDim2.fromScale(0.5, 1),
            tag = "position-top-left clip"
        }, {
            Image = React.createElement(Image, {
                Image = "rbxasset://textures/ui/Controls/RadialFill.png",
                Size = UDim2.fromScale(2, 1),
                tag = "position-top-left content-emphasis",
                testId = `{var1.testId}--left-gradient`
            }, {
                Gradient = React.createElement("UIGradient", {
                    Transparency = numberSequence,
                    Color = colorSequence,
                    Rotation = var1.progress:map(function(num1: number): number
                        return math.clamp(num1 * 360, 180, 360)
                    end)
                })
            })
        }),
        RightGradient = React.createElement(View, {
            Size = UDim2.fromScale(0.5, 1),
            tag = "position-top-center clip"
        }, {
            Image = React.createElement(Image, {
                Image = "rbxasset://textures/ui/Controls/RadialFill.png",
                Size = UDim2.fromScale(2, 1),
                Position = UDim2.fromScale(-1, 0),
                tag = "content-emphasis",
                testId = `{var1.testId}--right-gradient`
            }, {
                Gradient = React.createElement("UIGradient", {
                    Transparency = numberSequence,
                    Color = colorSequence,
                    Rotation = var1.progress:map(function(num1: number): number
                        return math.clamp(num1 * 360, 0, 180)
                    end)
                })
            })
        })
    })
end))
