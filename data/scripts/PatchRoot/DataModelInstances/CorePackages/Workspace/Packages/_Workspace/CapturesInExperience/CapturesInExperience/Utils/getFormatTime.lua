-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T00:11:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function getFormatTime(num1: number): string
    local num2 = math.floor(num1 / 60)
    local num3 = math.floor(num1 % 60)
    return string.format("%01d:%02d", num2, num3)
end

return getFormatTime
