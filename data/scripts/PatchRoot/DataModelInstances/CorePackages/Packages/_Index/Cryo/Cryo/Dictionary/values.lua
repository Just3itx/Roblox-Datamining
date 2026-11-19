-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T10:41:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function values(arg1)
    local result = ({})
    local num1 = 1

    for _, value in pairs(arg1) do
        result[num1] = value
        num1 += 1
    end

    return result
end

return values
