-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T05:00:43Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local function endsWith(str1: string, str2: string, num1: number?): boolean
    local num2 = str2:len()
    if num2 == 0 then
        return true
    end
    local num3 = str1:len()
    local num4 = num1 or num3
    if not (num3 < num4) then
        num3 = num4
    end

    if num3 < 1 then
        return false
    end
    local num5 = num3 - num2 + 1
    return str1:find(str2, num5, true) == num5
end

return endsWith
