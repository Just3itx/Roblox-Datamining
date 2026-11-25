-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T18:30:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local StyleParent = script:FindFirstAncestor("Style").Parent

local GetTextSize = require(StyleParent.UIBlox).Core.Text.GetTextSize

local vector2 = Vector2.new(2, 2)

local function getTextSize(str1: string, num1: number, arg1, vector2_2: Vector2, tbl1)
    local textSize = GetTextSize(str1, num1, arg1, vector2_2)
    return if tbl1 == nil or tbl1.addTemporaryPadding ~= false then textSize else textSize - vector2
end

return getTextSize
