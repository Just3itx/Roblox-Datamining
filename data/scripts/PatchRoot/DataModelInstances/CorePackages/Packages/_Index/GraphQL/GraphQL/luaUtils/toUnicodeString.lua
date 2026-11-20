-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T08:01:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local String = require(scriptParentParentParent.LuauPolyfill).String

return function(arg1)
    local str1 = "0000" .. string.format("%x", arg1)

    return "\"\\u" .. String.slice(str1, -4):upper() .. "\""
end
