-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T14:00:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function findValueKeyInRefCache(current, tbl1)
    for value, value2 in tbl1 do
        if value2.current == current then
            return value
        end
    end
    return nil
end

return findValueKeyInRefCache
