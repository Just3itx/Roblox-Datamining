-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T00:10:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local _types = require(script.Parent.types)

local function getRouteKeyIsInNavigationState(key: string, arg1)
    if arg1.key == key then
        return true
    end
    if arg1.routes then
        for _, value in pairs(arg1.routes) do
            if getRouteKeyIsInNavigationState(key, value) then
                return true
            end
        end
    end
    return false
end

return getRouteKeyIsInNavigationState
