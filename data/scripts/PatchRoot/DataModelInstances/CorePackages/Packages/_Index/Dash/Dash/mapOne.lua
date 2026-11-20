-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T03:31:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function mapOne(tbl1, func1: ((...any) -> (...any))?)
    for value, value2 in tbl1 do
        if func1 then
            value2 = func1(value2, value)
        end

        if value2 ~= nil then
            return value2
        end
    end
    return nil
end

return mapOne
