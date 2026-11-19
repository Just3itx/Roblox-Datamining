-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T19:00:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local React = require(CorePackages.Packages.React)
local ChromeShared = script.Parent.Parent.ChromeShared
local GetStyleTokens = require(ChromeShared.Utility.GetStyleTokens)

local brightRed = Color3.new(0.918, 0.2, 0.137)

return function(tbl1)
    local var1 = React.useMemo(function()
        return GetStyleTokens().Size.Size_100
    end, {})
    return React.createElement(
        "Frame",
        {
            Name = tbl1.name or "RedDot",
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = tbl1.position,
            Size = UDim2.fromOffset(var1, var1),
            BackgroundColor3 = brightRed,
            Visible = tbl1.visible
        },
        {
            UICorner = React.createElement("UICorner", { CornerRadius = UDim.new(1, 0) })
        }
    )
end
