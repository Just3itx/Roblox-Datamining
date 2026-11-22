-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T15:00:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local tbl1 = { week = true }

local function isSupportedTrialPeriodType(str1: string?): boolean
    return not (str1 == nil) and tbl1[string.lower(str1)] == true
end

return isSupportedTrialPeriodType
