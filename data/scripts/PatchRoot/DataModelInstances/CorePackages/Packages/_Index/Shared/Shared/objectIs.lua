-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T15:20:35Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function is(arg1, arg2): boolean
    return arg1 == arg2 and (arg1 ~= 0 or 1 / arg1 == 1 / arg2) or not (arg1 == arg1) and arg2 ~= arg2
end

return is
