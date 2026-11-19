-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T17:40:35Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CoreGui = game:GetService("CoreGui")
local CorePackages = game:GetService("CorePackages")
local Players = game:GetService("Players")
local EventIngestService = game:GetService("EventIngestService")
local RobloxReplicatedStorage = game:GetService("RobloxReplicatedStorage")

local SocialContextToastContainer = require(CorePackages.Workspace.Packages.SocialContextToasts).SocialContextToastContainer
local FFlagEnablePartyNudgeAfterJoin = require(CorePackages.Workspace.Packages.SharedFlags).FFlagEnablePartyNudgeAfterJoin

local FFlagShowFriendJoinedYouToastForNonReferredJoins = require(CorePackages.Workspace.Packages.SharedFlags).FFlagShowFriendJoinedYouToastForNonReferredJoins

local GetFFlagEnableReferredPlayerJoinRemoteEvent = require(CorePackages.Workspace.Packages.SharedFlags).GetFFlagEnableReferredPlayerJoinRemoteEvent

local GetFIntReferredPlayerJoinRemoteEventTimeout = require(CorePackages.Workspace.Packages.SharedFlags).GetFIntReferredPlayerJoinRemoteEventTimeout

local FFlagLuaAppDefaultHttpRetry = require(CorePackages.Workspace.Packages.SharedFlags).FFlagLuaAppDefaultHttpRetry
local HttpRequest = require(CorePackages.Packages.HttpRequest)
local networking = HttpRequest.config({
    requestFunction = function(arg1, arg2, arg3)
        return HttpRequest.requestFunctions.HttpRbxApi(arg1, arg2, arg3)
    end,
    maxRetryCount = if FFlagLuaAppDefaultHttpRetry then game:DefineFastInt("SocialContextToastHttpRetryCount", 4) else nil
})
local ApolloClient = require(CoreGui.RobloxGui.Modules.ApolloClient)
local Analytics = require(CorePackages.Workspace.Packages.Analytics).Analytics
local EventIngest = require(CorePackages.Workspace.Packages.Analytics).AnalyticsReporters.EventIngest

local IXPServiceWrapper = require(CorePackages.Workspace.Packages.IxpServiceWrapper).IXPServiceWrapper
local ReferredPlayerJoin = if GetFFlagEnableReferredPlayerJoinRemoteEvent() then RobloxReplicatedStorage:WaitForChild("ReferredPlayerJoin", GetFIntReferredPlayerJoinRemoteEventTimeout()) else nil
local ShowPlayerJoinedFriendsToast = nil
local timeOut = game:DefineFastInt("FriendPlayerJoinedRemoteEventTimeout", 5)
local ShowFriendJoinedPlayerToast = if FFlagEnablePartyNudgeAfterJoin or FFlagShowFriendJoinedYouToastForNonReferredJoins then RobloxReplicatedStorage:WaitForChild("ShowFriendJoinedPlayerToast", timeOut) else nil

if FFlagEnablePartyNudgeAfterJoin then
    ShowPlayerJoinedFriendsToast = RobloxReplicatedStorage:WaitForChild("ShowPlayerJoinedFriendsToast", timeOut)
end

SocialContextToastContainer({
    networking = networking,
    playersService = Players,
    apolloClient = ApolloClient,
    analytics = Analytics.new(),
    ixpService = IXPServiceWrapper,
    eventIngest = EventIngest.new(EventIngestService),
    referredPlayerJoinRemoteEvent = ReferredPlayerJoin,
    showFriendJoinedPlayerToastRemoteEvent = ShowFriendJoinedPlayerToast,
    showPlayerJoinedFriendsToastRemoteEvent = ShowPlayerJoinedFriendsToast
}, tostring(game.GameId), tostring(game.PlaceId))
