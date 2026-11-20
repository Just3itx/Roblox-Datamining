-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T03:40:36Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local insert = table.insert

local function slice(tbl1, num1: number?, num2: number?)
    local result = {}

    local num3 = num1 or 1
    local num4 = num2 or #tbl1

    if num3 < 0 then
        num3 = #tbl1 + num3
    end
    if num4 and num4 < 0 then
        num4 = #tbl1 + num4
    end
    for i = num3, num4 do
        insert(result, tbl1[i])
    end
    return result
end

return slice
