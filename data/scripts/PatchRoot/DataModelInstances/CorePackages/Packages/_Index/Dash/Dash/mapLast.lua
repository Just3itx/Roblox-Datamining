-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T03:31:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function mapLast(tbl1, func1: (...any) -> (...any))
    for i = #tbl1, 1, -1 do
        local var1 = func1(tbl1[i], i)
        if var1 ~= nil then
            return var1
        end
    end
    return nil
end

return mapLast
