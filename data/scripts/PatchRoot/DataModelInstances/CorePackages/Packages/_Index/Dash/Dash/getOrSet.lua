-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T06:50:59Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local function getOrSet(tbl1, arg1, func1: (...any) -> (...any))
    if tbl1[arg1] == nil then
        tbl1[arg1] = func1(tbl1, arg1)
    end
    return tbl1[arg1]
end

return getOrSet
