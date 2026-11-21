-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T11:10:33Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DiscoveryRoutingParent = script:FindFirstAncestor("DiscoveryRouting").Parent

local React = require(DiscoveryRoutingParent.React)
local useStore = require(DiscoveryRoutingParent.RoactUtils).Hooks.RoactRodux.useStore
local NavigationRodux = require(DiscoveryRoutingParent.NavigationRodux)
local selectCurrentLegacyRoute = NavigationRodux.Selectors.selectCurrentLegacyRoute
local GetLegacyNavigationStore = NavigationRodux.GetLegacyNavigationStore

local FFlagSignalsNavP2NavigationPrimitives = require(DiscoveryRoutingParent.SharedFlags).FFlagSignalsNavP2NavigationPrimitives

local function getCurrentLegacyRouteFromSignals()
    return GetLegacyNavigationStore(false).getCurrentLegacyRoute(false)
end

local function useGetCurrentLegacyRoute()
    if FFlagSignalsNavP2NavigationPrimitives then
        return getCurrentLegacyRouteFromSignals
    end
    local var1 = useStore()
    return React.useCallback(function()
        return selectCurrentLegacyRoute(var1:getState())
    end, { var1 })
end

return useGetCurrentLegacyRoute
