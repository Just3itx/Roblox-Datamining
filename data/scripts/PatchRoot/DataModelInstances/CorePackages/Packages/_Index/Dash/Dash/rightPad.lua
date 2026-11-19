-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T07:00:57Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local function rightPad(str1: string, num1: number, str2: string?): string
    local str3 = str2 or " "
    local num2 = num1 - str1:len()
    local num3 = num2 % str3:len()
    local num4 = (num2 - num3) / str3:len()
    return str1 .. string.rep(str2 or " ", num4) .. str3:sub(1, num3)
end

return rightPad
