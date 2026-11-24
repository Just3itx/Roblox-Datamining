-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T10:21:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function ceilToEven(num1: number): number -- Luacid: Inlined by compiler; 1 call site recovered
    local num2 = math.ceil(num1)
    if num2 % 2 == 1 then
        num2 += 1
    end
    return math.max(0, num2)
end

return function(num1: number): number
    return ceilToEven(num1 * 3 / 4)
end
