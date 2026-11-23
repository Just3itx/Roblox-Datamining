-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T06:20:37Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function getVisibleLineCount(str1: string, num1: number): number
    local num2 = 1
    if str1 ~= "" then
        for _ in string.gmatch(str1, "\n") do
            num2 += 1
        end
    end

    return math.clamp(num2, 1, num1)
end

return getVisibleLineCount
