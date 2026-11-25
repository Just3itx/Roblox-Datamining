-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T00:10:39Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Navigation = script:FindFirstAncestor("Navigation")
local _types = require(script.Parent.types)
local NavigationParent = Navigation.Parent
local Array = require(NavigationParent.LuauPolyfill).Array

local function isStackRoute(arg1): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return not (arg1.index == nil or arg1.routes == nil) and arg1.isTransitioning ~= nil
end

local function getActiveRoutes(arg1)
    local activeRoutes = {}

    if arg1 == nil then
        return activeRoutes
    end

    if arg1.key or arg1.routeName then
        table.insert(activeRoutes, arg1)
    end

    if arg1.routes and arg1.index ~= nil then
        local routes = arg1.routes
        local index = arg1.index

        if isStackRoute(arg1) then
            for i = 1, index - 1 do
                local var1 = routes[i]
                activeRoutes = Array.concat(activeRoutes, getActiveRoutes(var1))
            end
        end

        local var1 = routes[index]
        activeRoutes = Array.concat(activeRoutes, getActiveRoutes(var1))
    end
    return activeRoutes
end

return getActiveRoutes
