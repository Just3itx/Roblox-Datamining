-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T01:30:40Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function getManualSelectVariant(num1: number, num2: number?): number -- Luacid: Inlined by compiler; 1 call site recovered
    return if num1 >= 0 then num1 else num2 or 0
end

local function resolveBirthdaySelectVariant(bool1: boolean, num1: number, num2: number?, num3: number?): boolean
    local manualSelectVariant = getManualSelectVariant(num1, num2)
    return bool1 and (num3 or 1) <= manualSelectVariant
end

return resolveBirthdaySelectVariant
