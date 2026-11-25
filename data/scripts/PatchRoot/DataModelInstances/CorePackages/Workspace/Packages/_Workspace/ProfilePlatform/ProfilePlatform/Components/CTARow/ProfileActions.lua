-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T04:50:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AcceptFriendRequestActions = require(script.AcceptFriendRequestActions)
local AddFriendActions = require(script.AddFriendActions)
local BlockActions = require(script.BlockActions)
local CallAction = require(script.CallAction)
local ChatAction = require(script.ChatAction)
local CommunityActions = require(script.CommunityActions)
local CurrencyTransferAction = require(script.CurrencyTransferAction)
local EditAliasAction = require(script.EditAliasAction)
local EditAppearanceActions = require(script.EditAppearanceActions)
local EditProfileAction = require(script.EditProfileAction)
local FollowActions = require(script.FollowActions)
local IgnoreFriendRequestAction = require(script.IgnoreFriendRequestAction)
local JoinExperienceAction = require(script.JoinExperienceAction)
local PlayExperienceAction = require(script.PlayExperienceAction)
local PendingFriendRequestAction = require(script.PendingFriendRequestAction)
local QrCodeAction = require(script.QrCodeAction)
local ReportAction = require(script.ReportAction)
local ShareProfileAction = require(script.ShareProfileAction)
local TradeItemsAction = require(script.TradeItemsAction)
local TrustedConnectionActions = require(script.TrustedConnectionActions)
local UnfriendAction = require(script.UnfriendAction)
local UnlockChatAction = require(script.UnlockChatAction)
local ViewAboutAction = require(script.ViewAboutAction)
local ViewPlatformProfileAction = require(script.ViewPlatformProfileAction)

local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local ProfilePlatformParent = ProfilePlatform.Parent
local _Enums = require(ProfilePlatform.Common.Enums)
local _Types = require(ProfilePlatform.Components.CTARow.Types)
local SupportedProfileTypes = require(script.SupportedProfileTypes)
local SharedFlags = require(ProfilePlatformParent.SharedFlags)
local FFlagFriendsCallingClientGate_DEV = SharedFlags.FFlagFriendsCallingClientGate_DEV
local FFlagJoinabilityCTARefactor = SharedFlags.FFlagJoinabilityCTARefactor

local tbl1 = ({})

local tbl2 = {
    AcceptFriendRequestActions,
    AddFriendActions,
    BlockActions,
    ChatAction,
    CommunityActions,
    CurrencyTransferAction,
    EditAliasAction,
    EditAppearanceActions,
    EditProfileAction,
    FollowActions,
    IgnoreFriendRequestAction,
    JoinExperienceAction,
    PendingFriendRequestAction,
    QrCodeAction,
    ReportAction,
    ShareProfileAction,
    TradeItemsAction,
    TrustedConnectionActions,
    UnfriendAction,
    UnlockChatAction,
    ViewAboutAction,
    ViewPlatformProfileAction
}

if FFlagFriendsCallingClientGate_DEV then
    table.insert(tbl2, CallAction)
end

if FFlagJoinabilityCTARefactor then
    table.insert(tbl2, PlayExperienceAction)
end

local function withValidation(str1: string, arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    return function(arg2)
        local var1 = arg1(arg2)
        if var1 ~= nil then
            assert(
                type(var1.onActivated) == "table",
                str1 .. " has onActivated as " .. type(var1.onActivated) .. ", expected table"
            )
            for value in var1.onActivated do
                local var2 = SupportedProfileTypes[value]
                assert(
                    var2 and table.find(var2, str1),
                    str1 .. " has onActivated for " .. tostring(value) .. " but is missing from SupportedProfileTypes"
                )
            end
        end
        return var1
    end
end

for _, value in tbl2 do
    for value2, value3 in value do
        assert(tbl1[value2] == nil, "Duplicate ProfileAction key: " .. tostring(value2))
        tbl1[value2] = withValidation(value2, value3)
    end
end

for value, value2 in SupportedProfileTypes do
    for _, value3 in value2 do
        assert(
            tbl1[value3] ~= nil,
            value3 .. " is listed in SupportedProfileTypes for " .. tostring(value) .. " but has no matching factory"
        )
    end
end

return tbl1
