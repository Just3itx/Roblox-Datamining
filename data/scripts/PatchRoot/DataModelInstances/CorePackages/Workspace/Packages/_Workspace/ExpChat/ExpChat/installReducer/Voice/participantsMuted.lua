-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T09:01:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChat = script:FindFirstAncestor("ExpChat")
local ExpChatParent = ExpChat.Parent
local Dictionary = require(ExpChatParent.llama).Dictionary
local None = require(ExpChatParent.llama).None
local Rodux = require(ExpChatParent.Rodux)

local Actions = ExpChat.Actions
local VoiceParticipantToggleMuted = require(Actions.VoiceParticipantToggleMuted)
local VoiceParticipantAdded = require(Actions.VoiceParticipantAdded)
local VoiceParticipantRemoved = require(Actions.VoiceParticipantRemoved)

local createReducer = Rodux.createReducer
local tbl1 = {}

tbl1[VoiceParticipantAdded.name] = function(tbl2, arg1)
    local userId = arg1.userId
    local var1 = tbl2[userId] or false

    return Dictionary.set(tbl2, userId, var1)
end

tbl1[VoiceParticipantRemoved.name] = function(tbl2, arg1)
    return Dictionary.set(tbl2, arg1.userId, None)
end

tbl1[VoiceParticipantToggleMuted.name] = function(tbl2, arg1)
    if tbl2[arg1.userId] == nil then
        return tbl2
    end

    return Dictionary.join(tbl2, { [arg1.userId] = arg1.isMuted })
end

return createReducer({}, tbl1)
