-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T17:31:33Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local module = {}

function module.keysToString(tbl1, str1: string, bool1: boolean?): string
    local tbl2 = {}
    for value in tbl1 do
        table.insert(tbl2, tostring(value))
    end

    if bool1 then
        table.sort(tbl2)
    end
    return table.concat(tbl2, str1)
end

return module
