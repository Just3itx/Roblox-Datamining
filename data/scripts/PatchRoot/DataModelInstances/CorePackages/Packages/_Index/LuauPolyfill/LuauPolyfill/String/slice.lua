-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T11:01:26Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function slice(str1: string, arg1, arg2): string
    local var1, var2 = utf8.len(str1)
    local str2 = tostring(var2)
    assert(var1 ~= nil, ("string `%s` has an invalid byte at position %s"):format(str1, str2))
    local var3 = tonumber(arg1)
    assert(typeof(var3) == "number", "startIndexStr should be a number")

    local var4 = if var3 + var1 < 0 then 1 else var3

    if var1 < var4 then
        return ""
    end

    local num1 = var1 + 1
    if arg2 ~= nil then
        num1 = tonumber(arg2) or (0 / 0)
    end
    assert(typeof(num1) == "number", "lastIndexStr should convert to number")

    if var1 < num1 then
        num1 = var1 + 1
    end

    return string.sub(str1, utf8.offset(str1, var4), utf8.offset(str1, num1) - 1)
end

return slice
