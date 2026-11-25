-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T14:50:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function getElapsedTimeMs(num1: number): number
    local num2 = (os.clock() - num1) * 1000
    if num2 <= 0 then
        return 0
    end
    return math.round(num2 * 100) / 100
end

return getElapsedTimeMs
