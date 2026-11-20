-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T03:31:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function leftPad(str1: string, num1: number, str2: string?): string
    local str3 = str2 or " "

    local num2 = num1 - str1:len()
    local num3 = num2 % str3:len()
    local num4 = (num2 - num3) / str3:len()
    return string.rep(str3 or " ", num4) .. str3:sub(1, num3) .. str1
end

return leftPad
