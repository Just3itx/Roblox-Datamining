-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T10:21:30Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local tbl1 = ({})

return {
    add = function(str1: string)
        tbl1[str1] = true
    end,
    remove = function(str1: string)
        tbl1[str1] = nil
    end,
    has = function(str1: string): boolean
        return tbl1[str1] == true
    end,
    clear = function()
        tbl1 = {}
    end
}
