-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T09:00:42Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function unshift<T>(tbl1: {T}, ...): {T}
    local str1 = type(tbl1)
    assert(str1 == "table", "expected a table for first argument, got " .. str1)

    local select2 = select
    local var1 = select2("#", ...)

    local result = ({})

    for i = 1, var1 do
        local select = select
        result[i] = select(i, ...)
    end

    for i = 1, #tbl1 do
        result[var1 + i] = tbl1[i]
    end

    return result
end

return unshift
