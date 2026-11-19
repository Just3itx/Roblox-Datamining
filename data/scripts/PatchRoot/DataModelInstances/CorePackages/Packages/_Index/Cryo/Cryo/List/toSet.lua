-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T10:41:37Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function toSet(arg1)
    local result = {}

    for i = 1, #arg1 do
        result[arg1[i]] = true
    end

    return result
end

return toSet
