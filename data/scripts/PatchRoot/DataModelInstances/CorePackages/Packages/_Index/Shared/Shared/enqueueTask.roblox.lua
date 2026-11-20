-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T15:11:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local setTimeout = require(scriptParentParent.LuauPolyfill).setTimeout

return function(arg1)
    return setTimeout(arg1, 0)
end
