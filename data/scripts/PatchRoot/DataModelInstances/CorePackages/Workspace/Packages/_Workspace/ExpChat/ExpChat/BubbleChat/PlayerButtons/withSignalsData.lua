-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T07:41:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChat = script:FindFirstAncestor("ExpChat")
local ExpChatParent = ExpChat.Parent

local Signals = require(ExpChatParent.Signals)
local useSignalState = require(ExpChatParent.SignalsReact).useSignalState

local React = require(ExpChatParent.React)

local GetVoiceStore = require(ExpChat.Stores.GetVoiceStore)
local _createVoiceStore = require(ExpChat.Stores.GetVoiceStore.createVoiceStore)

local voiceStore = GetVoiceStore(false)

local signal = Signals.createSignal(nil)

local function withSignalsData(arg1)
    return function(arg2)
        local userId = arg2.userId
        local orCreateVoiceState = if userId then voiceStore.getOrCreateVoiceState(userId) else nil
        local voiceState = useSignalState(orCreateVoiceState or signal)

        local var2 = table.clone(arg2)
        var2.voiceState = voiceState

        return React.createElement(arg1, var2)
    end
end

return withSignalsData
