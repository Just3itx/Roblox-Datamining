-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T08:51:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function reduce(arg1, arg2, arg3)
    local str1 = type(arg1)
    assert(str1 == "table", "expected a table for first argument, got " .. str1)

    local str2 = type(arg2)
    assert(str2 == "function", "expected a function for second argument, got " .. str2)
    local var1 = if arg3 == nil then arg1[1] else arg3

    for i = if arg3 == nil then 2 else 1, #arg1 do
        var1 = arg2(var1, arg1[i], i)
    end

    return var1
end

return reduce
