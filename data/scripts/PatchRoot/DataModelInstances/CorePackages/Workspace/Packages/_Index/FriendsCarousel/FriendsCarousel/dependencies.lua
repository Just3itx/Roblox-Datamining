-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T14:11:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local scriptParentParent = scriptParent.Parent

local SocialLuaAnalytics = require(scriptParentParent.SocialLuaAnalytics)
local LuaSocialLibrariesDeps = require(scriptParentParent.LuaSocialLibrariesDeps)

local httpRequest = LuaSocialLibrariesDeps.httpRequest
local logger = require(scriptParentParent.Loggers).Logger:new("FriendsCarousel")

local var2 = logger:new("FriendsCarousel Networking")
local maxRetryCount = game:DefineFastInt("FriendsCarouselHttpRetryCount", 3)

local getFFlagMigrateSocialNetworking = require(scriptParentParent.SharedFlags).getFFlagMigrateSocialNetworking

local networkImpl = httpRequest.config({
    requestFunction = function(arg1, arg2, arg3)
        var2:info("Fetching: {}", string.format("[ requestMethod = %q, url = %q ]", arg2, arg1))
        if getFFlagMigrateSocialNetworking() then
            return httpRequest.requestFunctions.RequestInternal(arg1, arg2, arg3)
        end
        return httpRequest.requestFunctions.HttpRbxApi(arg1, arg2, arg3)
    end,
    postRequestFunction = function(arg1, arg2)
        var2:debug(
            "Returned: {}",
            string.format("[ requestMethod = %q, url = %q, statusCode = %s ]", arg2.requestMethod, arg2.url, arg1.StatusCode)
        )
    end,
    maxRetryCount = maxRetryCount
})

local RODUX_KEY = require(scriptParent.Common.Constants).RODUX_KEY

local var4 = LuaSocialLibrariesDeps.RoduxNetworking.config({ keyPath = RODUX_KEY .. ".NetworkStatus", networkImpl = networkImpl })

local UIBlox = require(scriptParentParent.UIBlox)

local _RobloxAppHooks = require(scriptParentParent.RobloxAppHooks)

return {
    logger = logger,
    SocialLuaAnalytics = SocialLuaAnalytics,
    Promise = require(scriptParentParent.Promise),
    UIBlox = UIBlox,
    Roact = require(scriptParentParent.Roact),
    React = require(scriptParentParent.React),
    Rodux = require(scriptParentParent.Rodux),
    RoactRodux = require(scriptParentParent.RoactRodux),
    t = require(scriptParentParent.t),
    Dash = require(scriptParentParent.Dash),
    llama = LuaSocialLibrariesDeps.llama,
    SocialLibraries = LuaSocialLibrariesDeps.SocialLibraries.config({}),
    SocialCommon = require(scriptParentParent.SocialCommon),
    RoduxNetworking = var4,
    NetworkingFriends = require(scriptParentParent.FriendsNetworking).config({ roduxNetworking = var4 }),
    NetworkingAliases = LuaSocialLibrariesDeps.NetworkingAliases.config({ roduxNetworking = var4 }),
    RoduxFriends = require(scriptParentParent.FriendsRodux).config({ keyPath = RODUX_KEY .. ".Friends" }),
    RoduxAnalytics = SocialLuaAnalytics.Analytics.RoduxAnalytics.config({ keyPath = RODUX_KEY .. ".Analytics" }),
    convertActions = require(scriptParentParent.SocialReducerAdaptors).convertActions,
    friendsActionAdaptor = require(scriptParentParent.SocialReducerAdaptors).friendsActionAdaptor,
    Text = require(scriptParentParent.AppCommonLib).Text,
    enumerate = require(scriptParentParent.enumerate),
    RetrievalStatus = require(scriptParentParent.Http).Enum.RetrievalStatus,
    AnalyticsService = require(scriptParentParent.Analytics).Analytics.new(game:GetService("RbxAnalyticsService")),
    isSubjectToDesktopPolicies = require(scriptParentParent.SharedFlags).isSubjectToDesktopPolicies,
    isSubjectTo10ftPolicies = require(scriptParent.isSubjectTo10ftPolicies)
}
