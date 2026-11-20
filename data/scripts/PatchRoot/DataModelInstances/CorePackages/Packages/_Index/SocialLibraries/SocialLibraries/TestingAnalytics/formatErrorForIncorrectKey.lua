-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T16:01:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
return function(arg1)
    return function(arg2, arg3)
        local var1, var2 = arg1(arg2)
        if var1 == false then
            return var1, var2 .. ". Issue with: " .. arg3
        end

        return var1
    end
end
