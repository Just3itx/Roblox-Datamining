-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:40:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function getCornerRadii(tbl1, num1: number)
    return {
        topLeft = if tbl1.topLeft then num1 else 0,
        topRight = if tbl1.topRight then num1 else 0,
        bottomLeft = if tbl1.bottomLeft then num1 else 0,
        bottomRight = if tbl1.bottomRight then num1 else 0
    }
end

return getCornerRadii
