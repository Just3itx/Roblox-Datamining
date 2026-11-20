-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T03:31:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function last(tbl1, func1: ((...any) -> (...any))?)
    for i = #tbl1, 1, -1 do
        local var1 = tbl1[i]
        if not func1 then
            return var1
        end
        if func1 and func1(var1, i) then
            return var1
        end
    end
    return nil
end

return last
