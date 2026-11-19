-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T05:00:53Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
return function(str1: string, num1: number, num2: number?): string
    if num2 and num2 <= 0 then
        return ""
    end
    return string.sub(str1, num1, if num2 then num1 + num2 - 1 or nil else nil)
end
