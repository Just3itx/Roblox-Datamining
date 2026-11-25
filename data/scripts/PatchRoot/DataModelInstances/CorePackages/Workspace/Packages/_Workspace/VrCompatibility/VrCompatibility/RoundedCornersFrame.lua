-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T22:41:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local Cryo = require(scriptParentParent.Cryo)
local React = require(scriptParentParent.React)

return function(tbl1)
    return React.createElement(
        "Frame",
        {
            BackgroundColor3 = tbl1.backgroundColor,
            BackgroundTransparency = tbl1.backgroundTransparency,
            Size = UDim2.new(1, 0, 1, 0)
        },
        Cryo.Dictionary.join({
            Padding = React.createElement("UIPadding", {
                PaddingRight = UDim.new(0, tbl1.cornerRadius),
                PaddingLeft = UDim.new(0, tbl1.cornerRadius),
                PaddingTop = UDim.new(0, tbl1.cornerRadius),
                PaddingBottom = UDim.new(0, tbl1.cornerRadius)
            }),
            Corner = React.createElement("UICorner", { CornerRadius = UDim.new(0, tbl1.cornerRadius) })
        }, tbl1.children)
    )
end
