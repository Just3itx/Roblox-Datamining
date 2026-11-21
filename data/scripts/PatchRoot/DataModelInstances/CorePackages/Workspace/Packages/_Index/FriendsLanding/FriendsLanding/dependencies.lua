-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T15:51:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local LuaSocialLibrariesDeps = require(scriptParentParent.LuaSocialLibrariesDeps)
local SocialLuaAnalytics = require(scriptParentParent.SocialLuaAnalytics)

local _React = require(scriptParentParent.React)

local Logger = require(scriptParentParent.Lumberyak).Logger.new(nil, "FriendsLanding")
local var2 = Logger:new("FriendsLanding Networking")
local maxRetryCount = game:DefineFastInt("FriendsLandingHttpRetryCount", 3)
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local LocalizationService = game:GetService("LocalizationService")
local TextService = game:GetService("TextService")
local Otter = require(scriptParentParent.Otter)
local getFStringSocialAddFriendsPageLayer = require(scriptParentParent.SharedFlags).getFStringSocialAddFriendsPageLayer
local getFStringSocialFriendsLandingLayer = require(scriptParentParent.SharedFlags).getFStringSocialFriendsLandingLayer
local getFStringSocialFriendsLayer = require(scriptParentParent.SharedFlags).getFStringSocialFriendsLayer
local ChallengeRequestWrapper = require(scriptParentParent.GenericChallenges).Middleware.ChallengeRequestWrapper

local bool1 = game:DefineFastFlag("EnableFriendsLandingChallengeInterceptor", false)

local httpRequest = LuaSocialLibrariesDeps.httpRequest
local var3 = httpRequest.config({
    requestFunction = function(arg1, arg2, arg3)
        var2:info("Fetching: {}", string.format("[ requestMethod = %q, url = %q ]", arg2, arg1))
        return httpRequest.requestFunctions.RequestInternal(arg1, arg2, arg3)
    end,
    postRequestFunction = function(arg1, arg2)
        var2:debug(
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

local config = LuaSocialLibrariesDeps.RoduxNetworking.config
local tbl1 = { keyPath = "FriendsLanding.NetworkStatus", networkImpl = 0 }

if bool1 then
    var3 = ChallengeRequestWrapper(var3)
end

tbl1.networkImpl = var3
local var4 = config(tbl1)

local RoduxPresence = LuaSocialLibrariesDeps.RoduxPresence

local ContactImporter = require(scriptParentParent.ContactImporter)

local SocialLibraries = LuaSocialLibrariesDeps.SocialLibraries.config({})

return {
    Promise = require(scriptParentParent.Promise),
    llama = LuaSocialLibrariesDeps.llama,
    Roact = require(scriptParentParent.Roact),
    Rodux = require(scriptParentParent.Rodux),
    React = require(scriptParentParent.React),
    RoactNavigation = require(scriptParentParent.RoactNavigation),
    RoactRodux = require(scriptParentParent.RoactRodux),
    RoactAppExperiment = require(scriptParentParent.RoactAppExperiment),
    Logger = Logger,
    Text = require(scriptParentParent.AppCommonLib).Text,
    t = require(scriptParentParent.t),
    UIBlox = require(scriptParentParent.UIBlox),
    withLocalization = require(scriptParentParent.Localization).withLocalization,
    memoize = require(scriptParentParent.AppCommonLib).memoize,
    enumerate = require(scriptParentParent.enumerate),
    LocalizationProvider = require(scriptParentParent.Localization).LocalizationProvider,
    Url = require(scriptParentParent.Http).Url,
    Lumberyak = require(scriptParentParent.Lumberyak),
    FormFactor = require(scriptParentParent.FormFactor).Enums.FormFactor,
    SocialLibraries = SocialLibraries,
    SocialLuaAnalytics = SocialLuaAnalytics,
    ProfileQRCode = require(scriptParentParent.ProfileQRCode),
    SocialCommon = require(scriptParentParent.SocialCommon),
    ReactFocusNavigation = require(scriptParentParent.ReactFocusNavigation),
    FocusNavigationUtils = require(scriptParentParent.FocusNavigationUtils),
    InputHandlers = require(scriptParentParent.InputHandlers),
    BuilderIcons = require(scriptParentParent.BuilderIcons),
    Foundation = require(scriptParentParent.Foundation),
    UniversalAppPolicy = require(scriptParentParent.UniversalAppPolicy).UniversalAppPolicy,
    tutils = require(scriptParentParent.tutils),
    AnalyticsService = require(scriptParentParent.Analytics).Analytics.new(game:GetService("RbxAnalyticsService")),
    RoduxNetworking = var4,
    RoduxFriends = require(scriptParentParent.FriendsRodux).config({ keyPath = "FriendsLanding.Friends" }),
    Dash = require(scriptParentParent.Dash),
    RoduxPresence = RoduxPresence.config({ keyPath = "FriendsLanding.Presence" }),
    CoreGui = CoreGui,
    Players = Players,
    LocalizationService = LocalizationService,
    TextService = TextService,
    NetworkingFriendsEnums = require(scriptParentParent.FriendsNetworking).Enums,
    FriendsNetworking = require(scriptParentParent.FriendsNetworking).config({ roduxNetworking = var4 }),
    Otter = Otter,
    CollisionMatchers = LuaSocialLibrariesDeps.CollisionMatchers,
    getFStringSocialAddFriendsPageLayer = getFStringSocialAddFriendsPageLayer,
    getFStringSocialFriendsLandingLayer = getFStringSocialFriendsLandingLayer,
    getFStringSocialFriendsLayer = getFStringSocialFriendsLayer,
    FindFriendsModal = ContactImporter.FindFriendsModal,
    ContactsList = ContactImporter.ContactsList,
    ContactsRevokedAccessDialog = ContactImporter.ContactsRevokedAccessDialog,
    updateOptedInUsers = require(scriptParentParent.SocialModalsCommon).Utils.updateOptedInUsers,
    fetchOSPermissionsForContacts = require(scriptParentParent.ContactImporter).Utils.fetchOSPermissionsForContacts,
    PermissionsProtocol = require(scriptParentParent.PermissionsProtocol).PermissionsProtocol,
    AppStorageService = game:GetService("AppStorageService"),
    ContactImporterConstants = require(scriptParentParent.ContactImporter).Constants,
    ShowContactImporterParams = ContactImporter.ShowContactImporterParams,
    DiscoverabilityOverlay = require(scriptParentParent.DiscoverabilityModal).DiscoverabilityOverlay,
    DiscoverabilityAnalytics = require(scriptParentParent.DiscoverabilityModal).Analytics,
    Hooks = {
        useLocalization = require(scriptParentParent.Localization).Hooks.useLocalization
    },
    getRbxthumbWithTypeSizeAndOptions = require(scriptParentParent.UserLib).Utils.getRbxthumbWithTypeSizeAndOptions,
    UserLibConstants = require(scriptParentParent.UserLib).Utils.Constants,
    useFocusGuiObject = require(scriptParentParent.ReactFocusNavigation).useFocusGuiObject,
    AppHeaderBar = require(scriptParentParent.AppHeaderBar),
    GetFFlagFixConnectTabSearchBarHeight = require(scriptParentParent.SharedFlags).GetFFlagFixConnectTabSearchBarHeight
}
