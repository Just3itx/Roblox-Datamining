-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T01:30:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function isErrorReasonContainsEconomicRestrictions(str1: string): boolean
    return string.find(str1, "EconomicRestrictions") ~= nil
end

return isErrorReasonContainsEconomicRestrictions
