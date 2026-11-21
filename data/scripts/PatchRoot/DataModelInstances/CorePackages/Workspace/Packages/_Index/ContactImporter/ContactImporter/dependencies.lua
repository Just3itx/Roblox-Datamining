-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T08:30:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local scriptParentParent = scriptParent.Parent

local LuaSocialLibrariesDeps = require(scriptParentParent.LuaSocialLibrariesDeps)
local Lumberyak = require(scriptParentParent.Lumberyak)
local httpRequest = LuaSocialLibrariesDeps.httpRequest
local ShareLinksNetworking = require(scriptParentParent.ShareLinksNetworking)
local ShareLinksRodux = require(scriptParentParent.ShareLinksRodux)
local VirtualizedList = require(scriptParentParent.VirtualizedList)
local UrlBuilder = require(scriptParentParent.UrlBuilder)

local SocialLuaAnalytics = require(scriptParentParent.SocialLuaAnalytics)
local var1 = Lumberyak.Logger.new(nil, "ContactImporter"):new("ContactImporter Networking")
local maxRetryCount = game:DefineFastInt("ContactImporterHttpRetryCount", 3)

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

local var3 = LuaSocialLibrariesDeps.RoduxNetworking.config({ keyPath = RODUX_KEY .. ".NetworkStatus", networkImpl = networkImpl })

local RoduxContacts = require(scriptParentParent.ContactsRodux).config({ keyPath = RODUX_KEY .. ".Contacts" })

local RoactAppExperiment = require(scriptParentParent.RoactAppExperiment)

local UIBlox = require(scriptParentParent.UIBlox)

return {
    SocialLuaAnalytics = SocialLuaAnalytics,
    Dash = require(scriptParentParent.Dash),
    UIBlox = UIBlox,
    Roact = require(scriptParentParent.Roact),
    RoactNavigation = require(scriptParentParent.RoactNavigation),
    Rodux = require(scriptParentParent.Rodux),
    ReactRoblox = require(scriptParentParent.ReactRoblox),
    RoactRodux = require(scriptParentParent.RoactRodux),
    LocalizationProvider = require(scriptParentParent.Localization).LocalizationProvider,
    withLocalization = require(scriptParentParent.Localization).withLocalization,
    Url = require(scriptParentParent.Http).Url,
    t = require(scriptParentParent.t),
    Promise = require(scriptParentParent.Promise),
    llama = LuaSocialLibrariesDeps.llama,
    memoize = require(scriptParentParent.AppCommonLib).memoize,
    RoduxNetworking = var3,
    enumerate = require(scriptParentParent.enumerate),
    IXPService = game:GetService("IXPService"),
    ShareLinksNetworking = ShareLinksNetworking.config({ roduxNetworking = var3 }),
    SocialLibraries = LuaSocialLibrariesDeps.SocialLibraries.config({}),
    SocialModalsCommon = require(scriptParentParent.SocialModalsCommon),
    NetworkingContacts = require(scriptParentParent.ContactsNetworking).config({ roduxNetworking = var3 }),
    NetworkingFriends = require(scriptParentParent.FriendsNetworking).config({ roduxNetworking = var3 }),
    NetworkingUserSettings = LuaSocialLibrariesDeps.NetworkingUserSettings.config({ roduxNetworking = var3 }),
    NetworkingAccountInformation = LuaSocialLibrariesDeps.NetworkingAccountInformation.config({ roduxNetworking = var3 }),
    NetworkingAccountSettings = LuaSocialLibrariesDeps.NetworkingAccountSettings.config({ roduxNetworking = var3 }),
    UrlBuilder = UrlBuilder.UrlBuilder,
    ContactsProtocol = require(scriptParentParent.ContactsProtocol).ContactsProtocol,
    SMSProtocol = require(scriptParentParent.SMSProtocol).SMSProtocol,
    PermissionsProtocol = require(scriptParentParent.PermissionsProtocol).PermissionsProtocol,
    RoduxContacts = RoduxContacts,
    RoduxUserPermissions = LuaSocialLibrariesDeps.RoduxUserPermissions.config({ keyPath = RODUX_KEY .. ".UserPermissions" }),
    ShareLinksRodux = ShareLinksRodux.config({ keyPath = RODUX_KEY .. ".ShareLinks" }),
    AppStorageService = game:GetService("AppStorageService"),
    UserInputService = game:GetService("UserInputService"),
    ThrottleUserId = require(scriptParentParent.AppCommonLib).ThrottleUserId,
    getFStringSocialFriendsLayer = require(scriptParentParent.SharedFlags).getFStringSocialFriendsLayer,
    FFlagFontFaceSocialFriends = require(scriptParentParent.SharedFlags).FFlagFontFaceSocialFriends,
    Players = game:GetService("Players"),
    React = require(scriptParentParent.React),
    FlatList = VirtualizedList.FlatList,
    SectionList = VirtualizedList.SectionList,
    useSelector = require(scriptParentParent.RoactUtils).Hooks.RoactRodux.useSelector,
    useDispatch = require(scriptParentParent.RoactUtils).Hooks.RoactRodux.useDispatch,
    usePrevious = require(scriptParentParent.RoactUtils).Hooks.usePrevious,
    useNavigation = require(scriptParentParent.Navigation).useNavigation,
    useLocalization = require(scriptParentParent.Localization).Hooks.useLocalization,
    useStyle = UIBlox.Core.Style.useStyle,
    useUserExperiment = RoactAppExperiment.useUserExperiment,
    useEffectOnce = require(scriptParentParent.RoactUtils).Hooks.useEffectOnce,
    DiscoverabilityOverlay = require(scriptParentParent.DiscoverabilityModal).DiscoverabilityOverlay,
    DiscoverabilityAnalytics = require(scriptParentParent.DiscoverabilityModal).Analytics,
    RoactExperimentProvider = RoactAppExperiment.Provider,
    UniversalAppPolicy = require(scriptParentParent.UniversalAppPolicy).UniversalAppPolicy,
    AmpUpsell = require(scriptParentParent.AmpUpsell),
    Foundation = require(scriptParentParent.Foundation)
}
