-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T21:20:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperienceParent = script:FindFirstAncestor("BuildExperience").Parent

local React = require(BuildExperienceParent.React)
local Navigation = require(BuildExperienceParent.Navigation)
local AppNavBar = require(BuildExperienceParent.AppNavBar)
local AppTabBarRodux = require(BuildExperienceParent.AppTabBarRodux)
local useStore = require(BuildExperienceParent.RoactUtils).Hooks.RoactRodux.useStore

local SetTabBarVisible = AppTabBarRodux.Actions.SetTabBarVisible

local function useManageBuildNavBarVisibility(arg1, routeName: string)
    local var1 = useStore()
    local var2 = Navigation.useNavigationFocus()
    local state = arg1.state
    local bool1 = AppNavBar.useNavBarPlacement() ~= AppNavBar.Placement.Bottom or state.routes[state.index].routeName == routeName

    React.useEffect(function()
        if var2 and var1:getState().TabBarVisible ~= bool1 then
            AppNavBar.AppNavTelemetry.logVisibilityStart(bool1)
            var1:dispatch(SetTabBarVisible(bool1))
        end
    end, { var1, var2, bool1 })
end

return useManageBuildNavBarVisibility
