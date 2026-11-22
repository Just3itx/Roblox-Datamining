-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T14:11:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RobloxAppNavigationParent = script:FindFirstAncestor("RobloxAppNavigation").Parent

local React = require(RobloxAppNavigationParent.React)
local useNavigation = require(RobloxAppNavigationParent.Navigation).useNavigation
local useEarlyIsFocused = require(RobloxAppNavigationParent.Navigation).useEarlyIsFocused
local getCurrentNavigationState = require(RobloxAppNavigationParent.Navigation).getCurrentNavigationState
local OnScreenContext = require(script.Parent.OnScreenContext)

local bool1 = game:DefineFastFlag("EnableOnScreenAPICheckDescendants", false)

local function useIsRouteOnScreen()
    local var1 = useNavigation()
    local key = if var1.state then var1.state.key else nil
    local var2 = React.useContext(OnScreenContext)
    local var3 = useEarlyIsFocused()
    if var2 == nil or var2.isOnScreen == nil then
        return var3
    end

    if not bool1 then
        return var2.isOnScreen == true and (var2.currentRouteKey == nil or var2.currentRouteKey == key)
    end

    local bool2 = var2.currentRouteKey == nil or var2.currentRouteKey == key
    if not bool2 and var1.state then
        bool2 = var2.currentRouteKey == getCurrentNavigationState(var1.state).key
    end
    if var2.isOnScreen ~= true then
        bool2 = false
    end

    return bool2
end

return useIsRouteOnScreen
