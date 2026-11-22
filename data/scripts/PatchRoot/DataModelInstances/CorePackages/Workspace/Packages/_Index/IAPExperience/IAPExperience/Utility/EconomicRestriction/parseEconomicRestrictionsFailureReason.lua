-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T01:30:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function parseEconomicRestrictionsFailureReason(arg1)
    if arg1 then
        return arg1.FailureReason or arg1.failureReason or arg1.violationType
    end

    return nil
end

return parseEconomicRestrictionsFailureReason
