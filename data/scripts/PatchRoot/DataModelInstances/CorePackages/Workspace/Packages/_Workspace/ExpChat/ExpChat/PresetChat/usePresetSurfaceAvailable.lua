-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T09:20:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChat = script:FindFirstAncestor("ExpChat")
local ExpChatParent = ExpChat.Parent
local SignalsReact = require(ExpChatParent.SignalsReact)

local GetPresetChatStore = require(ExpChat.Stores.GetPresetChatStore)
local FFlagExpChatUniverseChatPresetEnabled = require(ExpChat.Flags.FFlagExpChatUniverseChatPresetEnabled)
local Constants = require(ExpChat.PresetChat.Constants)

local function usePresetSurfaceAvailable(arg1): boolean
    local presetChatStore = GetPresetChatStore(false)
    local var1 = SignalsReact.useSignalState(presetChatStore.getIsEnabled)
    local var2 = SignalsReact.useSignalState(presetChatStore.getAccessLevel)

    return if var1 and var2 == Constants.AccessLevel.Enabled then not not (arg1 ~= nil or FFlagExpChatUniverseChatPresetEnabled) else false
end

return usePresetSurfaceAvailable
