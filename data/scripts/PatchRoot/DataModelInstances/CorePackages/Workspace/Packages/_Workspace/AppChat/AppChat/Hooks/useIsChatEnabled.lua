-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T09:41:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local useSelector = require(AppChatParent.RoactUtils).Hooks.RoactRodux.useSelector
local useSignalState = require(AppChatParent.SignalsReact).useSignalState
local getDeepValue = require(AppChat.Utils.getDeepValue)
local GetFriendsChatSettingsStore = require(AppChat.Stores.GetFriendsChatSettingsStore)

local FFlagAppChatUseSignalsForChatSettings = require(AppChat.Flags.FFlagAppChatUseSignalsForChatSettings)

return function()
    if FFlagAppChatUseSignalsForChatSettings then
        return useSignalState(GetFriendsChatSettingsStore(false).getChatEnabled)
    end

    return useSelector(function(arg1)
        return getDeepValue(arg1, "ChatAppReducer.ChatSettings.chatEnabled") or false
    end)
end
