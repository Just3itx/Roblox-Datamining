-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T08:40:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function every(arg1, arg2)
    local str1 = type(arg1)
    assert(str1 == "table", "expected a table for first argument, got " .. str1)

    local str2 = type(arg2)
    assert(str2 == "function", "expected a function for second argument, got " .. str2)

    for k, value in pairs(arg1) do
        if not arg2(value, k) then
            return false
        end
    end

    return true
end

return every
