-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T03:30:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function includes(tbl1, arg1)
    if arg1 == nil then
        return false
    end
    for _, value in tbl1 do
        if value == arg1 then
            return true
        end
    end
    return false
end

return includes
