-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T20:20:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local module = {}

function module.new(tbl1)
    local tbl2 = tbl1 or {}
    local sampleInterval = tbl2.sampleInterval or 8
    local driftThreshold = tbl2.driftThreshold or 8

    local num1 = 0
    local initialAverage = tbl2.initialAverage or 0

    return {
        recordMeasurementAndShouldUpdateEstimates = function(num2: number): boolean
            num1 += 1
            if num1 < sampleInterval then
                return false
            end
            if math.abs(num2 - initialAverage) < driftThreshold then
                return false
            end
            initialAverage = num2
            num1 = 0
            return true
        end
    }
end
return module
