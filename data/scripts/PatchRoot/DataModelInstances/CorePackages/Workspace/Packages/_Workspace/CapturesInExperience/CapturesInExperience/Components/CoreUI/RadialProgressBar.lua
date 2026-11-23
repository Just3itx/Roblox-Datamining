-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T23:41:28Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParentParent = script.Parent.Parent.Parent.Parent

local React = require(scriptParentParentParentParent.React)
local Foundation = require(scriptParentParentParentParent.Foundation)

local Image = Foundation.Image
local View = Foundation.View

local useTokens = Foundation.Hooks.useTokens

return React.memo(React.forwardRef(function(tbl1) -- name: RadialProgressBar
    local var1 = useTokens()
    local background = var1.Color.ActionSubtle.Background
    local foreground = var1.Color.ActionSubtle.Foreground

    local numberSequence = NumberSequence.new({
        NumberSequenceKeypoint.new(0, foreground.Transparency),
        NumberSequenceKeypoint.new(0.4999, foreground.Transparency),
        NumberSequenceKeypoint.new(0.5, background.Transparency),
        NumberSequenceKeypoint.new(1, background.Transparency)
    })

    local colorSequence = ColorSequence.new({
        ColorSequenceKeypoint.new(0, foreground.Color3),
        ColorSequenceKeypoint.new(0.4999, foreground.Color3),
        ColorSequenceKeypoint.new(0.5, background.Color3),
        ColorSequenceKeypoint.new(1, background.Color3)
    })

    return React.createElement(
        View,
        {
            BackgroundTransparency = 1,
            tag = "anchor-center-center bg-action-subtle position-center-center size-full"
        },
        {
            LeftGradient = React.createElement(View, {
                Size = UDim2.fromScale(0.5, 1),
                tag = "bg-action-subtle clip"
            }, {
                Image = React.createElement(
                    Image,
                    {
                        Image = "rbxasset://textures/ui/Controls/RadialFill.png",
                        Size = UDim2.fromScale(2, 1)
                    },
                    {
                        Gradient = React.createElement("UIGradient", {
                            Transparency = numberSequence,
                            Color = colorSequence,
                            Rotation = tbl1.progress:map(function(num1: number): number
                                return math.clamp(num1 * 360, 180, 360)
                            end)
                        })
                    }
                )
            }),
            RightGradient = React.createElement(
                View,
                {
                    Size = UDim2.fromScale(0.5, 1),
                    tag = "bg-action-subtle clip position-top-center"
                },
                {
                    Image = React.createElement(Image, {
                        Image = "rbxasset://textures/ui/Controls/RadialFill.png",
                        Size = UDim2.fromScale(2, 1),
                        Position = UDim2.fromScale(-1, 0)
                    }, {
                        Gradient = React.createElement("UIGradient", {
                            Transparency = numberSequence,
                            Color = colorSequence,
                            Rotation = tbl1.progress:map(function(num1: number): number
                                return math.clamp(num1 * 360, 0, 180)
                            end)
                        })
                    })
                }
            )
        }
    )
end))
