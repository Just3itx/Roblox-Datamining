-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T19:51:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local get = nil

return {
    get = function()
        return get
    end,
    setForTesting = function(bool1: boolean?): boolean?
        local var2 = get
        get = bool1
        return var2
    end
}
