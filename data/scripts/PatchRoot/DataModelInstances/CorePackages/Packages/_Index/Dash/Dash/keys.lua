-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T06:51:15Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local insert = table.insert

local function keys(tbl1)
    local result = {}
    for value, _ in tbl1 do
        insert(result, value)
    end
    return result
end

return keys
