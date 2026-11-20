-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T08:51:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function shift<T>(tbl1: {T}, arg1): {T}
    local str1 = type(tbl1)
    assert(str1 == "table", "expected a table for first argument, got " .. str1)

    arg1 = arg1 or 1
    local str2 = type(arg1)
    assert(str2 == "number" and arg1 % 1 == 0, "expected an integer for second argument, got " .. str2)

    local result = {}

    for i = 1 + arg1, #tbl1 do
        result[i - arg1] = tbl1[i]
    end

    return result
end

return shift
