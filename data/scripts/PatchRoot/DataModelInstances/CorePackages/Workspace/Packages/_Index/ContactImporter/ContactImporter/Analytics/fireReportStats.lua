-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T08:20:39Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
return function(arg1)
    return function(arg2, arg3)
        local var1 = arg1.eventList[arg2]
        arg1.diagImpl:reportStats(var1.name, arg3.loadingTime)
    end
end
