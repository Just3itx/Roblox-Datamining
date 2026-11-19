-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T05:00:48Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local function lastIndexOf(str1: string, str2: string, num1: number?)
    local num2 = string.len(str1)

    local num3 = if num1 and num1 < 1 then 1 else num1 or num2

    if num1 and num2 < num1 then
        num3 = num2
    end

    if str2 == "" then
        return num3
    end

    local var1 = nil
    local num4 = 0
    local previousValue

    repeat
        previousValue = var1
        local var2
        var2, num4 = string.find(str1, str2, num4 + 1, true)
        var1 = var2
    until var2 == nil or num3 < var2

    return if previousValue == nil then -1 else previousValue
end

return lastIndexOf
