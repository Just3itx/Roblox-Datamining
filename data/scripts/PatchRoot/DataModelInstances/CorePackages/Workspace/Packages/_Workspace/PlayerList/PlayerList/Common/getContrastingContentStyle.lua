-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T02:51:33Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent

local blendColors = require(scriptParentParentParent.Foundation).Utility.blendColors

local function getContrastingContentStyle(color3: Color3, transparency: number, tbl1, tbl2, tbl3)
    local var1 = blendColors(
        {
            Color3 = tbl1.Color3,
            Transparency = tbl1.Transparency
        },
        { Color3 = color3, Transparency = transparency }
    )
    local color3_2 = tbl2.Color3
    local color3_3 = tbl3.Color3

    return if var1.Color3:GetContrastingColor(color3_2, color3_3) == color3_2 then tbl2 else tbl3
end

return getContrastingContentStyle
