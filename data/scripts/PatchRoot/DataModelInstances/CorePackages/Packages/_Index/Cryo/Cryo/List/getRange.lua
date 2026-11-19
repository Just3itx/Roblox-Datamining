-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T10:41:26Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function getRange<T>(tbl1: {T}, arg1, arg2): {T}
    assert(arg1 <= arg2, "startIndex must be less than or equal to endIndex")

    local range = ({})
    local num1 = 1

    local num2 = math.max(1, arg1)
    local num3 = #tbl1

    for i = num2, math.min(num3, arg2) do
        range[num1] = tbl1[i]
        num1 += 1
    end

    return range
end

return getRange
