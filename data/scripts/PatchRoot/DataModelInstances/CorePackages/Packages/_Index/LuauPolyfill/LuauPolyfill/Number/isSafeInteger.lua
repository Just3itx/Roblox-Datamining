-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T04:51:06Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local isInteger = require(script.Parent.isInteger)
local MAX_SAFE_INTEGER = require(script.Parent.MAX_SAFE_INTEGER)

return function(arg1)
    return isInteger(arg1) and math.abs(arg1) <= MAX_SAFE_INTEGER
end
