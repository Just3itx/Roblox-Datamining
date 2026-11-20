-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T00:20:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local ShareGame = game:GetService("CoreGui").RobloxGui.Modules.Settings.Pages.ShareGame
local ReducerDependencies = require(CorePackages.Workspace.Packages.NotificationsCommon).ReducerDependencies

local PlaceInfosReducer = require(CorePackages.Workspace.Packages.PlaceInfoRodux).Reducers.PlaceInfosReducer
local UserReducer = require(CorePackages.Workspace.Packages.UserLib).Reducers.UserReducer
local Friends = require(CorePackages.Workspace.Packages.LegacyFriendsRodux).Reducers.Friends
local FriendCount = require(CorePackages.Workspace.Packages.LegacyFriendsRodux).Reducers.FriendCount

local FFlagRemoveUnusedFriendCountRoduxSlice = require(CorePackages.Workspace.Packages.SharedFlags).FFlagRemoveUnusedFriendCountRoduxSlice

local ConversationsSearch = require(ShareGame.Reducers.ConversationsSearch)
local DeviceInfo = require(ShareGame.Reducers.DeviceInfo)
local Invites = require(ShareGame.Reducers.Invites)
local GameInfo = require(ShareGame.Reducers.GameInfo)
local Page = require(ShareGame.Reducers.Page)
local Toasts = require(ShareGame.Reducers.Toasts)

local ShareLinksRodux = ReducerDependencies.ShareLinksRodux
local var1 = ReducerDependencies.RoduxNetworking.installReducer()
local var2 = ShareLinksRodux.installReducer()

return function(arg1, arg2)
    arg1 = arg1 or {}

    return {
        ConversationsSearch = ConversationsSearch(arg1.ConversationsSearch, arg2),
        DeviceInfo = DeviceInfo(arg1.DeviceInfo, arg2),
        Invites = Invites(arg1.Invites, arg2),
        Page = Page(arg1.Page, arg2),
        PlaceInfos = PlaceInfosReducer(arg1.PlaceInfos, arg2),
        Toasts = Toasts(arg1.Toasts, arg2),
        Users = UserReducer(arg1.Users, arg2),
        Friends = Friends(arg1.Friends, arg2),
        FriendCount = if FFlagRemoveUnusedFriendCountRoduxSlice then nil else FriendCount(arg1.FriendCount, arg2),
        ShareLinks = var2(arg1.ShareLinks, arg2),
        GameInfo = GameInfo(arg1.GameInfo, arg2),
        NetworkStatus = var1(arg1.NetworkStatus, arg2)
    }
end
