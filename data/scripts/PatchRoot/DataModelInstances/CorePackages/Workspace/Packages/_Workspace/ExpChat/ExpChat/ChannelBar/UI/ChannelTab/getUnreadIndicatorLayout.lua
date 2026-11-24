-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T07:41:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
return function(bool1: boolean, bool2: boolean, num1: number?, num2: number?, num3: number, num4: number, num5: number)
    if not bool1 or bool2 or num1 == nil or num2 == nil then
        return nil
    end

    local num6 = math.max(0, num1 - num3 * 2)
    local num7 = num4 + num5
    local isPinned = num6 < num2 + num7 * 2
    local textLeft = if isPinned then num3 + num7 else (num1 - num2) / 2

    if isPinned then
        num6 = math.max(0, num6 - num7)
    end

    return {
        isPinned = isPinned,
        textLeft = textLeft,
        textWidth = math.min(num2, num6)
    }
end
