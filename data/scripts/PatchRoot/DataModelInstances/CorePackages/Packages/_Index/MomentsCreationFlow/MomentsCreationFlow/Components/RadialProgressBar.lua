-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T10:21:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCreationFlow = script:FindFirstAncestor("MomentsCreationFlow")
local MomentsCreationFlowParent = MomentsCreationFlow.Parent

local Foundation = require(MomentsCreationFlowParent.Foundation)
local React = require(MomentsCreationFlowParent.React)

local Image = Foundation.Image
local View = Foundation.View

local useTokens = Foundation.Hooks.useTokens

local Constants = require(MomentsCreationFlow.Constants)

local function RadialProgressBar(tbl1)
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
            tag = "anchor-center-center position-center-center size-full"
        },
        {
            LeftGradient = React.createElement(View, {
                Size = UDim2.fromScale(0.5, 1),
                tag = "clip"
            }, {
                Image = React.createElement(Image, {
                    Image = Constants.RadialFillImage,
                    Size = UDim2.fromScale(2, 1)
                }, {
                    Gradient = React.createElement("UIGradient", {
                        Transparency = numberSequence,
                        Color = colorSequence,
                        Rotation = tbl1.progress:map(function(num1: number): number
                            return math.clamp(num1 * 360, 180, 360)
                        end)
                    })
                })
            }),
            RightGradient = React.createElement(View, {
                Size = UDim2.fromScale(0.5, 1),
                tag = "clip position-top-center"
            }, {
                Image = React.createElement(
                    Image,
                    {
                        Image = Constants.RadialFillImage,
                        Size = UDim2.fromScale(2, 1),
                        Position = UDim2.fromScale(-1, 0)
                    },
                    {
                        Gradient = React.createElement("UIGradient", {
                            Transparency = numberSequence,
                            Color = colorSequence,
                            Rotation = tbl1.progress:map(function(num1: number): number
                                return math.clamp(num1 * 360, 0, 180)
                            end)
                        })
                    }
                )
            })
        }
    )
end

return RadialProgressBar
