-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T19:20:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialReducerAdaptors = script:FindFirstAncestor("SocialReducerAdaptors")
local llama = require(SocialReducerAdaptors.dependencies).llama

return function(arg1, tbl1, arg2)
    return function(arg3, tbl2)
        arg3 = arg3 or arg2

        local var1 = tbl1[tbl2.type]
        local var2 = not var1 and { tbl2 } or var1(tbl2)

        return llama.List.reduce(var2, arg1, arg3)
    end
end
