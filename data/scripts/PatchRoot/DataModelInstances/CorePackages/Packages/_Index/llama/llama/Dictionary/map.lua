-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T08:40:28Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function map(arg1, arg2)
    local str1 = type(arg1)
    assert(str1 == "table", "expected a table for first argument, got " .. str1)

    local str2 = type(arg2)
    assert(str2 == "function", "expected a function for second argument, got " .. str2)

    local result = {}

    for k, value in pairs(arg1) do
        local var1, var2 = arg2(value, k)
        result[var2 or k] = var1
    end

    return result
end

return map
