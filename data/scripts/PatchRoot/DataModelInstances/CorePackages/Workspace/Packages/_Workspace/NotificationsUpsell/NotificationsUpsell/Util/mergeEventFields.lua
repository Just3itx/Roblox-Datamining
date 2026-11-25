-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T00:40:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function mergeEventFields(tbl1, tbl2)
    if tbl2 == nil then
        return tbl1
    end
    local var1 = table.clone(tbl1)
    for value, value2 in tbl2 do
        var1[value] = value2
    end
    return var1
end

return mergeEventFields
