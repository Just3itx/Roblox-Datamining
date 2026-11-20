-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T03:30:39Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function forEach(tbl1, callback: (...any) -> (...any))
    for value, value2 in tbl1 do
        callback(value2, value)
    end
end

return forEach
