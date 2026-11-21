-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T17:21:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function isSeeAllTileEnabled(bool1: boolean?, num1: number?, num2: number, num3: number, func1: ((...any) -> (...any))?): boolean
    return not bool1 and (if func1 then num1 ~= nil and not (num1 <= num2 or num3 <= num2) or false else false)
end

return isSeeAllTileEnabled
