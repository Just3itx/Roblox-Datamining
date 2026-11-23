-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T10:31:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function countUtf16Units(str1: string)
    if utf8.len(str1) == nil then
        return #str1
    end

    local num1 = 0
    for _, value in utf8.codes(str1) do
        num1 += if value > 65535 then 2 else 1
    end
    return num1
end

return countUtf16Units
