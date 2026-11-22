-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T14:10:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local NavigationCommands = require(script.NavigationCommands)
local AppNavigationRegistry = require(script.AppNavigationRegistry)

local scriptParent = script.Parent
local FFlagEnableOnScreenAPIIntegration = require(scriptParent.SharedFlags).FFlagEnableOnScreenAPIIntegration
local FFlagSignalsNavP3hMisc = require(scriptParent.SharedFlags).FFlagSignalsNavP3hMisc

return {
    AppNavigationRegistry = AppNavigationRegistry,
    isNavigationAvailable = AppNavigationRegistry.isRegistered,
    NavigationCommands = NavigationCommands,
    useNavigationProps = require(script.useNavigationProps),
    withNavigationProps = require(script.withNavigationProps),
    withNavigationFocusIgnoringNavigation = if FFlagSignalsNavP3hMisc then require(script.withNavigationFocusIgnoringNavigation) else nil,
    CurrentTabContext = require(script.CurrentTabContext),
    TopBarContext = require(script.TopBarContext),
    resolveNavigationTarget = require(script.resolveNavigationTarget),
    useIsRouteOnScreen = if FFlagEnableOnScreenAPIIntegration then require(script.useIsRouteOnScreen) else nil,
    OnScreenContext = if FFlagEnableOnScreenAPIIntegration then require(script.OnScreenContext) else nil,
    useOnScreenNavigationListener = if FFlagEnableOnScreenAPIIntegration then require(script.useOnScreenNavigationListener) else nil,
    ["jest.config"] = script["jest.config"]
}
