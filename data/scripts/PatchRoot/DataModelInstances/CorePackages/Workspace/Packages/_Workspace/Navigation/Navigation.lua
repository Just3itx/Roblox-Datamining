-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T00:01:30Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local _types = require(script.types)

local ViewState = require(script.ViewState)

local createSignalsNavigationObject = require(script.createSignalsNavigationObject)

local createProjectedNavigationObject = require(script.createProjectedNavigationObject)

return {
    canGoBack = require(script.canGoBack),
    getActiveChildNavigationOptionsRecursively = require(script.getActiveChildNavigationOptionsRecursively),
    getActiveRoutes = require(script.getActiveRoutes),
    getCurrentNavigationState = require(script.getCurrentNavigationState),
    getCurrentRouteKey = require(script.getCurrentRouteKey),
    getCurrentRouteState = require(script.getCurrentRouteState),
    getFocusedRoutes = require(script.getFocusedRoutes),
    getRootNavigation = require(script.getRootNavigation),
    getRouteKeyIsInNavigationState = require(script.getRouteKeyIsInNavigationState),
    getRouteIsActive = require(script.getRouteIsActive),
    getRouteIsFocused = require(script.getRouteIsFocused),
    useEarlyIsFocused = require(script.useEarlyIsFocused),
    useNavigation = require(script.useNavigation),
    useNavigationFocus = require(script.useNavigationFocus),
    useRouteName = require(script.useRouteName),
    useStackScreens = require(script.useStackScreens),
    TestUtils = require(script.TestUtils),
    inspectRouteEntry = require(script.inspectRouteEntry),
    ViewState = ViewState,
    createSignalsNavigationObject = createSignalsNavigationObject,
    createProjectedNavigationObject = createProjectedNavigationObject,
    SignalsNavigationContainer = require(script.SignalsNavigationContainer),
    ["jest.config"] = script["jest.config"]
}
