-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T07:40:36Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function getFormatTime(num1: number): string
    local num2 = math.max(0, math.floor(num1))
    local num3 = math.floor(num2 / 60)
    local num4 = num2 % 60
    return string.format("%d:%02d", num3, num4)
end

return getFormatTime
