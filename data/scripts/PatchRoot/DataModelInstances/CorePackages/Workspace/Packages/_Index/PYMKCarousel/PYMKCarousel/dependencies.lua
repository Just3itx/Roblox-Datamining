-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T13:31:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PYMKCarousel = script:FindFirstAncestor("PYMKCarousel")
local PYMKCarouselParent = PYMKCarousel.Parent

local LuaSocialLibrariesDeps = require(PYMKCarouselParent.LuaSocialLibrariesDeps)
local SocialLuaAnalytics = require(PYMKCarouselParent.SocialLuaAnalytics)

local Lumberyak = require(PYMKCarouselParent.Lumberyak)
local httpRequest = LuaSocialLibrariesDeps.httpRequest

local bool1 = game:DefineFastFlag("MigratePymkCarouselHttpRequestToRequestInternal", false)
local ChallengeRequestWrapper = require(PYMKCarouselParent.GenericChallenges).Middleware.ChallengeRequestWrapper
local bool2 = game:DefineFastFlag("EnablePymkCarouselChallengeInterceptor", false)
local FFlagPymkCarouselPresenceStoreMigration = require(PYMKCarousel.Flags.FFlagPymkCarouselPresenceStoreMigration)

local var1 = Lumberyak.Logger.new(nil, "PYMKCarousel"):new("PYMKCarousel Networking")
local maxRetryCount = game:DefineFastInt("PYMKCarouselHttpRetryCount", 3)
local var2 = httpRequest.config({
    requestFunction = function(arg1, arg2, arg3)
        var1:info("Fetching: {}", string.format("[ requestMethod = %q, url = %q ]", arg2, arg1))
        if bool1 then
            return httpRequest.requestFunctions.RequestInternal(arg1, arg2, arg3)
        end
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

local RODUX_KEY = require(PYMKCarousel.Common.Constants).RODUX_KEY

local config = LuaSocialLibrariesDeps.RoduxNetworking.config
local tbl1 = {
    keyPath = RODUX_KEY .. ".NetworkStatus",
    networkImpl = 0
}

if bool2 then
    var2 = ChallengeRequestWrapper(var2)
end

tbl1.networkImpl = var2
local var3 = config(tbl1)

return {
    SocialLuaAnalytics = SocialLuaAnalytics,
    UIBlox = require(PYMKCarouselParent.UIBlox),
    Roact = require(PYMKCarouselParent.Roact),
    React = require(PYMKCarouselParent.React),
    Rodux = require(PYMKCarouselParent.Rodux),
    RoactRodux = require(PYMKCarouselParent.RoactRodux),
    Result = require(PYMKCarouselParent.Result),
    llama = LuaSocialLibrariesDeps.llama,
    Dash = require(PYMKCarouselParent.Dash),
    RoduxNetworking = var3,
    RoduxFriends = require(PYMKCarouselParent.FriendsRodux).config({ keyPath = RODUX_KEY .. ".Friends" }),
    RoduxUsers = LuaSocialLibrariesDeps.RoduxUsers.config({ keyPath = RODUX_KEY .. ".Users" }),
    NetworkingFriendsEnums = require(PYMKCarouselParent.FriendsNetworking).Enums,
    NetworkingFriends = require(PYMKCarouselParent.FriendsNetworking).config({ roduxNetworking = var3 }),
    RoduxAnalytics = SocialLuaAnalytics.Analytics.RoduxAnalytics.config({ keyPath = RODUX_KEY .. ".Analytics" }),
    Players = game:GetService("Players"),
    convertActions = require(PYMKCarouselParent.SocialReducerAdaptors).convertActions,
    usersActionAdaptor = require(PYMKCarouselParent.SocialReducerAdaptors).usersActionAdaptor,
    friendsActionAdaptor = require(PYMKCarouselParent.SocialReducerAdaptors).friendsActionAdaptor,
    SocialCommon = require(PYMKCarouselParent.SocialCommon),
    SocialLibraries = LuaSocialLibrariesDeps.SocialLibraries.config({}),
    Hooks = {
        useSelector = require(PYMKCarouselParent.RoactUtils).Hooks.RoactRodux.useSelector,
        useDispatch = require(PYMKCarouselParent.RoactUtils).Hooks.RoactRodux.useDispatch,
        useLocalization = require(PYMKCarouselParent.Localization).Hooks.useLocalization,
        dependencyArray = require(PYMKCarouselParent.RoactUtils).Hooks.dependencyArray
    },
    LocalizationProvider = require(PYMKCarouselParent.Localization).LocalizationProvider,
    enumerate = require(PYMKCarouselParent.enumerate),
    getFFlagPYMKAddFriendsEntry = require(PYMKCarouselParent.SharedFlags).getFFlagPYMKAddFriendsEntry,
    NetworkingPresence = if FFlagPymkCarouselPresenceStoreMigration then nil else LuaSocialLibrariesDeps.NetworkingPresence.config({ roduxNetworking = var3 })
}
