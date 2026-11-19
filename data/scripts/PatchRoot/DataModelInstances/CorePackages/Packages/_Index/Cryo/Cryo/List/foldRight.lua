-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T04:40:39Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local function foldRight(arg1, arg2, arg3)
    for i = #arg1, 1, -1 do
        arg3 = arg2(arg3, arg1[i], i)
    end

    return arg3
end

return foldRight
