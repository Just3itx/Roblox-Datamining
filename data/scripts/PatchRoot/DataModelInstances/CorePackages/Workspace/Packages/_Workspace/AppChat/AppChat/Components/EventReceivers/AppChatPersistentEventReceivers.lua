-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T08:20:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent
local React = require(AppChatParent.React)

local AppChatAccountSettingsEventReceiver = require(script.Parent.AppChatAccountSettingsEventReceiver)
local AppChatInterventionEventReceiver = require(script.Parent.AppChatInterventionEventReceiver)
local AppChatThirdPartySettingsEventReceiver = require(script.Parent.AppChatThirdPartySettingsEventReceiver)
local AppChatNotificationEventReceiver = require(script.Parent.AppChatNotificationEventReceiver)
local AppChatRemoveThirdPartyRestriction = require(script.Parent.AppChatRemoveThirdPartyRestriction)

local FFlagAppChatFriendsTabIxpEnabled = require(AppChat.Flags.FFlagAppChatFriendsTabIxpEnabled)

local FriendsChatExperimentExposureEventReceiver = nil
local function getFriendsChatExperimentExposureEventReceiver() -- Luacid: Inlined by compiler; 1 call site recovered
    if FriendsChatExperimentExposureEventReceiver == nil then
        FriendsChatExperimentExposureEventReceiver = require(script.Parent.FriendsChatExperimentExposureEventReceiver)
    end
    return FriendsChatExperimentExposureEventReceiver
end

local FFlagEnableShareSheet = require(AppChatParent.SharedFlags).FFlagEnableShareSheet
local ExternalChatMessageSenderRegistration = if FFlagEnableShareSheet then require(script.Parent.ExternalChatMessageSenderRegistration) else nil
local ThirdPartyUserService = game:GetService("ThirdPartyUserService")

local function AppChatPersistentEventReceivers(tbl1)
    return React.createElement(React.Fragment, nil, {
        accountSettings = React.createElement(AppChatAccountSettingsEventReceiver, { isInExperience = tbl1.isInExperience }),
        intervention = React.createElement(AppChatInterventionEventReceiver, {}),
        thirdPartySettings = React.createElement(
            if ThirdPartyUserService ~= nil and ThirdPartyUserService:IsChatRestrictionSupported() then AppChatThirdPartySettingsEventReceiver else AppChatRemoveThirdPartyRestriction
        ),
        notification = React.createElement(AppChatNotificationEventReceiver, { isInExperience = tbl1.isInExperience }),
        friendsChatExperimentExposure = if FFlagAppChatFriendsTabIxpEnabled and tbl1.isInExperience then React.createElement((getFriendsChatExperimentExposureEventReceiver())) else nil,
        externalChatMessageSenderRegistration = if FFlagEnableShareSheet then React.createElement(ExternalChatMessageSenderRegistration, { isInExperience = tbl1.isInExperience }) else nil
    })
end

return AppChatPersistentEventReceivers
