-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T10:31:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local str1 = utf8.char(8205)

local function countChars(str2: string)
    if utf8.len(str2) == nil then
        return #str2
    end

    local num1 = 0
    for value, value2 in utf8.graphemes(str2) do
        local num2 = 0
        for _, value3 in string.split(string.sub(str2, value, value2), str1) do
            if value3 ~= "" then
                num2 += 1
            end
        end
        num1 += math.max(num2, 1)
    end
    return num1
end

return countChars
