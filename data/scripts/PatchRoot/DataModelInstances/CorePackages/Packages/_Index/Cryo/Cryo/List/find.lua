-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T04:40:35Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local function find(arg1, arg2)
    for i = 1, #arg1 do
        if arg1[i] == arg2 then
            return i
        end
    end
    return nil
end

return find
