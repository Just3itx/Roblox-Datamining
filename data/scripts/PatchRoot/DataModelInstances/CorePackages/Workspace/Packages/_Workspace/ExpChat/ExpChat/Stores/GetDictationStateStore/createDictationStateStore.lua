-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T09:30:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChat = script:FindFirstAncestor("ExpChat")
local ExpChatParent = ExpChat.Parent
local Signals = require(ExpChatParent.Signals)
local createSignal = Signals.createSignal
local createComputed = Signals.createComputed

local DictationState = require(ExpChat.ChatInput.UI.ChatInputBar.Dictation.DictationState)

return function()
    local getDictationState, setDictationState = createSignal(DictationState.Idle)

    return {
        getDictationState = getDictationState,
        getIsListening = createComputed(function(arg1): boolean
            return getDictationState(arg1) == DictationState.Listening
        end),
        setDictationState = setDictationState
    }
end
