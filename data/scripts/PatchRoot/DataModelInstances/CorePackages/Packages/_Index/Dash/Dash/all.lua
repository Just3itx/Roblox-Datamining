-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T03:21:01Z
-- Luau bytecode version: 14 | Luau type version: 3
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
