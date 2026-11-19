-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T18:40:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
return function(arg1, arg2): boolean
    if arg1 == nil or arg2 == nil then
        return false
    end
    return arg1.UserInputType == Enum.UserInputType.Touch and arg2 ~= arg1
end
