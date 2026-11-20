-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T09:00:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function has(arg1, arg2): boolean
    local str1 = type(arg1)
    assert(str1 == "table", "expected a table for first argument, got " .. str1)

    assert(arg2 ~= nil, "expected second argument to be anything but nil, got nil")

    return arg1[arg2] == true
end

return has
