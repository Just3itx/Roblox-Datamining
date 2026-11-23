-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T04:11:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function getIsInstanceVisible(arg1, arg2, num1: number): boolean
    if not arg1 then
        return false
    end

    local absoluteSize = arg1.AbsoluteSize

    if absoluteSize.X <= 0 or absoluteSize.Y <= 0 then
        return false
    end

    local absolutePosition = arg1.AbsolutePosition
    local var1 = absolutePosition + absoluteSize

    local num2 = math.max(absolutePosition.X, arg2.min.X)
    local num3 = math.min(var1.X, arg2.max.X) - num2

    if num3 <= 0 then
        return false
    end

    local num4 = math.max(absolutePosition.Y, arg2.min.Y)
    local num5 = math.min(var1.Y, arg2.max.Y) - num4

    if num5 <= 0 then
        return false
    end

    local num6 = num3 * num5
    local var2 = absoluteSize.X * absoluteSize.Y

    return num1 <= num6 * 100 / var2
end

return getIsInstanceVisible
