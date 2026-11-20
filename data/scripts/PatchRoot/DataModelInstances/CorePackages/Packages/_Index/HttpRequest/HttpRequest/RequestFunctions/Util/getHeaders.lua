-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T08:30:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
return function(arg1, arg2)
    local var1 = arg1 or {}
    if (arg2 == "POST" or arg2 == "PATCH") and not var1["Content-Type"] then
        var1["Content-Type"] = "application/json"
    end

    return var1
end
