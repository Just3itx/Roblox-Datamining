-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T12:51:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local getSnapshot = nil

return {
    setSnapshot = function(tbl1)
        getSnapshot = tbl1
    end,
    getSnapshot = function()
        return getSnapshot
    end,
    clearSnapshot = function()
        getSnapshot = nil
    end
}
