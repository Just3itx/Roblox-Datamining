-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:31:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent
local scriptParentParentParentParentParent = scriptParentParentParentParent.Parent
local Core = scriptParentParentParentParent.Core

local React = require(scriptParentParentParentParentParent.React)
local _StyleTypes = require(scriptParentParentParent.Style.StyleTypes)
local useStyle = require(Core.Style.useStyle)

local function GradientFrame(tbl1)
    local frameRef = tbl1.frameRef
    local gradientStyle = tbl1.gradientStyle
    local height = tbl1.height
    local zIndex = tbl1.ZIndex

    local theme = useStyle().Theme

    local color = gradientStyle and gradientStyle.Color or theme.BackgroundDefault.Color
    local transparency = gradientStyle and gradientStyle.Transparency or theme.BackgroundDefault.Transparency

    return React.createElement(
        "Frame",
        {
            BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 1, 0),
            ZIndex = zIndex,
            ref = frameRef
        },
        {
            Left = React.createElement(
                "Frame",
                {
                    BackgroundTransparency = transparency,
                    BackgroundColor3 = color,
                    Size = UDim2.new(0, 50, 0, height)
                },
                {
                    Gradient = React.createElement(
                        "UIGradient",
                        {
                            Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(1, 1) })
                        }
                    )
                }
            ),
            Right = React.createElement("Frame", {
                BackgroundTransparency = transparency,
                BackgroundColor3 = color,
                AnchorPoint = Vector2.new(1, 0),
                Position = UDim2.fromScale(1, 0),
                Size = UDim2.new(0, 50, 0, height)
            }, {
                Gradient = React.createElement(
                    "UIGradient",
                    {
                        Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(1, 0) })
                    }
                )
            })
        }
    )
end

return GradientFrame
