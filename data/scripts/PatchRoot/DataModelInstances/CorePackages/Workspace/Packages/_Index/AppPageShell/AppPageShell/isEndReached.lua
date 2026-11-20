-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T23:01:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function isEndReached(num1: number, num2: number, num3: number, num4: number?): boolean
    return not (num3 <= 0 or num2 <= 0) and num3 - (num1 + num2) <= (num4 or 0)
end

return isEndReached
