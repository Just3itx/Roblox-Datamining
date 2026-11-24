-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T07:40:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function getBorderlessBubbleChatAnimation(num1: number)
    if num1 < 0.5 then
        local num2 = math.max(num1, 0) / 0.5
        return {
            scale = if num2 < 0.6 then num2 * 1.2 / 0.6 else 1.2 - (num2 - 0.6) * 0.19999999999999996 / 0.4,
            yOffset = 0,
            transparency = 0,
            isComplete = false
        }
    end

    if num1 < 2.9 then
        return {
            scale = 1,
            yOffset = math.sin((num1 - 0.5) * 2 * math.pi * 1.25) * -6,
            transparency = 0,
            isComplete = false
        }
    end

    local num2 = math.min((num1 - 2.9) / 0.5, 1)
    local transparency = num2 * num2
    return {
        scale = 1,
        yOffset = transparency * -24,
        transparency = transparency,
        isComplete = num1 >= 3.4
    }
end

return getBorderlessBubbleChatAnimation
