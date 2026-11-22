-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T06:30:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TweenService = game:GetService("TweenService")

local function linearInterpolate(num1: number, num2: number, num3: number): number -- Luacid: Inlined by compiler; 1 call site recovered
    return num1 + (num2 - num1) * num3
end

local function getEasingNumberSequence(num1: number, num2: number, num3: number, easingStyle: Enum.EasingStyle, easingDirection: Enum.EasingDirection): {NumberSequenceKeypoint}
    local easingNumberSequence = {}
    for i = 0, num3 do
        local num4 = i / num3
        local num5 = linearInterpolate(num1, num2, (TweenService:GetValue(num4, easingStyle, easingDirection)))

        table.insert(easingNumberSequence, NumberSequenceKeypoint.new(num4, num5))
    end

    return easingNumberSequence
end

return getEasingNumberSequence
