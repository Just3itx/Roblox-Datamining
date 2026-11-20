-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:38:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParentParent = script.Parent.Parent.Parent.Parent
local scriptParentParentParentParentParent = scriptParentParentParentParent.Parent
local React = require(scriptParentParentParentParentParent.React)
local Core = scriptParentParentParentParent.Core
local useStyle = require(Core.Style.useStyle)

local ReactOtter = require(scriptParentParentParentParentParent.ReactOtter)

local tbl1 = { dampingRatio = 1, frequency = 3 }

local tbl2 = {
    top = 270,
    topRight = 305,
    right = 0,
    bottomRight = 45,
    bottom = 90,
    bottomLeft = 135,
    left = 180,
    topLeft = 225
}

local function Overlay(tbl3)
    local theme = useStyle().Theme

    local num1 = if tbl3.showGradient then 0 else 1
    local backgroundTransparency, var2 = ReactOtter.useAnimatedBinding(num1)

    React.useEffect(function()
        if tbl3.showGradient == false then
            var2(ReactOtter.spring(1, tbl1))
            return
        end
        var2(ReactOtter.spring(0, tbl1))
    end, { tbl3.showGradient })

    return React.createElement("Frame", {
        Size = UDim2.fromScale(1, 1),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ClipsDescendants = true,
        ZIndex = tbl3.ZIndex
    }, {
        Overlay = React.createElement("Frame", {
            Size = UDim2.fromScale(1, 1),
            BackgroundColor3 = theme.Overlay.Color,
            BackgroundTransparency = theme.Overlay.Transparency,
            ZIndex = 1
        }),
        Gradient = React.createElement(
            "Frame",
            {
                Size = UDim2.fromScale(1, 1),
                BackgroundTransparency = backgroundTransparency,
                ZIndex = 2
            },
            {
                UIGradient = React.createElement("UIGradient", {
                    Rotation = tbl2[tbl3.gradientDirection],
                    Color = ColorSequence.new(
                        { ColorSequenceKeypoint.new(0, Color3.new(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.new(0, 0, 0)) }
                    ),
                    Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(1, 0.89) })
                })
            }
        )
    })
end

return Overlay
