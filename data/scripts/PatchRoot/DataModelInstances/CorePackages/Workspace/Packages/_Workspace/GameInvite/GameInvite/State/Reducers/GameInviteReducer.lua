-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T14:50:53Z
-- Luau bytecode version: 14 | Luau type version: 3
local GameInviteParent = script:FindFirstAncestor("GameInvite").Parent
local scriptParent = script.Parent
local UserReducer = require(GameInviteParent.UserLib).Reducers.UserReducer
local Rodux = require(GameInviteParent.Rodux)
local FFlagUseSignalsForGameInvitesStatus = require(GameInviteParent.SharedFlags).FFlagUseSignalsForGameInvitesStatus
local FFlagRemoveUnusedFriendCountRoduxSlice = require(GameInviteParent.SharedFlags).FFlagRemoveUnusedFriendCountRoduxSlice
local LegacyFriendsRodux = require(GameInviteParent.LegacyFriendsRodux)
local ReducerDependencies = require(GameInviteParent.NotificationsCommon).ReducerDependencies

local FriendCount = LegacyFriendsRodux.Reducers.FriendCount

local Invites = require(scriptParent.Invites)

local RoduxNetworking = ReducerDependencies.RoduxNetworking
local ShareLinksRodux = ReducerDependencies.ShareLinksRodux
local NetworkStatus = RoduxNetworking.installReducer()
local ShareLinks = ShareLinksRodux.installReducer()

local combineReducers = Rodux.combineReducers
local tbl1 = {
    FriendCount = 0,
    GameInvitesStatus = 0,
    Users = 0,
    ShareLinks = 0,
    NetworkStatus = 0
}

if FFlagRemoveUnusedFriendCountRoduxSlice then
    FriendCount = nil
end

tbl1.FriendCount = FriendCount
if FFlagUseSignalsForGameInvitesStatus then
    Invites = nil
end

tbl1.GameInvitesStatus = Invites
tbl1.Users = UserReducer
tbl1.ShareLinks = ShareLinks
tbl1.NetworkStatus = NetworkStatus
return combineReducers(tbl1)
