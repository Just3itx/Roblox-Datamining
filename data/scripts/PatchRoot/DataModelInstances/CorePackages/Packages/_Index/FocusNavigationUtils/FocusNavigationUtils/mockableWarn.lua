-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T03:50:32Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local warn2 = warn
return (setmetatable({
    mock = function(arg1)
        warn2 = arg1
    end,
    unmock = function()
        warn2 = warn
    end
}, {
    __call = function(_, ...)
        warn2(...)
    end
}))
