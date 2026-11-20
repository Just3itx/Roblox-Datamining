-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T08:40:27Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function keys(arg1)
    local str1 = type(arg1)
    assert(str1 == "table", "expected a table for first argument, got " .. str1)

    local result = ({})

    local num1 = 1

    for k, _ in pairs(arg1) do
        result[num1] = k
        num1 += 1
    end

    return result
end

return keys
