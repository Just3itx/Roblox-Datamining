-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T00:10:42Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local _types = require(script.Parent.types)
local getCurrentRouteState = require(script.Parent.getCurrentRouteState)

local function getCurrentRouteKey(arg1)
    local currentRouteState = getCurrentRouteState(arg1)
    return if currentRouteState then currentRouteState.key else nil
end

return getCurrentRouteKey
