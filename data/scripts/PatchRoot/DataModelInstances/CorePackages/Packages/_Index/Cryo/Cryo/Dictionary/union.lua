-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T04:31:16Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local function union(arg1, arg2)
    local var1 = table.clone(arg1)

    for value, value2 in arg2 do
        var1[value] = value2
    end

    return var1
end

return union
