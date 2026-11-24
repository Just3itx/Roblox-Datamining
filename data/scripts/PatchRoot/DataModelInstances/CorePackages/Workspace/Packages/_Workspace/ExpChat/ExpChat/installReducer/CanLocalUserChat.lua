-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T08:51:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChat = script:FindFirstAncestor("ExpChat")
local ExpChatParent = ExpChat.Parent
local Rodux = require(ExpChatParent.Rodux)

local Actions = ExpChat.Actions
local ChatPrivacySettingsReceived = require(Actions.ChatPrivacySettingsReceived)
local ChatPrivacySettingsFetchFailed = require(Actions.ChatPrivacySettingsFetchFailed)

local createReducer = Rodux.createReducer
local tbl1 = {}
tbl1[ChatPrivacySettingsReceived.name] = function(_, arg1)
    return arg1.canUserChat
end

tbl1[ChatPrivacySettingsFetchFailed.name] = function(_, _): boolean
    return false
end

return createReducer(false, tbl1)
