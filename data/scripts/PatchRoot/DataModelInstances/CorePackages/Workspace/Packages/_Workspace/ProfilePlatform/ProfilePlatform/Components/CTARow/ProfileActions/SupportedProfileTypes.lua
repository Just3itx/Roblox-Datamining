-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T04:51:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local ProfilePlatformParent = ProfilePlatform.Parent

local SharedFlags = require(ProfilePlatformParent.SharedFlags)
local Enums = require(ProfilePlatform.Common.Enums)
local ProfileTypes = Enums.ProfileTypes

local FFlagProfilePlatformEnableEditAppearanceMenu = require(ProfilePlatform.Flags.FFlagProfilePlatformEnableEditAppearanceMenu)

local FFlagProfilePlatformEditBackgroundMenuItem = require(ProfilePlatform.Flags.FFlagProfilePlatformEditBackgroundMenuItem)
local FFlagProfilePlatformEnableEditLook = require(ProfilePlatform.Flags.FFlagProfilePlatformEnableEditLook)
local FFlagProfilePlatformNewProfileHeader = SharedFlags.FFlagProfilePlatformNewProfileHeader

local FFlagEnablePlatformProfileContextualMenuOption = SharedFlags.FFlagEnablePlatformProfileContextualMenuOption
local FFlagProfilePlatformEnableCurrencyTransfer = SharedFlags.FFlagProfilePlatformEnableCurrencyTransfer
local FFlagProfilePlatformEnableTradeItems = require(ProfilePlatform.Flags.FFlagProfilePlatformEnableTradeItems)
local FFlagProfilePlatformAddTC = SharedFlags.FFlagProfilePlatformAddTC
local FFlagFixTFLinksVRGating = require(ProfilePlatform.Flags.FFlagFixTFLinksVRGating)
local FFlagProfilePlatformEnableUserFollow = require(ProfilePlatform.Flags.FFlagProfilePlatformEnableUserFollow)
local FFlagFriendsCallingClientGate_DEV = SharedFlags.FFlagFriendsCallingClientGate_DEV
local FFlagJoinabilityCTARefactor = SharedFlags.FFlagJoinabilityCTARefactor

local tbl1 = {
    Enums.ProfileActions.AddFriend,
    Enums.ProfileActions.CannotAddFriend,
    Enums.ProfileActions.AcceptFriendRequest,
    Enums.ProfileActions.AcceptOffNetworkFriendRequest,
    Enums.ProfileActions.Block,
    Enums.ProfileActions.Unblock,
    Enums.ProfileActions.Chat,
    Enums.ProfileActions.EditAlias,
    Enums.ProfileActions.EditAvatar,
    Enums.ProfileActions.EditProfile,
    Enums.ProfileActions.IgnoreFriendRequest,
    Enums.ProfileActions.JoinExperience,
    Enums.ProfileActions.PendingFriendRequest,
    Enums.ProfileActions.QrCode,
    Enums.ProfileActions.Report,
    Enums.ProfileActions.ShareProfile,
    Enums.ProfileActions.Unfriend,
    Enums.ProfileActions.RemoveTrustedConnection,
    Enums.ProfileActions.UnlockChat
}

if FFlagFriendsCallingClientGate_DEV then
    table.insert(tbl1, Enums.ProfileActions.Call)
end

if FFlagJoinabilityCTARefactor then
    table.insert(tbl1, Enums.ProfileActions.PlayExperience)
end

if FFlagProfilePlatformEnableEditAppearanceMenu then
    table.insert(tbl1, Enums.ProfileActions.EditAppearance)
    table.insert(tbl1, Enums.ProfileActions.EditEmotes)
    table.insert(tbl1, Enums.ProfileActions.SwitchAvatar)
    if FFlagProfilePlatformEditBackgroundMenuItem then
        table.insert(tbl1, Enums.ProfileActions.EditBackground)
    end
end

if FFlagProfilePlatformEnableEditLook then
    table.insert(tbl1, Enums.ProfileActions.EditLook)
end

if FFlagProfilePlatformEnableCurrencyTransfer then
    table.insert(tbl1, Enums.ProfileActions.CurrencyTransfer)
end

if FFlagProfilePlatformEnableTradeItems then
    table.insert(tbl1, Enums.ProfileActions.TradeItems)
end

if FFlagProfilePlatformAddTC then
    table.insert(tbl1, Enums.ProfileActions.AddTrustedConnection)
    table.insert(tbl1, Enums.ProfileActions.AddIncomingTrustedConnection)
    table.insert(tbl1, Enums.ProfileActions.PendingTrustedConnection)
end

if not FFlagFixTFLinksVRGating or FFlagProfilePlatformAddTC then
    table.insert(tbl1, Enums.ProfileActions.AddTrustedConnectionViaLink)
end

table.insert(tbl1, Enums.ProfileActions.PendingIncomingTrustedConnection)

if FFlagProfilePlatformNewProfileHeader then
    table.insert(tbl1, Enums.ProfileActions.ViewAbout)
end

if FFlagEnablePlatformProfileContextualMenuOption then
    table.insert(tbl1, Enums.ProfileActions.ViewPlatformProfile)
end

if FFlagProfilePlatformEnableUserFollow then
    table.insert(tbl1, Enums.ProfileActions.Follow)
    table.insert(tbl1, Enums.ProfileActions.Unfollow)
end

local tbl2 = {}
table.insert(tbl2, Enums.ProfileActions.CopyLink)
table.insert(tbl2, Enums.ProfileActions.JoinCommunity)
table.insert(tbl2, Enums.ProfileActions.CancelJoinCommunityRequest)
table.insert(tbl2, Enums.ProfileActions.ViewCommunity)
table.insert(tbl2, Enums.ProfileActions.LeaveCommunity)
table.insert(tbl2, Enums.ProfileActions.MakePrimaryCommunity)
table.insert(tbl2, Enums.ProfileActions.RemovePrimaryCommunity)
table.insert(tbl2, Enums.ProfileActions.Report)
table.insert(tbl2, Enums.ProfileActions.ViewFullProfile)
table.insert(tbl2, Enums.ProfileActions.Follow)
table.insert(tbl2, Enums.ProfileActions.Unfollow)

local tbl3 = { Enums.ProfileActions.AddFriendFromContacts, Enums.ProfileActions.AddFriendFromContactsSent }

return {
    [ProfileTypes.User] = tbl1,
    [ProfileTypes.Community] = tbl2,
    [ProfileTypes.Contact] = tbl3
}
