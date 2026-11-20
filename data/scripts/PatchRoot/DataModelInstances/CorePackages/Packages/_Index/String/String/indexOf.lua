-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T16:10:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local var1 = "([" .. ("$%^()-[].?"):gsub("(.)", "%%%1") .. "])"

return function(str1: string, str2: string, num1: number?)
    local num2 = #str1
    local var2 = if num1 == nil then 1 elseif num1 < 1 then 1 else num1

    if #str2 == 0 then
        return if num2 < var2 then num2 else var2
    end

    if num2 < var2 then
        return -1
    end

    str2 = str2:gsub(var1, "%%%1")
    local num3 = #str2

    for i = var2, num2 do
        local num4 = i + num3 - 1

        if string.sub(str1, i, num4) == str2 then
            return i
        end
    end

    return -1
end
