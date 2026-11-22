-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T21:31:34Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SplitPaneParent = script:FindFirstAncestor("SplitPane").Parent

local AppSplitView = require(SplitPaneParent.AppSplitView)
local Navigation = require(SplitPaneParent.Navigation)
local Constants = require(SplitPaneParent.NavigationRodux).Constants

local _useSplitLayoutStatus = require(script.Parent.Parent.Hooks.useSplitLayoutStatus)

local getCurrentNavigationState = Navigation.getCurrentNavigationState

local SupportPaneMode = AppSplitView.Enums.SupportPaneMode
local TempRnSwitchNavigatorName = Constants.TempRnSwitchNavigatorName

local tbl1 = { isOnScreen = false }

local function onScreenRouteKeyForScreen(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    local descriptor = arg1.descriptor
    local state = descriptor.state
    if state == nil or state.routeName ~= TempRnSwitchNavigatorName then
        return descriptor.key
    end
    local currentNavigationState = getCurrentNavigationState(state)
    return if currentNavigationState == nil or currentNavigationState.key == nil then descriptor.key else currentNavigationState.key
end

local function getOnScreenContextValue(arg1, num1: number, arg2)
    local bool1 = false
    local var1 = nil
    local paneIndex = nil
    local supportPaneMode

    if arg1 == nil then
        supportPaneMode = nil
    else
        supportPaneMode = arg1.supportPaneMode
        if arg1.isRootAppStack and arg1.isSplitEnabled then
            var1 = arg1.contentTopCandidate or arg1.splitPrimaryIndex
            if arg1.isRouteActiveOnPane then
                paneIndex = arg1.paneIndices[#arg1.paneIndices]
            end

            bool1 = var1 ~= nil or paneIndex ~= nil
        end
    end

    if not bool1 then
        return nil
    end

    if num1 ~= paneIndex and (num1 ~= var1 or supportPaneMode == SupportPaneMode.Expanded) then
        return tbl1
    end
    return {
        isOnScreen = true,
        currentRouteKey = onScreenRouteKeyForScreen(arg2)
    }
end
return getOnScreenContextValue
