-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T20:51:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local Error = require(scriptParentParentParent.LuauPolyfill).Error

local function invariant(arg1, arg2, ...)
    if not arg1 then
        error(Error(string.format(arg2, ...)))
    end
end

return invariant
