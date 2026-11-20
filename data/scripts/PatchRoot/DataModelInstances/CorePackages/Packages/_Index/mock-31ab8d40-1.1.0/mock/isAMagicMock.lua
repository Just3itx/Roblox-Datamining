-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T09:51:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local symbols = require(script.Parent.symbols)

return function(arg1): boolean
    local var1 = getmetatable(arg1)
    return if var1 then var1[symbols.isMagicMock] ~= nil else false
end
