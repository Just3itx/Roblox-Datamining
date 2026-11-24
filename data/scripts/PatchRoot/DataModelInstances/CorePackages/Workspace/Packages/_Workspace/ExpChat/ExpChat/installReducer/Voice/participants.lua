-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T09:01:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChat = script:FindFirstAncestor("ExpChat")
local ExpChatParent = ExpChat.Parent
local Dictionary = require(ExpChatParent.llama).Dictionary
local None = require(ExpChatParent.llama).None
local Rodux = require(ExpChatParent.Rodux)

local VOICE_STATE = require(ExpChatParent.VoiceChat).Constants.VOICE_STATE
local Actions = ExpChat.Actions
local VoiceParticipantAdded = require(Actions.VoiceParticipantAdded)
local VoiceParticipantRemoved = require(Actions.VoiceParticipantRemoved)
local VoiceStateChanged = require(Actions.VoiceStateChanged)
local VoiceParticipantsChanged = require(Actions.VoiceParticipantsChanged)

local createReducer = Rodux.createReducer
local tbl1 = {}

tbl1[VoiceParticipantAdded.name] = function(tbl2, arg1)
    local userId = arg1.userId
    local var1 = tbl2[userId] or "Hidden"

    return Dictionary.join(tbl2, { [userId] = var1 })
end

tbl1[VoiceParticipantRemoved.name] = function(tbl2, arg1)
    return Dictionary.join(tbl2, { [arg1.userId] = None })
end

tbl1[VoiceParticipantsChanged.name] = function(arg1, arg2)
    local newParticipants = arg2.newParticipants
    local var1 = table.clone(arg1)
    for k, newParticipant in newParticipants do
        local inactive = VOICE_STATE.INACTIVE
        if not newParticipant.subscriptionCompleted then
            inactive = VOICE_STATE.CONNECTING
        elseif newParticipant.isMutedLocally then
            inactive = VOICE_STATE.LOCAL_MUTED
        elseif newParticipant.isMuted then
            inactive = VOICE_STATE.MUTED
        elseif newParticipant.isSignalActive then
            inactive = VOICE_STATE.TALKING
        end
        var1[tostring(k)] = inactive
    end
    return var1
end

tbl1[VoiceStateChanged.name] = function(tbl2, arg1)
    if not tbl2[arg1.userId] then
        return tbl2
    end

    return Dictionary.join(tbl2, { [arg1.userId] = arg1.newState })
end

return createReducer({}, tbl1)
