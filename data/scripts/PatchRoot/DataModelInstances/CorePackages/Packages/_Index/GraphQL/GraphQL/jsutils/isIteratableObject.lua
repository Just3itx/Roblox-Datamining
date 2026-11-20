-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T07:51:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
return {
    isIteratableObject = function(arg1): boolean
        return typeof(arg1) == "table" and (next(arg1) == nil or #arg1 ~= 0)
    end
}
