-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T17:00:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local RegisterCustomGetStateForAction = require(script.NavigationActions.RegisterCustomGetStateForAction)
local CustomGetStateForAction = require(script.Enums.CustomGetStateForAction)

local _Types = require(script.AvatarRoute.Types)
local _NavigationType = require(script.Types.NavigationType)

return {
    AvatarRoute = {
        Context = {
            AvatarRouteContext = require(script.AvatarRoute.Context.AvatarRouteContext)
        },
        Hooks = {
            useAvatarRoute = require(script.AvatarRoute.Hooks.useAvatarRoute)
        },
        RouteInfo = require(script.AvatarRoute.RouteInfo),
        AvatarRoute = require(script.AvatarRoute.AvatarRoute),
        AvatarScreenProperties = require(script.AvatarRoute.AvatarScreenProperties),
        getActiveAvatarScreen = require(script.AvatarRoute.getActiveAvatarScreen)
    },
    Enums = {
        AvatarScreen = require(script.Enums.AvatarScreen),
        AvatarEditorNavigation = require(script.Enums.AvatarEditorNavigation),
        AvatarRootNavigationAction = require(script.Enums.AvatarRootNavigationAction),
        UnifiedLoggingSurface = require(script.Enums.UnifiedLoggingSurface),
        CustomGetStateForAction = CustomGetStateForAction
    },
    Actions = {
        DeregisterCustomGetStateForAction = require(script.NavigationActions.DeregisterCustomGetStateForAction),
        RegisterCustomGetStateForAction = RegisterCustomGetStateForAction,
        ClearScreens = require(script.NavigationActions.ClearScreens),
        AvatarExperienceActions = require(script.NavigationActions.AvatarExperienceActions)
    },
    BackHandlerRegistry = require(script.BackHandlerRegistry),
    Debug = {
        logOnOverlayClosed = require(script.Debug.logOnOverlayClosed)
    },
    withMappedNavigationParams = require(script.withMappedNavigationParams),
    Thunks = {
        NavigateWithLock = require(script.Thunks.NavigateWithLock),
        NavigateDownToAvatarScreen = require(script.Thunks.NavigateDownToAvatarScreen)
    },
    Utils = {
        closeGiftSendFlow = require(script.Utils.closeGiftSendFlow)
    },
    ["jest.config"] = script["jest.config"]
}
