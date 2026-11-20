-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T03:40:32Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local insert = table.insert

local function reverse(tbl1)
    local result = {}
    for i = #tbl1, 1, -1 do
        insert(result, tbl1[i])
    end
    return result
end
return reverse
