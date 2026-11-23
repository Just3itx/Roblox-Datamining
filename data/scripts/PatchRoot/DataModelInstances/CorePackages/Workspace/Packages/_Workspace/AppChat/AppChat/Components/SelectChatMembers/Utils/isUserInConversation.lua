-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T08:31:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
return function(arg1, arg2)
    for _, participant in pairs(arg2.participants) do
        if arg1 == participant then
            return true
        end
    end

    return false
end
