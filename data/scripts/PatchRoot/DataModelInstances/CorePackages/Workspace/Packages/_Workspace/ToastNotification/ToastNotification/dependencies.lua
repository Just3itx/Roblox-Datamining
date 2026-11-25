-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T19:40:32Z
-- Luau bytecode version: 14 | Luau type version: 3
local scriptParentParent = script.Parent.Parent
local UserLib = require(scriptParentParent.UserLib)

return {
    AppBlox = require(scriptParentParent.AppBlox),
    Cryo = require(scriptParentParent.Cryo),
    Dash = require(scriptParentParent.Dash),
    LocalStorage = require(scriptParentParent.LocalStorage),
    Rodux = require(scriptParentParent.Rodux),
    Roact = require(scriptParentParent.Roact),
    RoactRodux = require(scriptParentParent.RoactRodux),
    RoactServices = require(scriptParentParent.RoactServices),
    React = require(scriptParentParent.React),
    ReactRoblox = require(scriptParentParent.ReactRoblox),
    UIBlox = require(scriptParentParent.UIBlox),
    Localization = require(scriptParentParent.Localization),
    NotificationModalsManager = require(scriptParentParent.NotificationModalsManager),
    RobloxAppHooks = require(scriptParentParent.RobloxAppHooks),
    RobloxAppEnums = require(scriptParentParent.RobloxAppEnums),
    RoactServiceTags = require(scriptParentParent.RoactServiceTags),
    Hooks = {
        dependencyArray = require(scriptParentParent.RoactUtils).Hooks.dependencyArray
    },
    LuauPolyfill = require(scriptParentParent.LuauPolyfill),
    t = require(scriptParentParent.t),
    ToastNotificationsProtocol = require(scriptParentParent.ToastNotificationsProtocol).ToastNotificationProtocol,
    ToastNotificationProtocolEnums = require(scriptParentParent.ToastNotificationsProtocol).ToastNotificationProtocolEnums,
    UserLib = UserLib,
    getRbxthumbWithTypeSizeAndOptions = UserLib.Utils.getRbxthumbWithTypeSizeAndOptions,
    UserLibConstants = UserLib.Utils.Constants,
    Lumberyak = require(scriptParentParent.Lumberyak),
    SharedFlags = require(scriptParentParent.SharedFlags),
    Signal = require(scriptParentParent.AppCommonLib).Signal
}
