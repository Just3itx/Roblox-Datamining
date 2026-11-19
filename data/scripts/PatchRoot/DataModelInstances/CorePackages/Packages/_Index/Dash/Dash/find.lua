-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T06:50:45Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local function find(tbl1, func1: (...any) -> (...any))
    for value, value2 in tbl1 do
        if func1(value2, value) then
            return value2
        end
    end
    return nil
end

return find
