-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T08:50:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function copy<T>(tbl1: {T}): {T}
    local str1 = type(tbl1)
    assert(str1 == "table", "expected a table for first argument, got " .. str1)

    local result = ({})

    for i = 1, #tbl1 do
        result[i] = tbl1[i]
    end

    return result
end

return copy
