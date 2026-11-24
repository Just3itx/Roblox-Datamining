-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T09:40:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChat = script:FindFirstAncestor("ExpChat")
local ExpChatParent = ExpChat.Parent
local SignalsReact = require(ExpChatParent.SignalsReact)

local GetChatStatusStore = require(ExpChat.Stores.GetChatStatusStore)
local GetPresetChatStore = require(ExpChat.Stores.GetPresetChatStore)
local getIsARButtonVisible = require(ExpChat.getIsARButtonVisible)

local function useIsARButtonVisible()
    local chatStatusStore = GetChatStatusStore(false)
    local var1 = SignalsReact.useSignalState(chatStatusStore.getChatStatus)

    local presetChatStore = GetPresetChatStore(false)
    local var2 = SignalsReact.useSignalState(presetChatStore.getIsEnabled)
    local var3 = SignalsReact.useSignalState(presetChatStore.getAccessLevel)

    return getIsARButtonVisible(var1, var2, var3)
end

return useIsARButtonVisible
