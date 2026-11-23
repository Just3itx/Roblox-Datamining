-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T05:30:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AdPlayerParent = script:FindFirstAncestor("AdPlayer").Parent
local React = require(AdPlayerParent.React)
local useTokens = require(AdPlayerParent.Foundation).Hooks.useTokens

local function LinearProgressComponent(tbl1)
    local var1 = useTokens()

    return React.createElement("Frame", {
        Position = tbl1.Position,
        AnchorPoint = tbl1.AnchorPoint,
        Size = tbl1.Size,
        ZIndex = tbl1.ZIndex,
        BackgroundColor3 = var1.Color.Extended.White.White_30.Color3,
        BackgroundTransparency = var1.Color.Extended.White.White_30.Transparency,
        BorderSizePixel = 0
    }, {
        progressFill = React.createElement("Frame", {
            BorderSizePixel = 0,
            Size = tbl1.alpha:map(function(xScale: number): UDim2
                return UDim2.fromScale(xScale, 1)
            end),
            BackgroundColor3 = var1.Color.Extended.White.White_100.Color3
        })
    })
end

return LinearProgressComponent
