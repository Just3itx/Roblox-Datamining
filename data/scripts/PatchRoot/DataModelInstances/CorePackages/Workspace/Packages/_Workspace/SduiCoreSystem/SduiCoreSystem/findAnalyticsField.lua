-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T10:00:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function findAnalyticsField(str1: string, tbl1, arg1)
    if not tbl1 then
        return nil
    end

    if tbl1 and tbl1[str1] ~= nil then
        return tbl1[str1]
    end

    if arg1 == nil then
        return nil
    end

    return arg1
end

return findAnalyticsField
