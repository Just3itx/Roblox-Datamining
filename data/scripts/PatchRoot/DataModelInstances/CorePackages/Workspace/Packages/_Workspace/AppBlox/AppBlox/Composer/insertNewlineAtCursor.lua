-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T06:20:38Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function insertNewlineAtCursor(str1: string, num1: number): (string, number)
    if num1 < 1 then
        local var1 = utf8.len(str1)
        local str2 = str1 .. "\n"

        if var1 then
            return str2, var1 + 1
        end

        return str2, 1
    end

    local num2 = utf8.offset(str1, num1)
    if num2 ~= nil then
        return string.sub(str1, 1, num2 - 1) .. "\n" .. string.sub(str1, num2), num1 + 1
    end

    local var1 = utf8.len(str1)
    local str2 = str1 .. "\n"

    if var1 then
        return str2, var1 + 1
    end

    return str2, 1
end

return insertNewlineAtCursor
