-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T05:01:29Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
return function(arg1, arg2)
    return function(arg3, arg4)
        if arg3 == nil then
            arg3 = arg1
        end

        local var1 = arg2[arg4.type]

        if var1 then
            return var1(arg3, arg4)
        end

        return arg3
    end
end
