-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T23:40:39Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local React = require(scriptParentParent.React)

local function ThemeBackgroundImage(tbl1)
    return React.createElement("ImageLabel", {
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Image = tbl1.image,
        Position = tbl1.Position,
        ScaleType = Enum.ScaleType.Crop,
        Size = tbl1.Size or UDim2.fromScale(1, 1),
        ZIndex = 0
    })
end

return ThemeBackgroundImage
