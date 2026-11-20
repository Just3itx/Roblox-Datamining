-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T20:11:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function readDenseRange(num1: number, func1: (...any) -> (...any), num2: number, num3: number)
    local num4 = math.max(1, num2)
    local num5 = math.max(0, math.min(num1, num3) - num4 + 1)
    local var1 = table.create(num5)
    for i = 1, num5 do
        var1[i] = func1(num4 + i - 1)
    end
    return var1
end

return readDenseRange
