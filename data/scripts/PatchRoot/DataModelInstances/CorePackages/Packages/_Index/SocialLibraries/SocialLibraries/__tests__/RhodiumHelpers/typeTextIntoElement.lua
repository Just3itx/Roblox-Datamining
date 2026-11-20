-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T15:31:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
return function(arg1, arg2)
    for i = 1, #arg2 do
        arg1:sendText(arg2:sub(i, i))
    end

    wait(0)
end
