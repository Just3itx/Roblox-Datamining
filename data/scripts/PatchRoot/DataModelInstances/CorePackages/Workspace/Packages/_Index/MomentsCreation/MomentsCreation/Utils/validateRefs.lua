-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T07:40:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function validateRefs(tbl1)
    for _, value in tbl1 do
        if value.current == nil then
            return false
        end
    end

    return true
end

return validateRefs
