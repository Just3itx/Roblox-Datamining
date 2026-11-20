-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T08:51:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function push<T>(tbl1: {T}, ...): {T}
    local str1 = type(tbl1)
    assert(str1 == "table", "expected a table for first argument, got " .. str1)

    local result = ({})
    local num1 = #tbl1

    for i = 1, num1 do
        result[i] = tbl1[i]
    end

    local select2 = select

    for i = 1, select2("#", ...) do
        local num2 = num1 + i
        local select = select
        result[num2] = select(i, ...)
    end

    return result
end

return push
