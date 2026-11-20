-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T08:50:41Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function some(arg1, arg2)
    local str1 = type(arg2)
    assert(str1 == "function", "expected a function for second argument, got " .. str1)

    for k, value in pairs(arg1) do
        if arg2(value, k) then
            return true
        end
    end

    return false
end

return some
