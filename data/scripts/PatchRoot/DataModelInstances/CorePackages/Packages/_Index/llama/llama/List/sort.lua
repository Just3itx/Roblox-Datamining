-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T08:51:27Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local copy = require(script.Parent.copy)

local function sort<T>(arg1, func1: ((T, T) -> boolean)?): {T}
    local str1 = type(arg1)
    assert(str1 == "table", "expected a table for first argument, got " .. str1)

    local var1 = copy(arg1)

    table.sort(var1, func1)

    return var1
end

return sort
