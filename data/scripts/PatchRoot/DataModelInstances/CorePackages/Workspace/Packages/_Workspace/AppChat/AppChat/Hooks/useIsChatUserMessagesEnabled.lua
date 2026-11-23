-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T09:41:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local useSelector = require(AppChatParent.RoactUtils).Hooks.RoactRodux.useSelector
local useSignalState = require(AppChatParent.SignalsReact).useSignalState
local getDeepValue2 = require(AppChat.Utils.getDeepValue2)
local GetFriendsChatSettingsStore = require(AppChat.Stores.GetFriendsChatSettingsStore)

local FFlagAppChatUseSignalsForChatSettings = require(AppChat.Flags.FFlagAppChatUseSignalsForChatSettings)

return function()
    local var1 = if FFlagAppChatUseSignalsForChatSettings then useSignalState(GetFriendsChatSettingsStore(false).getChatUserMessagesEnabled) else useSelector(function(arg1)
        return getDeepValue2(arg1, "ChatAppReducer.ChatSettings.chatUserMessagesEnabled")
    end)
    return var1 == nil or var1
end
