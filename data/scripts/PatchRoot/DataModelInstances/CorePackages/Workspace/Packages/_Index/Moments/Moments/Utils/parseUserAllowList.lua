-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T05:40:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function parseUserAllowList(str1: string?, num1: number)
    if not str1 or str1 == "" then
        return false
    end

    for _, value in string.split(str1, ",") do
        local var1 = value:match("^%s*(.-)%s*$")
        if var1 and tonumber(var1) == num1 then
            return true
        end
    end

    return false
end

return parseUserAllowList
