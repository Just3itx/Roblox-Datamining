-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T04:40:44Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local function map(arg1, arg2)
    local result = ({})

    for i = 1, #arg1 do
        result[i] = arg2(arg1[i], i)
    end

    return result
end

return map
