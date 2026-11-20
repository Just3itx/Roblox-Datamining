-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T03:30:35Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function findIndex(tbl1, func1: (...any) -> (...any))
    for i, value in ipairs(tbl1) do
        if func1(value, i) then
            return i
        end
    end
    return nil
end

return findIndex
