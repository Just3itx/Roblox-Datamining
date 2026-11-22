-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T05:21:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsParent = script:FindFirstAncestor("Moments").Parent

local AppPage = require(MomentsParent.RobloxAppEnums).AppPage
local NavigationRodux = require(MomentsParent.NavigationRodux)
local Selectors = NavigationRodux.Selectors
local SharedFlags = require(MomentsParent.SharedFlags)
local FFlagUseNavigationSelectors = SharedFlags.FFlagUseNavigationSelectors
local FFlagSignalsNavP3hMisc = SharedFlags.FFlagSignalsNavP3hMisc
local useSelector = require(MomentsParent.RoactUtils).Hooks.RoactRodux.useSelector
local useSignalState = require(MomentsParent.SignalsReact).useSignalState
local React = require(MomentsParent.React)
local GetLegacyNavigationStore = if FFlagSignalsNavP3hMisc then NavigationRodux.GetLegacyNavigationStore else nil
local isNavigationAvailable = if FFlagSignalsNavP3hMisc then require(MomentsParent.RobloxAppNavigation).isNavigationAvailable else nil

local function routeContainsMoments(arg1)
    if type(arg1) ~= "table" then
        return false
    end
    for _, value in arg1 do
        if type(value) == "table" and value.name == AppPage.Moments then
            return true
        end
    end
    return false
end

local function useMomentsTabIsVisible()
    if FFlagSignalsNavP3hMisc then
        local legacyNavigationStore = GetLegacyNavigationStore(false)
        local var1 = React.useMemo(function()
            return legacyNavigationStore.getRouteContainsPageSignal(AppPage.Moments)
        end, {})
        local var2 = useSignalState(var1)

        return not isNavigationAvailable() or var2
    end
    return useSelector(function(arg1)
        if not arg1.Navigation then
            return true
        end
        if FFlagUseNavigationSelectors then
            return (routeContainsMoments(Selectors.selectCurrentLegacyRoute(arg1)))
        end
        local history = arg1.Navigation.history
        if not history then
            return false
        end
        local var1 = history[#history]
        return (routeContainsMoments(var1))
    end)
end

return useMomentsTabIsVisible
