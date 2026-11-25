-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T07:51:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
return function(str1: string, str2: string, str3: string, str4: string?, num1: number?)
    local result = {}

    if str4 ~= nil then
        table.insert(result, str1 .. str4 .. str2 .. str3)
    else
        table.insert(result, str1 .. str2 .. str3)
    end

    if num1 ~= nil then
        local str5 = tostring(num1)
        if str4 ~= nil then
            table.insert(result, str1 .. str4 .. str2 .. str5 .. str3)
            return result
        end

        table.insert(result, str1 .. str2 .. str5 .. str3)
    end

    return result
end
