-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T01:30:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
return function(arg1): boolean
    return not (arg1 == nil or type(arg1) ~= "table")
        and (arg1.failureReason ~= nil and arg1.expirationTimeInMinutes ~= nil
            or not (arg1.FailureReason == nil) and arg1.ExpirationTimeInMinutes ~= nil)
end
