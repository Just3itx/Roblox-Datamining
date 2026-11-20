-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T10:00:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local symbols = require(script.Parent.symbols)

return function(arg1, arg2)
    getmetatable(arg1)[symbols.ReturnValue] = { arg2 }
end
