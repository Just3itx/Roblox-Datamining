-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T05:10:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function fitKeypoints(tbl1): {NumberSequenceKeypoint}
    local result = {}
    for _, value in tbl1 do
        local num1 = math.clamp(value.Time, 0, 1)
        local value2 = value.Value
        local var1 = result[#result]
        if var1 == nil then
            table.insert(result, NumberSequenceKeypoint.new(0, value2))
        elseif var1.Time < num1 then
            table.insert(result, NumberSequenceKeypoint.new(num1, value2))
        end
    end

    local var1 = result[#result]
    if var1 == nil then
        return { NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(1, 1) }
    end

    if var1.Time < 1 then
        table.insert(result, NumberSequenceKeypoint.new(1, var1.Value))
    end

    return result
end

return {
    fittedGradientTransparency = function(tbl1, num1: number, num2: number)
        local num3 = 1 - num2
        local num4 = math.clamp(num3 * tbl1[1], 0, 1)
        local num5 = math.clamp(num3 * tbl1[2], 0, 1)
        local var1 = tbl1[3]
        if var1 < 1 then
            return nil
        end

        local var2 = if var1 < num1 then 1 else num1 / var1

        local var3 = (if num4 > 0 then var2 * (num4 + 1) else 0) + (if num5 > 0 then var2 * (num5 + 1) else 0)
        if var3 > 1 then
            var2 /= var3
        end

        local tbl2 = {}
        if num4 > 0 then
            table.insert(tbl2, NumberSequenceKeypoint.new(0, 1 - num4))
            table.insert(tbl2, NumberSequenceKeypoint.new(var2, 1 - num4))
            table.insert(tbl2, NumberSequenceKeypoint.new(var2 + var2 * num4, 1))
        else
            table.insert(tbl2, NumberSequenceKeypoint.new(0, 1))
        end
        if num5 > 0 then
            table.insert(tbl2, NumberSequenceKeypoint.new(1 - var2 * num5 - var2, 1))

            table.insert(tbl2, NumberSequenceKeypoint.new(1 - var2, 1 - num5))
            table.insert(tbl2, NumberSequenceKeypoint.new(1, 1 - num5))
        else
            table.insert(tbl2, NumberSequenceKeypoint.new(1, 1))
        end

        return NumberSequence.new((fitKeypoints(tbl2)))
    end
}
