-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T03:50:34Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function shallowEqual(tbl1, tbl2)
    for value, value2 in tbl1 do
        if tbl2[value] ~= value2 then
            return false
        end
    end

    for value, value2 in tbl2 do
        if tbl1[value] ~= value2 then
            return false
        end
    end

    return true
end

return shallowEqual
