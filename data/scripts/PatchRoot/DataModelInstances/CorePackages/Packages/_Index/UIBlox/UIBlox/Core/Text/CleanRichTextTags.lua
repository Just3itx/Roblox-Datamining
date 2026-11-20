-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T19:30:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function cleanRichTextTags(str1: string): string
    local str2 = ""
    local num1 = 0

    for i = 1, #str1 do
        local str3 = string.sub(str1, i, i)

        if str3 == "<" then
            num1 += 1
        elseif str3 == ">" and num1 > 0 then
            num1 -= 1
        elseif num1 == 0 then
            str2 ..= str3
        end
    end

    return if num1 == 0 then str2 else str1
end

return cleanRichTextTags
