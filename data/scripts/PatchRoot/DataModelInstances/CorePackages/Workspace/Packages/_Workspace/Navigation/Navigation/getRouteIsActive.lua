-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T00:10:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Navigation = script:FindFirstAncestor("Navigation")
local NavigationParent = Navigation.Parent
local Array = require(NavigationParent.LuauPolyfill).Array

local getActiveRoutes = require(Navigation.getActiveRoutes)
local _types = require(script.Parent.types)

local function getRouteIsActive(arg1, routeName: string): boolean
    return Array.find(getActiveRoutes(arg1), function(arg2): boolean
        return arg2.routeName == routeName
    end) ~= nil
end

return getRouteIsActive
