-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T08:51:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function includes(arg1, arg2)
    local str1 = type(arg1)
    assert(str1 == "table", "expected a table for first argument, got " .. str1)

    for i = 1, #arg1 do
        if arg1[i] == arg2 then
            return true
        end
    end

    return false
end

return includes
