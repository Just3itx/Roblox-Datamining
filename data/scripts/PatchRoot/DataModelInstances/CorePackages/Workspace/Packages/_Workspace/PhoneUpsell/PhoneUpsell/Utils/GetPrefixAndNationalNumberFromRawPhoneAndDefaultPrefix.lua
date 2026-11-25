-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T02:20:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
return function(str1: string, str2: string)
    local var1 = str1:gsub("%D", "")
    local var2 = str2:gsub("%D", "")
    if string.find(var1, var2) ~= 1 then
        return str2, var1
    end

    return str2, string.sub(var1, string.len(var2) + 1)
end
