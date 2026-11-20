-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T16:11:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function startsWith(str1: string, str2: string, num1: number?): boolean
    if string.len(str2) == 0 then
        return true
    end

    local var1 = if num1 == nil or num1 < 1 then 1 else num1

    return not (string.len(str1) < var1) and str1:find(str2, var1, true) == var1
end

return startsWith
