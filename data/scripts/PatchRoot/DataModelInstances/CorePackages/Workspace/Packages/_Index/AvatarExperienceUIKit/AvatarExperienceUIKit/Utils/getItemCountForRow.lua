-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T05:11:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function getItemCountForRow(num1: number, num2: number): number
    return math.floor(num1 / math.max(1, num2))
end

return getItemCountForRow
