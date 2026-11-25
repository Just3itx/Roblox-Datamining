-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T00:10:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local _types = require(script.Parent.types)
local getCurrentNavigationState = require(script.Parent.getCurrentNavigationState)

local function getCurrentRouteState(arg1)
    if not (arg1 and arg1.state) then
        return nil
    end

    return (getCurrentNavigationState(arg1.state))
end

return getCurrentRouteState
