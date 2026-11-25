-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T05:01:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local module = {}

function module.smoothstep(num1: number, num2: number, num3: number): number
    local num4 = math.clamp((num3 - num1) / (num2 - num1), 0, 1)
    return num4 * num4 * (3 - num4 * 2)
end

return module
