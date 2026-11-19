-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T12:30:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function parseVersion(str1: string)
    local result = {}
    for _, value in string.split(str1, ".") do
        if string.match(value, "^%d+$") == nil then
            return nil
        end
        table.insert(result, tonumber(value))
    end
    return result
end

local function isVersionAtLeast(str1: string, str2: string)
    local var1 = parseVersion(str1)
    local var2 = parseVersion(str2)
    if var1 == nil or var2 == nil then
        return false
    end

    local num1 = #var1
    local num2 = #var2

    for i = 1, math.max(num1, num2) do
        local var3 = var1[i] or 0
        local var4 = var2[i] or 0
        if var3 ~= var4 then
            return var4 < var3
        end
    end
    return true
end

return isVersionAtLeast
