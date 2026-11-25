-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T00:10:41Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local _types = require(script.Parent.types)

local function getCurrentNavigationState(arg1)
    if arg1.routes and arg1.index then
        return getCurrentNavigationState(arg1.routes[arg1.index])
    end
    return arg1
end
return getCurrentNavigationState
