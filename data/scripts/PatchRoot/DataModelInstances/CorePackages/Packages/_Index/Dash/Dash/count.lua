-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T03:21:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function func1(): boolean
    return true
end

local function count(tbl1, func2: ((...any) -> (...any))?): number
    local num1 = 0
    local var1 = func2 or func1
    for value, value2 in tbl1 do
        if var1(value2, value) then
            num1 += 1
        end
    end
    return num1
end

return count
