-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T07:10:44Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local function getAncestors(arg1)
    local tbl1 = { arg1 }

    while arg1.Parent do
        table.insert(tbl1, arg1.Parent)
        arg1 = arg1.Parent
    end
    return tbl1
end

return getAncestors
