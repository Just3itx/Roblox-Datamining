-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T03:40:38Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local insert = table.insert

local function splitOn(str1: string, str2: string)
    local tbl1 = {}
    local tbl2 = {}
    local num1 = 1
    if not str2 then
        for i = 1, #str1 do
            insert(tbl1, str1:sub(i, i))
        end
        return tbl1
    end
    local var1, var2 = str1:find(str2, num1)
    while var1 do
        insert(tbl2, str1:sub(var1, var2))
        local var3 = var1 - 1
        insert(tbl1, str1:sub(num1, var3))
        num1 = var2 + 1
        var1, var2 = str1:find(str2, num1)
    end
    insert(tbl1, str1:sub(num1))
    return tbl1, tbl2
end

return splitOn
