-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T13:01:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
return function(num1: number, num2: number, num3: number): NumberSequence
    if num2 <= 0 then
        return NumberSequence.new(0)
    end
    local n = math.clamp(num3, 0, 1)
    local time = math.clamp(num1 / num2, 0, 1)
    if n == 0 or time == 0 then
        return NumberSequence.new(0)
    elseif time == 1 then
        return NumberSequence.new(n)
    elseif time <= 0.001 then
        return NumberSequence.new(
            { NumberSequenceKeypoint.new(0, n), NumberSequenceKeypoint.new(time, 0), NumberSequenceKeypoint.new(1, 0) }
        )
    end

    return NumberSequence.new({
        NumberSequenceKeypoint.new(0, n),
        NumberSequenceKeypoint.new(time - 0.001, n),
        NumberSequenceKeypoint.new(time, 0),
        NumberSequenceKeypoint.new(1, 0)
    })
end
