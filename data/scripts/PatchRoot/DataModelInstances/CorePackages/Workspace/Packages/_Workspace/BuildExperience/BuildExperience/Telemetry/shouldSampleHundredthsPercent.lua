-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T21:11:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function shouldSampleHundredthsPercent(num1: number): boolean
    return not (num1 <= 0) and (num1 >= 10000 or math.random(1, 10000) <= num1)
end

return shouldSampleHundredthsPercent
