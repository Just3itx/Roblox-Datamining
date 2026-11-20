-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T08:40:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function flip(arg1)
    local str1 = type(arg1)
    assert(str1 == "table", "expected a table for first argument, got " .. str1)

    local result = ({})

    for k, value in pairs(arg1) do
        result[value] = k
    end

    return result
end

return flip
