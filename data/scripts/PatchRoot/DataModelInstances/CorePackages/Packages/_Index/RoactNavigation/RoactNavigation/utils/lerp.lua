-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T13:21:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function lerp(arg1, arg2, arg3)
    return arg1 * (1 - arg3) + arg2 * arg3
end

return lerp
