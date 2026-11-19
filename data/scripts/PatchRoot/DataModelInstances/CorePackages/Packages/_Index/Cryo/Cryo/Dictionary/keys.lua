-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T04:31:12Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local function keys(arg1)
    local result = ({})
    local num1 = 1

    for k in pairs(arg1) do
        result[num1] = k
        num1 += 1
    end

    return result
end

return keys
