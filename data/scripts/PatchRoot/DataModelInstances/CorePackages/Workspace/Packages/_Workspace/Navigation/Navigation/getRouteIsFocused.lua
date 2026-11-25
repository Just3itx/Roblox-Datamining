-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T00:10:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Navigation = script:FindFirstAncestor("Navigation")
local NavigationParent = Navigation.Parent
local Array = require(NavigationParent.LuauPolyfill).Array

local getFocusedRoutes = require(Navigation.getFocusedRoutes)
local _types = require(script.Parent.types)

local function getRouteIsFocused(arg1, routeName: string): boolean
    return Array.find(getFocusedRoutes(arg1), function(arg2): boolean
        return arg2.routeName == routeName
    end) ~= nil
end

return getRouteIsFocused
