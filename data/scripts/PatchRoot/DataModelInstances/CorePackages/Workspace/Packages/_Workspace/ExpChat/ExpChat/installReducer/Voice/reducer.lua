-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T09:01:10Z
-- Luau bytecode version: 14 | Luau type version: 3
local ExpChatParent = script:FindFirstAncestor("ExpChat").Parent
local Rodux = require(ExpChatParent.Rodux)
local GetFFlagExpChatUseVoiceParticipantsStore = require(ExpChatParent.SharedFlags).GetFFlagExpChatUseVoiceParticipantsStore

local bool1 = game:DefineFastFlag("EasierUnmutingVoiceParticipantsMutedReducer", false)

return Rodux.combineReducers({
    participants = if GetFFlagExpChatUseVoiceParticipantsStore() then nil else require(script.Parent.participants),
    participantsMuted = if bool1 then require(script.Parent.participantsMuted) else Rodux.createReducer({}, {}),
    isEnabled = require(script.Parent.isEnabled),
    isVoiceUIVisible = require(script.Parent.isVoiceUIVisible)
})
