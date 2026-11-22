-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T01:30:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function parseEconomicRestrictionsExpirationTimeInMinutes(arg1)
    if arg1 then
        return arg1.ExpirationTimeInMinutes or arg1.expirationTimeInMinutes or arg1.timeoutMinutes
    end

    return nil
end

return parseEconomicRestrictionsExpirationTimeInMinutes
