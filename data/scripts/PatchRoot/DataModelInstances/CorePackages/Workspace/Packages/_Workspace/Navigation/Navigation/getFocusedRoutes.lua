-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T00:10:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Navigation = script:FindFirstAncestor("Navigation")
local _types = require(script.Parent.types)
local NavigationParent = Navigation.Parent
local Array = require(NavigationParent.LuauPolyfill).Array

local function getFocusedRoutes(arg1)
    local focusedRoutes = {}

    if arg1 == nil then
        return focusedRoutes
    end

    if arg1.key or arg1.routeName then
        table.insert(focusedRoutes, arg1)
    end

    if arg1.routes and arg1.index ~= nil then
        local var1 = arg1.routes[arg1.index]
        focusedRoutes = Array.concat(focusedRoutes, getFocusedRoutes(var1))
    end
    return focusedRoutes
end

return getFocusedRoutes
