-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T09:51:30Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function tryGetPathFromData(tbl1, tbl2, num1: number?)
    if tbl1 == nil or tbl2 == nil then
        return false, nil
    end

    for i = num1 or 1, #tbl2 do
        local var1 = tbl2[i]
        if tbl1 == nil then
            return false, nil
        end
        tbl1 = tbl1[var1]
    end
    return tbl1 ~= nil, tbl1
end
return tryGetPathFromData
