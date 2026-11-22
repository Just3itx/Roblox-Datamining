-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T03:51:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function getLineHeights(tbl1)
    local var1 = tbl1.FontSize * tbl1.LineHeight
    local offset = UDim.new(0, (var1 - tbl1.FontSize) / 2).Offset
    return tbl1.FontSize + 2 * offset, math.round(var1)
end

return getLineHeights
