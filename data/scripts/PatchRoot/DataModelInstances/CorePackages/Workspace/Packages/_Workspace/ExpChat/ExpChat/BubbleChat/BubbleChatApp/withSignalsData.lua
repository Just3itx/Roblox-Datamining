-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T07:31:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChat = script:FindFirstAncestor("ExpChat")
local ExpChatParent = ExpChat.Parent

local useSignalState = require(ExpChatParent.SignalsReact).useSignalState

local React = require(ExpChatParent.React)
local SharedFlags = require(ExpChatParent.SharedFlags)
local ExpChatShared = require(ExpChatParent.ExpChatShared)

local getFFlagUseCharacterStore = ExpChatShared.Flags.getFFlagUseCharacterStore
local GetFFlagExpChatUseVoiceParticipantsStore = SharedFlags.GetFFlagExpChatUseVoiceParticipantsStore

local GetCharacterStore = require(ExpChat.Stores.GetCharacterStore)
local _createCharacterStore = require(ExpChat.Stores.GetCharacterStore.createCharacterStore)
local GetVoiceStore = require(ExpChat.Stores.GetVoiceStore)
local _createVoiceStore = require(ExpChat.Stores.GetVoiceStore.createVoiceStore)
local characterStore = if getFFlagUseCharacterStore() then GetCharacterStore(false) else nil
local voiceStore = if GetFFlagExpChatUseVoiceParticipantsStore() then GetVoiceStore(false) else nil

local function withSignalsData(arg1)
    return function(tbl1)
        local var1

        if getFFlagUseCharacterStore() and characterStore then
            local getCharacters = characterStore.getCharacters
            var1 = useSignalState(getCharacters)
        else
            var1 = nil
        end

        local var2

        if GetFFlagExpChatUseVoiceParticipantsStore() and voiceStore then
            local getVoiceParticipants = voiceStore.getVoiceParticipants
            var2 = useSignalState(getVoiceParticipants)
        else
            var2 = nil
        end

        local context = ExpChatShared.context
        local messagesStore = context and context.messagesStore
        local var3

        if messagesStore then
            local getMockUserIdToPartOrModel = messagesStore.getMockUserIdToPartOrModel
            var3 = useSignalState(getMockUserIdToPartOrModel)
        else
            var3 = nil
        end

        local var4 = table.clone(tbl1)
        if getFFlagUseCharacterStore() then
            var4.characters = var1
        end
        if GetFFlagExpChatUseVoiceParticipantsStore() then
            var4.voiceParticipants = var2
        end
        if var3 then
            var4.mockUserIdToPartOrModel = var3
        end

        return React.createElement(arg1, var4)
    end
end

return withSignalsData
