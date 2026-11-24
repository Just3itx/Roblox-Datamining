-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T04:01:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
return function(arg1): boolean
    if arg1 == nil or tostring(arg1) == "" then
        return true
    end

    local var1 = tonumber(arg1)
    return not (var1 == nil) and var1 <= 0
end
