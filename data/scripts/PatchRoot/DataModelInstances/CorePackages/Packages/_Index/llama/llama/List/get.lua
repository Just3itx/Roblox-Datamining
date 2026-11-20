-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T08:51:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function get<T>(tbl1: {T}, arg1): T
    local str1 = type(tbl1)
    assert(str1 == "table", "expected a table for first argument, got " .. str1)

    local str2 = type(arg1)
    assert(str2 == "number" and arg1 % 1 == 0, "expected second argument to be an integer, got " .. str2)

    return tbl1[arg1]
end

return get
