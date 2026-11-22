-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T01:30:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function parseErrorReasonToEconomicRestriction(str1: string)
    local tbl1 = string.split(str1, "/")

    local num1 = #tbl1
    return {
        timeoutMinutes = tbl1[num1],
        violationType = tbl1[num1 - 1]
    }
end

return parseErrorReasonToEconomicRestriction
