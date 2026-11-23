-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T09:50:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local AppChatNetworking = require(AppChatParent.AppChatNetworking)
local Cryo = require(AppChatParent.Cryo)
local Rodux = require(AppChatParent.Rodux)
local RetrievalStatus = require(AppChatParent.Http).Enum.RetrievalStatus
local ThirdPartyChatSettingsLoaded = require(AppChat.Actions.ThirdPartyChatSettingsLoaded)

local tbl1 = {
    retrievalStatus = RetrievalStatus.NotStarted,
    accountChatRetrieved = false,
    accountChatEnabled = false,
    chatEnabled = false,
    groupChatEnabled = false,
    privacySettingsEnabled = false,
    globalRulesEnabled = false,
    thirdPartyPrivacySettingsRetrieved = false,
    thirdPartyPrivacySettingsEnabled = false
}

local function checkRetrievals(tbl2)
    if tbl2.accountChatRetrieved and tbl2.thirdPartyPrivacySettingsRetrieved then
        return Cryo.Dictionary.union(tbl2, {
            chatEnabled = tbl2.accountChatEnabled and tbl2.thirdPartyPrivacySettingsEnabled,
            retrievalStatus = RetrievalStatus.Done
        })
    end
    return tbl2
end

local function handleGetMetadataSucceeded(tbl2, arg1)
    local responseBody = arg1.responseBody
    return checkRetrievals(
        Cryo.Dictionary.union(tbl2, {
            accountChatRetrieved = true,
            chatUserMessagesEnabled = responseBody.isChatUserMessagesEnabled,
            accountChatEnabled = responseBody.isChatEnabled,
            groupChatEnabled = responseBody.isChatEnabled and responseBody.isGroupChatEnabledByPrivacySetting == "enabled",
            privacySettingsEnabled = responseBody.isChatEnabledByPrivacySetting == "enabled",
            globalRulesEnabled = responseBody.isChatEnabledByGlobalRules == "enabled"
        })
    )
end
local createReducer = Rodux.createReducer
local tbl2 = {}

tbl2[ThirdPartyChatSettingsLoaded.name] = function(tbl3, arg1) -- name: handleThirdPartyChatSettingsLoaded
    return checkRetrievals(
        Cryo.Dictionary.union(tbl3, {
            thirdPartyPrivacySettingsRetrieved = arg1.status ~= Enum.ChatRestrictionStatus.Unknown,
            thirdPartyPrivacySettingsEnabled = arg1.status == Enum.ChatRestrictionStatus.NotRestricted
        })
    )
end

tbl2[AppChatNetworking.rodux.GetMetadata.Succeeded.name] = function(tbl3, arg1)
    return handleGetMetadataSucceeded(tbl3, arg1)
end

function tbl2.Debug_GroupChatEnabledToggled(tbl3, _)
    return Cryo.Dictionary.union(tbl3, { groupChatEnabled = not tbl3.groupChatEnabled })
end

return createReducer(tbl1, tbl2)
