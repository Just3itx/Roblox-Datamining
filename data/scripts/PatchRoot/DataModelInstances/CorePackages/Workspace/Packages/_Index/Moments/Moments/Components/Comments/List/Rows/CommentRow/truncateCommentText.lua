-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T03:51:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Moments = script:FindFirstAncestor("Moments")

local escapeRichText = require(Moments.Utils.escapeRichText)

local function truncateCommentText(str1: string, str2: string, num1: number, func1: (...any) -> (...any))
    if func1(escapeRichText(str1)) <= num1 then
        return nil
    end

    local tbl1 = {}
    for _, value in utf8.graphemes(str1) do
        table.insert(tbl1, value)
    end

    local function candidate(num2: number) -- Luacid: Inlined by compiler; 2 call sites recovered
        local var1 = if num2 > 0 then string.sub(str1, 1, tbl1[num2]) else ""
        return escapeRichText((string.gsub(var1, "%s+$", ""))) .. str2
    end

    local num2 = #tbl1 - 1
    local num3 = 0

    while num3 < num2 do
        local num4 = (num3 + num2 + 1) // 2
        if func1((candidate(num4))) <= num1 then
            num3 = num4
        else
            num2 = num4 - 1
        end
    end

    return candidate(num3)
end

return truncateCommentText
