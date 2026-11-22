-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T16:01:29Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local scriptParentParent = scriptParent.Parent
local LuaSocialLibrariesDeps = require(scriptParentParent.LuaSocialLibrariesDeps)
local RODUX_KEY = require(scriptParent.Common.Constants).RODUX_KEY

local RoduxNetworking = LuaSocialLibrariesDeps.RoduxNetworking
local Lumberyak = require(scriptParentParent.Lumberyak)
local httpRequest = LuaSocialLibrariesDeps.httpRequest

local var1 = Lumberyak.Logger.new(nil, RODUX_KEY):new(RODUX_KEY .. " Networking")
local maxRetryCount = game:DefineFastInt("SetAliasHttpRetryCount", 3)
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

local var3 = RoduxNetworking.config({ keyPath = RODUX_KEY .. ".NetworkStatus", networkImpl = networkImpl })

local SocialLuaAnalytics = require(scriptParentParent.SocialLuaAnalytics)

return {
    AppStorageService = game:GetService("AppStorageService"),
    Analytics = require(scriptParentParent.Analytics),
    SocialLuaAnalytics = SocialLuaAnalytics,
    Dash = require(scriptParentParent.Dash),
    UIBlox = require(scriptParentParent.UIBlox),
    Roact = require(scriptParentParent.Roact),
    RoactRodux = require(scriptParentParent.RoactRodux),
    RoactNavigation = require(scriptParentParent.RoactNavigation),
    Rodux = require(scriptParentParent.Rodux),
    React = require(scriptParentParent.React),
    ContactsProtocol = require(scriptParentParent.ContactsProtocol).ContactsProtocol,
    Promise = require(scriptParentParent.Promise),
    enumerate = require(scriptParentParent.enumerate),
    UserProfiles = require(scriptParentParent.UserProfiles),
    RoactFitComponents = LuaSocialLibrariesDeps.RoactFitComponents,
    RoduxNetworking = var3,
    NetworkingAliases = LuaSocialLibrariesDeps.NetworkingAliases.config({ roduxNetworking = var3 }),
    RoduxAliases = LuaSocialLibrariesDeps.RoduxAliases.config({ keyPath = RODUX_KEY .. ".Aliases" }),
    SocialLibraries = LuaSocialLibrariesDeps.SocialLibraries.config({}),
    LocalizationProvider = require(scriptParentParent.Localization).LocalizationProvider,
    Hooks = {
        useEffectOnMount = require(scriptParentParent.RoactUtils).Hooks.useEffectOnMount,
        useLocalization = require(scriptParentParent.Localization).Hooks.useLocalization,
        useSelector = require(scriptParentParent.RoactUtils).Hooks.RoactRodux.useSelector,
        useDispatch = require(scriptParentParent.RoactUtils).Hooks.RoactRodux.useDispatch,
        useLocalUserId = require(scriptParentParent.RobloxAppHooks).useLocalUserId
    },
    Foundation = require(scriptParentParent.Foundation)
}
