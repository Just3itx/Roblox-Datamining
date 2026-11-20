-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T08:40:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function alwaysTrue(): boolean
    return true
end

local function count(arg1, arg2): number
    local str1 = type(arg1)
    assert(str1 == "table", "expected a table for first argument, got " .. str1)

    local num1 = 0

    arg2 = arg2 or alwaysTrue

    for k, value in pairs(arg1) do
        if arg2(value, k) then
            num1 += 1
        end
    end

    return num1
end

return count
