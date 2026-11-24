-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T13:11:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function isFocusRequestFresh(num1: number?, num2: number, num3: number): boolean
    return not (num1 == nil) and num2 - num1 <= num3
end

return isFocusRequestFresh
