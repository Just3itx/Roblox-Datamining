-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T05:41:26Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
return {
    isNonNullObject = function(arg1): boolean
        return not (arg1 == nil) and type(arg1) == "table"
    end
}
