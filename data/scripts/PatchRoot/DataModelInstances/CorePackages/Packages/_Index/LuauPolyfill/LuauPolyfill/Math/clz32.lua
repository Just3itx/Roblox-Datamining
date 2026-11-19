-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T11:00:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local rshift = bit32.rshift
local log = math.log
local floor = math.floor

return function(num1: number)
    local var1 = rshift(num1, 0)
    if var1 == 0 then
        return 32
    end
    return 31 - floor(log(var1) / 0.6931471805599453)
end
