-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T03:40:37Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function some(tbl1, func1: (...any) -> (...any))
    for value, value2 in tbl1 do
        if func1(value2, value) then
            return true
        end
    end
    return false
end

return some
