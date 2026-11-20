-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T03:40:30Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function reduce(tbl1, func1: (...any) -> (...any), arg1)
    for value, value2 in tbl1 do
        arg1 = func1(arg1, value2, value)
    end
    return arg1
end

return reduce
