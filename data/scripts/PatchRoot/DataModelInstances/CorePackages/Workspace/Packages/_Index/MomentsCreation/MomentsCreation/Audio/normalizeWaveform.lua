-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T06:50:30Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function normalizeWaveform(tbl1): {number}
    local num1 = 0
    local tbl2 = {}
    for _, value in tbl1 do
        local num2 = math.abs(value)
        table.insert(tbl2, num2)
        num1 = math.max(num1, num2)
    end
    if num1 == 0 then
        return tbl2
    end
    local result = {}
    for _, value in tbl2 do
        table.insert(result, value / num1)
    end
    return result
end

return normalizeWaveform
