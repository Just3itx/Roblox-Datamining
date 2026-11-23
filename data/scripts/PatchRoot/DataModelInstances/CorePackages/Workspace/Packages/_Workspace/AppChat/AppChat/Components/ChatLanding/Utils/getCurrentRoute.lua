-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T08:11:33Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
return function(arg1)
    while arg1 and arg1.index and arg1.routes do
        arg1 = arg1.routes[arg1.index]
    end

    return arg1
end
