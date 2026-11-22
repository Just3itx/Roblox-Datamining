-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T03:41:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function truncateToMaxLength(str1: string, num1: number): string
    local num2 = math.max(0, math.floor(num1))
    local var1 = utf8.len(str1)
    if var1 == nil then
        if num2 < #str1 then
            return string.sub(str1, 1, num2)
        end

        return str1
    end
    if var1 <= num2 then
        return str1
    end
    return string.sub(str1, 1, utf8.offset(str1, num2 + 1) - 1)
end

return truncateToMaxLength
