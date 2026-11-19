-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T23:21:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Packages = game:GetService("CorePackages").Packages
local React = require(Packages.React)
local useStyle = require(Packages.UIBlox).Core.Style.useStyle

local uDim2 = UDim2.fromOffset(4, 4)
local vector2 = Vector2.new(0.5, 0.5)
local uDim2_2 = UDim2.fromScale(0.8, 0.8)

local function CameraStatusDot(tbl1)
    local var1 = useStyle()

    return React.createElement(
        "Frame",
        {
            AnchorPoint = tbl1.AnchorPoint or vector2,
            Size = if tbl1.Size then tbl1.Size else uDim2,
            BackgroundColor3 = var1.Theme.OnlineStatus.Color,
            Position = tbl1.Position or uDim2_2,
            ZIndex = tbl1.ZIndex
        },
        {
            UICorner = React.createElement("UICorner", { CornerRadius = UDim.new(1, 0) })
        }
    )
end

return CameraStatusDot
