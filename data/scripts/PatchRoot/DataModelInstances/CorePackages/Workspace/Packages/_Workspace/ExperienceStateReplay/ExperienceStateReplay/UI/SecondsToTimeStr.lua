-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T11:30:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local module = {}

function module.convertSecondsToTimeStr(num1: number): string
    local num2 = math.round(num1) % 60
    local num3 = math.round(num1) // 60 % 60
    local num4 = math.round(num1) // 60 // 60 // 24
    return string.format("%02d", num4) .. ":" .. string.format("%02d", num3) .. ":" .. string.format("%02d", num2)
end

return module
