-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T08:01:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local toArrayContains = require(script.Parent.toArrayContains)

local function toBeOneOf(arg1, arg2)
    return toArrayContains(arg2, arg1)
end

return toBeOneOf
