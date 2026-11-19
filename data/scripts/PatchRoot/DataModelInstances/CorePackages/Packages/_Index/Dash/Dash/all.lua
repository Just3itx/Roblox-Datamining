-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T06:41:10Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local function func1<T>(arg1: T): T
    return arg1
end

local function all(tbl1, func2: ((...any) -> (...any))?)
    local var1 = func2 or func1
    for value, value2 in tbl1 do
        if not var1(value2, value) then
            return false
        end
    end
    return true
end

return all
