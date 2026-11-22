-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T07:51:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local NavigationRodux = script:FindFirstAncestor("NavigationRodux")
local NavigationRoduxParent = NavigationRodux.Parent

local Cryo = require(NavigationRoduxParent.Cryo)
local tutils = require(NavigationRoduxParent.tutils)
local Navigation = require(NavigationRoduxParent.Navigation)
local getCurrentRouteState = Navigation.getCurrentRouteState
local getCurrentNavigationState = Navigation.getCurrentNavigationState
local Signals = require(NavigationRoduxParent.Signals)

local SharedFlags = require(NavigationRoduxParent.SharedFlags)
local FFlagAppIaHomeSubTab = SharedFlags.FFlagAppIaHomeSubTab
local FFlagSignalsNavProjected = SharedFlags.FFlagSignalsNavProjected
local FFlagSignalsNavP3Final = SharedFlags.FFlagSignalsNavP3Final
local FFlagSignalsNavP2NavigationPrimitives = SharedFlags.FFlagSignalsNavP2NavigationPrimitives

local Constants = require(NavigationRodux.Constants)
local _types = require(NavigationRodux.types)

local Utils = require(script.Parent.Utils)
local getLegacyPageFromRoactNavigationRoute = Utils.getLegacyPageFromRoactNavigationRoute
local getLegacyRouteFromRoactNavigationState = Utils.getLegacyRouteFromRoactNavigationState

local function legacyPageEqual(arg1, arg2) -- Luacid: Inlined by compiler; 1 call site recovered
    return tutils.shallowEqual(arg1, arg2)
end

local function legacyRouteEqual(arg1, arg2)
    if arg1 == arg2 then
        return true
    end
    if arg1 == nil or arg2 == nil or #arg1 ~= #arg2 then
        return false
    end
    for i = 1, #arg1 do
        if not legacyPageEqual(arg1[i], arg2[i]) then
            return false
        end
    end
    return true
end

local function legacyHistoryEqual(arg1, arg2)
    if arg1 == arg2 then
        return true
    end
    if arg1 == nil or arg2 == nil or #arg1 ~= #arg2 then
        return false
    end
    for i = 1, #arg1 do
        if not legacyRouteEqual(arg1[i], arg2[i]) then
            return false
        end
    end
    return true
end

local function routeStateEqual(arg1, arg2): boolean
    if arg1 == arg2 then
        return true
    end
    if type(arg1) ~= "table" or type(arg2) ~= "table" then
        return false
    end

    return arg1.routeName == arg2.routeName and arg1.key == arg2.key and tutils.shallowEqual(arg1.params or {}, arg2.params or {})
end

local function createLegacyNavigationStore(arg1)
    local getHistory = Signals.createComputed(function(arg2)
        local result = {}

        local state = arg1.getState(arg2)

        for i = 1, state.index do
            local var1 = state.routes[i]
            if var1.routes and var1.routeName == Constants.TempRnSwitchNavigatorName then
                var1 = var1.routes[var1.index]
            end

            if FFlagAppIaHomeSubTab and var1.routes and var1.routeName == Constants.HomeContainerName then
                var1 = var1.routes[var1.index]
            end

            local legacyPageFromRoactNavigationRoute = getLegacyPageFromRoactNavigationRoute(var1)
            table.insert(result, Cryo.List.join(result[i - 1] or {}, { legacyPageFromRoactNavigationRoute }))
        end

        return result
    end, if FFlagSignalsNavP3Final then legacyHistoryEqual else nil)

    local computed2 = Signals.createComputed(function(arg2)
        local state = arg1.getState(arg2)
        return getLegacyRouteFromRoactNavigationState(state)
    end, if FFlagSignalsNavP3Final then legacyRouteEqual else nil)

    local getCurrentRoute = Signals.createComputed(function(arg2)
        if FFlagSignalsNavProjected then
            local state = arg1.getState(arg2)
            return (getCurrentNavigationState(state))
        end
        local navigation = arg1.getNavigation(arg2)
        return (getCurrentRouteState(navigation))
    end, if FFlagSignalsNavP3Final then routeStateEqual else nil)

    local getCurrentLegacyRoute = Signals.createComputed(function(arg2)
        local var1 = getHistory(arg2)
        return var1[#var1]
    end, if FFlagSignalsNavP3Final then legacyRouteEqual else nil)

    local getCurrentPage = Signals.createComputed(function(arg2)
        local var1 = getHistory(arg2)
        local var2 = var1[#var1]
        return var2[#var2]
    end, if FFlagSignalsNavP3Final then legacyPageEqual else nil)

    local getCurrentPageName = if FFlagSignalsNavP2NavigationPrimitives then Signals.createComputed(function(arg2)
        local var1 = getHistory(arg2)
        local var2 = var1[#var1]
        return var2[#var2].name
    end) else nil

    local tbl1 = ({})
    local function getIsCurrentPageSignal(str1: string)
        local var1 = tbl1[str1]
        if var1 then
            return var1
        end
        local computed7 = Signals.createComputed(function(arg2): boolean
            return getCurrentPageName(arg2) == str1
        end)
        tbl1[str1] = computed7
        return computed7
    end

    local tbl2 = ({})
    local function getRouteContainsPageSignal(name: string)
        local var1 = tbl2[name]
        if var1 then
            return var1
        end
        local computed7 = Signals.createComputed(function(arg2)
            local var2 = computed2(arg2)
            if var2 then
                for _, value in var2 do
                    if value.name == name then
                        return true
                    end
                end
            end
            return false
        end)
        tbl2[name] = computed7
        return computed7
    end

    local getCurrentTabName = if FFlagSignalsNavP2NavigationPrimitives then Signals.createComputed(function(arg2)
        local var1 = getHistory(arg2)
        return var1[#var1][1].name
    end) else nil

    local getCanGoBack = if FFlagSignalsNavP2NavigationPrimitives then Signals.createComputed(function(arg2): boolean
        local var1 = getHistory(arg2)
        return #var1[#var1] > 1
    end) else nil

    local getRouteDepth = if FFlagSignalsNavP2NavigationPrimitives then Signals.createComputed(function(arg2): number
        local var1 = getHistory(arg2)
        return #var1[#var1]
    end) else nil

    local getCurrentRouteKey = if FFlagSignalsNavP2NavigationPrimitives then Signals.createComputed(function(arg2)
        return getCurrentRoute(arg2).key or ""
    end) else nil

    return {
        getHistory = getHistory,
        getCurrentRoute = getCurrentRoute,
        getCurrentLegacyRoute = getCurrentLegacyRoute,
        getCurrentPage = getCurrentPage,
        getCurrentPageName = getCurrentPageName,
        getIsCurrentPageSignal = getIsCurrentPageSignal,
        getRouteContainsPageSignal = getRouteContainsPageSignal,
        getCurrentTabName = getCurrentTabName,
        getCanGoBack = getCanGoBack,
        getRouteDepth = getRouteDepth,
        getCurrentRouteKey = getCurrentRouteKey
    }
end

return createLegacyNavigationStore
