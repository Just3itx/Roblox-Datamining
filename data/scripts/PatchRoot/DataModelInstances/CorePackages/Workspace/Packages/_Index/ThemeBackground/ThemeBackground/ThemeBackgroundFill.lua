-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T23:31:31Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local scriptParentParent = scriptParent.Parent

local React = require(scriptParentParent.React)

local ThemeBackgroundImage = require(scriptParent.ThemeBackgroundImage)

local function ThemeBackgroundFill(tbl1)
    return React.createElement("Frame", {
        BackgroundColor3 = tbl1.baseColor,
        BackgroundTransparency = 0,
        BorderSizePixel = 0,
        Position = tbl1.Position,
        Size = tbl1.Size or UDim2.fromScale(1, 1),
        ZIndex = 0,
        ref = tbl1.onPageChanged,
        [React.Change.AbsolutePosition] = tbl1.onPageChanged,
        [React.Change.AbsoluteSize] = tbl1.onPageChanged
    }, {
        Image = React.createElement(ThemeBackgroundImage, { image = tbl1.image })
    })
end

return ThemeBackgroundFill
