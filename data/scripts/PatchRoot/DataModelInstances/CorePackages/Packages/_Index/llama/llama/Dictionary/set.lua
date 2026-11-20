-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T08:50:40Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local copy = require(script.Parent.copy)

local function set(arg1, arg2, arg3)
    local str1 = type(arg1)
    assert(str1 == "table", "expected a table for first argument, got " .. str1)

    assert(arg2 ~= nil, "expected second argument to be anything but nil, got nil")

    local var1 = copy(arg1)

    var1[arg2] = arg3

    return var1
end

return set
