-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T04:11:30Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local VideoUtilsParent = script:FindFirstAncestor("VideoUtils").Parent

local React = require(VideoUtilsParent.React)

local useTokens = require(VideoUtilsParent.Foundation).Hooks.useTokens

local function VideoProgressBar(tbl1)
    local var1 = useTokens()

    local muted = var1.DarkMode.Content.Muted
    local emphasis = var1.Color.Content.Emphasis

    return React.createElement("Frame", {
        AnchorPoint = tbl1.AnchorPoint,
        Position = tbl1.Position,
        Size = tbl1.Size,
        BackgroundColor3 = muted.Color3,
        BackgroundTransparency = muted.Transparency,
        BorderSizePixel = 0,
        LayoutOrder = tbl1.LayoutOrder
    }, {
        UICorner = React.createElement("UICorner", { CornerRadius = UDim.new(1, 0) }),
        ProgressFill = React.createElement(
            "Frame",
            {
                Size = tbl1.progressBinding:map(function(xScale: number): UDim2
                    return UDim2.fromScale(xScale, 1)
                end),
                BackgroundColor3 = emphasis.Color3,
                BackgroundTransparency = emphasis.Transparency,
                BorderSizePixel = 0
            },
            {
                UICorner = React.createElement("UICorner", { CornerRadius = UDim.new(1, 0) })
            }
        )
    })
end

return VideoProgressBar
