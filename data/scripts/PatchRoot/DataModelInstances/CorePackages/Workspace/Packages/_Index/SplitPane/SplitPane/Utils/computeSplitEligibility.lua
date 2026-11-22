-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T21:31:30Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SplitPaneParent = script:FindFirstAncestor("SplitPane").Parent

local Navigation = require(SplitPaneParent.Navigation)
local RoactNavigation = require(SplitPaneParent.RoactNavigation)
local Constants = require(SplitPaneParent.NavigationRodux).Constants
local SplitPaneSlot = require(SplitPaneParent.AppSplitView).Enums.SplitPaneSlot
local FFlagAXFixSplitPaneHomeTryOnReset = require(SplitPaneParent.SharedFlags).FFlagAXFixSplitPaneHomeTryOnReset

local ViewState = Navigation.ViewState
local TempRnSwitchNavigatorName = Constants.TempRnSwitchNavigatorName

local function getUpdatedNavigation(navigation) -- Luacid: Inlined by compiler; 1 call site recovered
    local var1 = if navigation._dangerouslyGetParent then navigation._dangerouslyGetParent() else nil
    local key = if navigation.state == nil then nil else navigation.state.key

    if var1 and key then
        return var1.getChildNavigation(key) or navigation
    end

    return navigation
end

local function resolveOptions(tbl1)
    local descriptor = tbl1.descriptor
    local state = descriptor.state
    if state == nil or state.routeName ~= TempRnSwitchNavigatorName or descriptor.navigation == nil then
        return descriptor.options
    end

    local updatedNavigation = getUpdatedNavigation(descriptor.navigation)
    return RoactNavigation.getActiveChildNavigationOptions(updatedNavigation) or {}
end

local function computeSplitEligibility(tbl1)
    for i = #tbl1, 1, -1 do
        local var1 = tbl1[i]
        if var1.viewState ~= ViewState.Closing then
            local var2 = resolveOptions(var1)
            local splitPaneEligibility = var2.splitPaneEligibility
            if splitPaneEligibility ~= nil or not (var2.transparent or var2.overlayEnabled) then
                if splitPaneEligibility == SplitPaneSlot.Content then
                    return true
                end

                if splitPaneEligibility == nil then
                    return false
                end
            end
        elseif FFlagAXFixSplitPaneHomeTryOnReset then
            local var2 = resolveOptions(var1)
            if var2.splitPaneEligibility == nil and not (var2.transparent or var2.overlayEnabled) then
                return false
            end
        end
    end

    return false
end

return computeSplitEligibility
