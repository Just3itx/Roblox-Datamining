-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T06:30:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function insertNewlineAtCursor(str1: string, num1: number): (string, number)
    local num2 = utf8.len(str1) or #str1
    if not (num1 >= 1 and num1 <= num2 + 1) then
        num1 = num2 + 1
    end
    local num3 = (if num1 > 1 then utf8.offset(str1, num1) else 1) or #str1 + 1

    return string.sub(str1, 1, num3 - 1) .. "\n" .. string.sub(str1, num3), num1 + 1
end

return insertNewlineAtCursor
