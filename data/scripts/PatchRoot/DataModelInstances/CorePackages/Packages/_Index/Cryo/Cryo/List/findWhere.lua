-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T04:40:37Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local function findWhere(arg1, arg2)
    for i = 1, #arg1 do
        if arg2(arg1[i], i) then
            return i
        end
    end
    return nil
end

return findWhere
