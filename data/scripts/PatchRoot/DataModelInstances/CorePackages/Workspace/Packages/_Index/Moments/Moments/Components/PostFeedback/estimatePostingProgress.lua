-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:31:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function estimatePostingProgress(num1: number, num2: number, num3: number, num4: number): number
    local num5 = math.clamp(num4, 0, 1)
    if num3 <= 0 then
        return num5
    end
    return num5 * math.clamp((num1 - num2) / num3, 0, 1)
end

return estimatePostingProgress
