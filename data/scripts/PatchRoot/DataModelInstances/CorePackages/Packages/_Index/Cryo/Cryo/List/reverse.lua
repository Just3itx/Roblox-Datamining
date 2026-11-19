-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T04:40:52Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local function reverse<T>(tbl1: {T}): {T}
    local result = ({})
    local num1 = #tbl1
    local num2 = num1 + 1

    for i = 1, num1 do
        result[i] = tbl1[num2 - i]
    end

    return result
end

return reverse
