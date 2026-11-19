-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T05:00:46Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local var1 = "([" .. ("$%^()-[].?"):gsub("(.)", "%%%1") .. "])"

local function includes(str1: string, str2: string, arg1)
    local var2, var3 = utf8.len(str1)
    local str3 = tostring(var3)
    assert(var2 ~= nil, ("string `%s` has an invalid byte at position %s"):format(str1, str3))
    if var2 == 0 then
        return false
    end

    if #str2 == 0 then
        return true
    end

    local var4

    if arg1 == nil then
        var4 = 1
    else
        var4 = tonumber(arg1) or 1
        if var2 < var4 then
            return false
        end
    end

    local num1 = if var4 < 1 then 1 else var4

    local num2 = utf8.offset(str1, num1)
    local var5 = str2:gsub(var1, "%%%1")
    local var6, _ = string.find(str1, var5, num2)
    return var6 ~= nil
end

return includes
