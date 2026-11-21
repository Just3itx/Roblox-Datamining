-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T07:30:39Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function slice(str1: string, num1: number, num2: number)
    local var1 = utf8.len(str1)
    if var1 == nil then
        return nil
    end
    if num2 < num1 then
        return ""
    end
    if num1 < 1 or var1 < num2 then
        return nil
    end

    local num3 = utf8.offset(str1, num1)
    if num3 == nil then
        return nil
    end
    local num4 = utf8.offset(str1, num2 + 1)
    if num4 == nil then
        return string.sub(str1, num3)
    end

    return string.sub(str1, num3, num4 - 1)
end

return {
    splice = function(str1: string, num1: number, num2: number, str2: string)
        local var1 = utf8.len(str1)
        local var2 = utf8.len(str2)
        if var1 == nil or var2 == nil then
            return nil, nil
        end
        if num1 < 1 or num2 < num1 or var1 < num2 then
            return nil, nil
        end

        local num3 = utf8.offset(str1, num1)
        if num3 == nil then
            return nil, nil
        end
        local num4 = utf8.offset(str1, num2 + 1)
        return string.sub(str1, 1, num3 - 1) .. str2 .. (if num4 == nil then "" else string.sub(str1, num4)), num1 + var2
    end,
    slice = slice,
    charAt = function(str1: string, num1: number)
        return (slice(str1, num1, num1))
    end
}
