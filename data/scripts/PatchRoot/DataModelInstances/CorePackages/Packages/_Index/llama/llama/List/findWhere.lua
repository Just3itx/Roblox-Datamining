-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T08:51:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function find(arg1, arg2, arg3)
    local str1 = type(arg1)
    assert(str1 == "table", "expected a table for first argument, got " .. str1)

    local str2 = type(arg2)
    assert(str2 == "function", "expected a function for second argument, got " .. str2)

    for i = arg3 or 1, #arg1 do
        if arg2(arg1[i], i) then
            return i
        end
    end

    return nil
end

return find
