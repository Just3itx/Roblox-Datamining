-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T07:50:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function computeEditDistance(str1: string, str2: string)
    if str1 == str2 then
        return 0
    end
    local num1 = #str1
    local num2 = #str2
    if num1 == 0 then
        return num2
    end
    if num2 == 0 then
        return num1
    end

    if not (num1 < num2) then
        local str3 = str1
        str1 = str2
        str2 = str3
        str3 = num2
        num2 = num1
        num1 = str3
    end

    local var1 = table.create(num1 + 1)
    local var2 = table.create(num1 + 1)
    for i = 0, num1 do
        var1[i + 1] = i
    end

    for i = 1, num2 do
        var2[1] = i
        local var3 = string.byte(str2, i)
        for j = 1, num1 do
            local num3 = if var3 == string.byte(str1, j) then 0 else 1
            local var4 = var1[j + 1] + 1
            local var5 = var2[j] + 1
            local var6 = var1[j] + num3

            if var5 < var4 then
                var4 = var5
            end

            if not (var6 < var4) then
                var6 = var4
            end

            var2[j + 1] = var6
        end

        local var4 = var1
        var1 = var2
        var2 = var4
    end

    return var1[num1 + 1]
end

return computeEditDistance
