-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T01:40:39Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local RobloxGui = game:GetService("CoreGui"):WaitForChild("RobloxGui")
local FFlagEnableVoiceChatStorybookFix = require(RobloxGui.Modules.Flags.FFlagEnableVoiceChatStorybookFix)

local Cryo = require(CorePackages.Packages.Cryo)
local Rodux = require(CorePackages.Packages.Rodux)
local VOICE_STATE = if FFlagEnableVoiceChatStorybookFix() then require(CorePackages.Workspace.Packages.VoiceChat).Constants.VOICE_STATE else require(script.Parent.Parent.VoiceChatServiceManager).default.VOICE_STATE
local ParticipantAdded = require(script.Parent.Parent.Actions.ParticipantAdded)
local ParticipantRemoved = require(script.Parent.Parent.Actions.ParticipantRemoved)
local VoiceStateChanged = require(script.Parent.Parent.Actions.VoiceStateChanged)
local VoiceEnabledChanged = require(script.Parent.Parent.Actions.VoiceEnabledChanged)
local ParticipantsChanged = require(script.Parent.Parent.Actions.ParticipantsChanged)

local createReducer = Rodux.createReducer

local tbl1 = {}

tbl1[VoiceEnabledChanged.name] = function(arg1, arg2)
    return Cryo.Dictionary.join(arg1, { voiceEnabled = arg2.enabled })
end

tbl1[ParticipantAdded.name] = function(arg1, arg2)
    local userId = arg2.userId
    local var1 = arg1[userId] or VOICE_STATE.HIDDEN

    return Cryo.Dictionary.join(arg1, { [userId] = var1 })
end

tbl1[ParticipantRemoved.name] = function(arg1, arg2)
    return Cryo.Dictionary.join(arg1, { [arg2.userId] = Cryo.None })
end

tbl1[ParticipantsChanged.name] = function(arg1, arg2)
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

tbl1[VoiceStateChanged.name] = function(arg1, arg2)
    if not arg1[arg2.userId] then
        return arg1
    end

    return Cryo.Dictionary.join(arg1, { [arg2.userId] = arg2.newState })
end

return (createReducer({}, tbl1))
