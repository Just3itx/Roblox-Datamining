-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T04:40:47Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local function removeRange<T>(tbl1: {T}, arg1, arg2): {T}
    assert(arg1 <= arg2, "startIndex must be less than or equal to endIndex")

    local result = ({})
    local num1 = 1

    local num2 = #tbl1
    local var1 = arg1 - 1

    for i = 1, math.min(num2, var1) do
        result[num1] = tbl1[i]
        num1 += 1
    end

    for i = arg2 + 1, #tbl1 do
        result[num1] = tbl1[i]
        num1 += 1
    end

    return result
end

return removeRange
