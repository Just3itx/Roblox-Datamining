-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T08:51:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function slice<T>(tbl1: {T}, arg1, arg2): {T}
    local str1 = type(tbl1)
    assert(str1 == "table", "expected a table for first argument, got " .. str1)

    local num1 = #tbl1
    arg1 = arg1 or 1
    arg2 = arg2 or num1

    assert(arg1 <= arg2, "start index must be less than or equal to end index")

    local result = ({})
    local num2 = 1

    for i = math.max(1, arg1), math.min(arg2, num1) do
        result[num2] = tbl1[i]
        num2 += 1
    end

    return result
end

return slice
