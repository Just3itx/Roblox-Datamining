-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T07:31:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function computeKeyboardInset(bool1: boolean, bool2: boolean, num1: number, num2: number, num3: number): number
    if not (bool1 and bool2) then
        return 0
    end

    return math.clamp(num2 - num1, 0, num3)
end

return computeKeyboardInset
