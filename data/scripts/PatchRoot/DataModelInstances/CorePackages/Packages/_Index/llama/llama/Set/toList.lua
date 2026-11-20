-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T09:00:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function toList(arg1)
    local result = ({})
    local num1 = 1

    for k, _ in pairs(arg1) do
        result[num1] = k
        num1 += 1
    end

    return result
end

return toList
