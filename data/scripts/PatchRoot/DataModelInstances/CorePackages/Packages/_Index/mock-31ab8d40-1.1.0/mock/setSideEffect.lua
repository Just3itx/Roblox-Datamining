-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T10:00:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local symbols = require(script.Parent.symbols)

return function(arg1, value)
    getmetatable(arg1)[symbols.SideEffect] = value and { value = value, calls = 0 } or nil
end
