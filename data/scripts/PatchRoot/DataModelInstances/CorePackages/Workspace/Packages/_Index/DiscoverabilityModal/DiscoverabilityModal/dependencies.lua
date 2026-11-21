-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T10:20:33Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local scriptParentParent = scriptParent.Parent
local LuaSocialLibrariesDeps = require(scriptParentParent.LuaSocialLibrariesDeps)

local RoduxNetworking = LuaSocialLibrariesDeps.RoduxNetworking
local Lumberyak = require(scriptParentParent.Lumberyak)
local httpRequest = LuaSocialLibrariesDeps.httpRequest

local var1 = Lumberyak.Logger.new(nil, "DiscoverabilityModal"):new("DiscoverabilityModal Networking")
local maxRetryCount = game:DefineFastInt("DiscoverabilityModalHttpRetryCount", 3)
local networkImpl = httpRequest.config({
    requestFunction = function(arg1, arg2, arg3)
        var1:info("Fetching: {}", string.format("[ requestMethod = %q, url = %q ]", arg2, arg1))
        return httpRequest.requestFunctions.HttpRbxApi(arg1, arg2, arg3)
    end,
    postRequestFunction = function(arg1, arg2)
        var1:debug(
            "Returned: {}",
            string.format(
                "[ requestMethod = %q, url = %q, statusCode = %s, body = %s ]",
                arg2.requestMethod,
                arg2.url,
                arg1.StatusCode,
                arg1.Body
            )
        )
    end,
    maxRetryCount = maxRetryCount
})

local RODUX_KEY = require(scriptParent.Common.Constants).RODUX_KEY

local var3 = RoduxNetworking.config({ keyPath = RODUX_KEY .. ".NetworkStatus", networkImpl = networkImpl })

local SocialLuaAnalytics = require(scriptParentParent.SocialLuaAnalytics)
local SharedFlags = require(scriptParentParent.SharedFlags)

return {
    AppStorageService = game:GetService("AppStorageService"),
    SocialLuaAnalytics = SocialLuaAnalytics,
    Dash = require(scriptParentParent.Dash),
    UIBlox = require(scriptParentParent.UIBlox),
    Foundation = require(scriptParentParent.Foundation),
    Roact = require(scriptParentParent.Roact),
    RoactRodux = require(scriptParentParent.RoactRodux),
    Rodux = require(scriptParentParent.Rodux),
    React = require(scriptParentParent.React),
    ContactsProtocol = require(scriptParentParent.ContactsProtocol).ContactsProtocol,
    Promise = require(scriptParentParent.Promise),
    enumerate = require(scriptParentParent.enumerate),
    RoactNavigation = require(scriptParentParent.RoactNavigation),
    rolloutByApplicationId = require(scriptParentParent.AppCommonLib).rolloutByApplicationId,
    RoduxNetworking = var3,
    SocialLibraries = LuaSocialLibrariesDeps.SocialLibraries.config({}),
    SocialModalsCommon = require(scriptParentParent.SocialModalsCommon),
    PermissionsProtocol = require(scriptParentParent.PermissionsProtocol).PermissionsProtocol,
    NetworkingUserSettings = LuaSocialLibrariesDeps.NetworkingUserSettings.config({ roduxNetworking = var3 }),
    RoduxUserPermissions = LuaSocialLibrariesDeps.RoduxUserPermissions.config({ keyPath = RODUX_KEY .. ".UserPermissions" }),
    LocalizationProvider = require(scriptParentParent.Localization).LocalizationProvider,
    Hooks = {
        useLocalization = require(scriptParentParent.Localization).Hooks.useLocalization,
        useNavigation = require(scriptParentParent.Navigation).useNavigation,
        useSelector = require(scriptParentParent.RoactUtils).Hooks.RoactRodux.useSelector,
        useDispatch = require(scriptParentParent.RoactUtils).Hooks.RoactRodux.useDispatch
    },
    getFStringSocialProfileLayer = SharedFlags.getFStringSocialProfileLayer
}
