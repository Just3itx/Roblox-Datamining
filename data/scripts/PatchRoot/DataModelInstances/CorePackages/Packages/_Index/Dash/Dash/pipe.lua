-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T03:31:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function pipe(func1: (...any) -> (...any), ...)
    local select = select
    local var1 = select("#", ...)
    if var1 == 0 then
        return func1
    end
    local tbl1 = { ... }
    return function(...)
        local tbl2 = { func1(...) }
        for i = 1, var1 do
            tbl2 = { tbl1[i](unpack(tbl2)) }
        end
        return unpack(tbl2)
    end
end

return pipe
