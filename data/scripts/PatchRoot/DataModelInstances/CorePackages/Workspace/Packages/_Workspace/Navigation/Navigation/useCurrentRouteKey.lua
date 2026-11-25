-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T00:10:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local getCurrentRouteKey = require(script.Parent.getCurrentRouteKey)
local useNavigation = require(script.Parent.useNavigation)

local function useCurrentRouteKey()
    local var1 = useNavigation()
    return getCurrentRouteKey(var1)
end

return useCurrentRouteKey
