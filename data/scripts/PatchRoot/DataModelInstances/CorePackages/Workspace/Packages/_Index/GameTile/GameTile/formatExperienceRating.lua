-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T22:21:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function formatExperienceRating(num1: number, num2: number, str1: string?, bool1: boolean?): string
    if num1 + num2 == 0 then
        return str1 or "--"
    end
    local num3 = math.round(num1 / (num1 + num2) * 100)
    if bool1 then
        return `{num3}%`
    end
    return tostring(num3)
end

return formatExperienceRating
