-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T00:41:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local getUrl = nil

return {
    getUrl = function()
        return getUrl
    end,
    setUrl = function(str1: string?)
        getUrl = str1
    end
}
