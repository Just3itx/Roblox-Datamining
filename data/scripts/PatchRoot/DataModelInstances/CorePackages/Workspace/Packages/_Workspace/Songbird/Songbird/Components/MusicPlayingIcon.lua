-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T17:00:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Songbird = script:FindFirstAncestor("Songbird")

local Cryo = require(Songbird.Parent.Cryo)
local React = require(Songbird.Parent.React)

local AnimatedBar = require(Songbird.Components.AnimatedBar)

local tbl1 = { numAnimatedBars = 5, isMoving = true }

local tbl2 = {
    0.4,
    0.3,
    0.75,
    0.55
}

local function MusicPlayingIcon(tbl3)
    local var1 = Cryo.Dictionary.join(tbl1, tbl3)

    local offset = 8 / var1.numAnimatedBars

    local tbl4 = ({})
    for layoutOrder = 1, var1.numAnimatedBars do
        local str1 = `Bar{layoutOrder}`
        tbl4[str1] = React.createElement(AnimatedBar, {
            layoutOrder = layoutOrder,
            width = UDim.new(1 / (var1.numAnimatedBars * 1.3), -offset),
            heightRange = var1.heightRange,
            isMoving = var1.isMoving,
            staticHeight = tbl2[layoutOrder]
        })
    end

    return React.createElement(
        "Frame",
        {
            Size = UDim2.fromScale(1, 1),
            BackgroundTransparency = 1,
            ZIndex = var1.zIndex
        },
        {
            Layout = React.createElement("UIListLayout", {
                SortOrder = Enum.SortOrder.LayoutOrder,
                FillDirection = Enum.FillDirection.Horizontal,
                HorizontalAlignment = Enum.HorizontalAlignment.Center,
                VerticalAlignment = Enum.VerticalAlignment.Center,
                Padding = UDim.new(0, offset)
            })
        },
        tbl4
    )
end

return MusicPlayingIcon
