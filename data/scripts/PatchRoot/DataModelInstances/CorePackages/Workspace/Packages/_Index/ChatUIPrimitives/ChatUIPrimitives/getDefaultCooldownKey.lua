-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T07:11:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local _Types = require(script.Parent.UniversalMessage.Types)

local function getDefaultCooldownKey(arg1): string?
    return if arg1.kind == "preset" then "preset" else nil
end

return getDefaultCooldownKey
