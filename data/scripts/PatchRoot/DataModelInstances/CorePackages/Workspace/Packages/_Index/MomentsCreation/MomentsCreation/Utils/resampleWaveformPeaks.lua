-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T07:40:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function resampleWaveformPeaks(tbl1, num1: number, num2: number, num3: number)
    local result = {}
    local num4 = #tbl1
    for i = 1, num1 do
        local var1

        if num4 > 0 then
            local num5 = math.floor((i - 1) / num1 * num4) + 1
            local num6 = math.floor(i / num1 * num4)
            local num7 = 0

            for j = num5, math.max(num5, num6) do
                num7 = math.max(num7, tbl1[j])
            end
            var1 = math.clamp(num7, num2, num3)
        else
            var1 = num2
        end
        table.insert(result, var1)
    end
    return result
end

return resampleWaveformPeaks
