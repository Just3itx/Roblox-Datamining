-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T10:41:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function omit(tbl1, ...)
    local var1 = table.clone(tbl1)
    for _, value in { ... } do
        var1[value] = nil
    end
    return var1
end

return omit
