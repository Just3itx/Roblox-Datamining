-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T05:00:44Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local var1 = "([" .. ("$%^()-[].?"):gsub("(.)", "%%%1") .. "])"

local function findOr(str1: string, tbl1, num1: number?)
    local num2 = utf8.offset(str1, num1 or 1)
    local tbl2 = {}
    for _, value in tbl1 do
        local var2 = value:gsub(var1, "%%%1")
        local var3, var4 = string.find(str1, var2, num2)
        if not var3 then
            continue
        end

        local str2 = string.sub(str1, 1, var3 - 1)
        local var5, var6 = utf8.len(str2)
        if var5 == nil then
            error(("string `%s` has an invalid byte at position %s"):format(str2, tostring(var6)))
        end
        table.insert(tbl2, { index = var5 + 1, match = string.sub(str1, var3, var4) })
    end

    if #tbl2 == 0 then
        return nil
    end

    local var2 = nil
    for _, value in tbl2 do
        if var2 == nil then
            var2 = value
        end

        if value.index < var2.index then
            var2 = value
        end
    end

    return var2
end

return findOr
