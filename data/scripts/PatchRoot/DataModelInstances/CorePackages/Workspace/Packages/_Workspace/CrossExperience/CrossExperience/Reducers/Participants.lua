-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T12:01:27Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CrossExperience = script:FindFirstAncestor("CrossExperience")
local dependencies = require(CrossExperience.dependencies)

local Rodux = dependencies.Rodux
local Cryo = dependencies.Cryo

local ParticipantAdded = require(CrossExperience.Actions).ParticipantAdded
local ParticipantRemoved = require(CrossExperience.Actions).ParticipantRemoved
local ParticipantIsActive = require(CrossExperience.Actions).ParticipantIsActive
local ParticipantIsInactive = require(CrossExperience.Actions).ParticipantIsInactive
local ParticipantWasMuted = require(CrossExperience.Actions).ParticipantWasMuted
local ParticipantWasUnmuted = require(CrossExperience.Actions).ParticipantWasUnmuted
local VoiceChangerWasEnabled = require(CrossExperience.Actions).VoiceChangerWasEnabled
local VoiceChangerWasDisabled = require(CrossExperience.Actions).VoiceChangerWasDisabled
local VoicePackWasSet = require(CrossExperience.Actions).VoicePackWasSet
local VoiceChangerFeedbackWasEnabled = require(CrossExperience.Actions).VoiceChangerFeedbackWasEnabled
local VoiceChangerFeedbackWasDisabled = require(CrossExperience.Actions).VoiceChangerFeedbackWasDisabled
local ParticipantAudioFocusChanged = require(CrossExperience.Actions).ParticipantAudioFocusChanged
local ExperienceJoined = require(CrossExperience.Actions).ExperienceJoined
local ExperienceLeft = require(CrossExperience.Actions).ExperienceLeft
local RestoreState = require(CrossExperience.Actions).RestoreState
local MuteParticipant = require(CrossExperience.Actions).MuteParticipant
local UnmuteParticipant = require(CrossExperience.Actions).UnmuteParticipant

local _Types = require(CrossExperience.Types)
local Utils = require(CrossExperience.Utils)

local tbl1 = {
    participants = {},
    activeUserIds = {},
    publicVoiceFocusedUserIds = {}
}

local function func1(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    local tbl2 = tbl1
    if arg1 then
        tbl2.participants = Utils.stringMapToNumberMap(arg1.participants)
        tbl2.activeUserIds = arg1.activeUserIds
        tbl2.publicVoiceFocusedUserIds = Utils.stringMapToNumberMap(arg1.publicVoiceFocusedUserIds)
    end
    return tbl2
end

return function(arg1)
    local createReducer = Rodux.createReducer
    local tbl2 = func1(arg1)
    local tbl3 = {}

    tbl3[ParticipantAdded.name] = function(arg2, arg3)
        local participant = arg3.payload.participant
        if arg2.participants[participant.userId] then
            return arg2
        end

        local participants = table.clone(arg2.participants)
        participants[participant.userId] = participant

        return Cryo.Dictionary.join(arg2, { participants = participants })
    end

    tbl3[ParticipantRemoved.name] = function(arg2, arg3)
        local userId = arg3.payload.userId

        if not arg2.participants[userId] then
            return arg2
        end

        local participants = table.clone(arg2.participants)
        local activeUserIds = table.clone(arg2.activeUserIds)
        local publicVoiceFocusedUserIds = arg2.publicVoiceFocusedUserIds
        local var3 = table.find(activeUserIds, userId)

        participants[userId] = nil

        if publicVoiceFocusedUserIds[userId] then
            publicVoiceFocusedUserIds = table.clone(arg2.publicVoiceFocusedUserIds)
            publicVoiceFocusedUserIds[userId] = nil
        end

        if var3 then
            table.remove(activeUserIds, var3)
        end

        return Cryo.Dictionary.join(
            arg2,
            {
                participants = participants,
                activeUserIds = activeUserIds,
                publicVoiceFocusedUserIds = publicVoiceFocusedUserIds
            }
        )
    end

    tbl3[ParticipantWasMuted.name] = function(arg2, arg3)
        local userId = arg3.payload.userId
        if not arg2.participants[userId] then
            return arg2
        end

        local participants = arg2.participants
        local activeUserIds = arg2.activeUserIds

        local var1 = table.find(activeUserIds, userId)

        if not participants[userId].isMuted then
            participants = table.clone(arg2.participants)
            participants[userId].isMuted = true
        end

        if var1 then
            activeUserIds = table.clone(arg2.activeUserIds)
            table.remove(activeUserIds, var1)
        end

        return Cryo.Dictionary.join(arg2, { participants = participants, activeUserIds = activeUserIds })
    end

    tbl3[ParticipantWasUnmuted.name] = function(arg2, arg3)
        local userId = arg3.payload.userId
        if not (arg2.participants[userId] and arg2.participants[userId].isMuted) then
            return arg2
        end

        local participants = table.clone(arg2.participants)
        participants[userId].isMuted = false

        return Cryo.Dictionary.join(arg2, { participants = participants })
    end

    tbl3[VoiceChangerWasEnabled.name] = function(arg2, arg3)
        local userId = arg3.payload.userId
        if not arg2.participants[userId] then
            return arg2
        end

        local participants = table.clone(arg2.participants)
        local var2 = table.clone(arg2.participants[userId])

        var2.isVoiceChangerActive = true
        participants[userId] = var2

        return Cryo.Dictionary.join(arg2, { participants = participants })
    end

    tbl3[VoiceChangerWasDisabled.name] = function(arg2, arg3)
        local userId = arg3.payload.userId
        if not arg2.participants[userId] then
            return arg2
        end

        local participants = table.clone(arg2.participants)
        local var2 = table.clone(arg2.participants[userId])

        var2.isVoiceChangerActive = false
        participants[userId] = var2

        return Cryo.Dictionary.join(arg2, { participants = participants })
    end

    tbl3[VoicePackWasSet.name] = function(arg2, arg3)
        local userId = arg3.payload.userId
        if not arg2.participants[userId] then
            return arg2
        end

        local participants = table.clone(arg2.participants)
        local var2 = table.clone(arg2.participants[userId])

        var2.selectedVoicePack = arg3.payload.voicePackName or "None"
        participants[userId] = var2

        return Cryo.Dictionary.union(arg2, { participants = participants })
    end

    tbl3[VoiceChangerFeedbackWasEnabled.name] = function(arg2, arg3)
        local userId = arg3.payload.userId
        if not arg2.participants[userId] then
            return arg2
        end

        local participants = table.clone(arg2.participants)
        local var2 = table.clone(arg2.participants[userId])

        var2.isVoiceChangerHearMyselfActive = true
        participants[userId] = var2

        return Cryo.Dictionary.join(arg2, { participants = participants })
    end

    tbl3[VoiceChangerFeedbackWasDisabled.name] = function(arg2, arg3)
        local userId = arg3.payload.userId
        if not arg2.participants[userId] then
            return arg2
        end

        local participants = table.clone(arg2.participants)
        local var2 = table.clone(arg2.participants[userId])

        var2.isVoiceChangerHearMyselfActive = false
        participants[userId] = var2

        return Cryo.Dictionary.join(arg2, { participants = participants })
    end

    tbl3[ParticipantIsActive.name] = function(arg2, arg3)
        local userId = arg3.payload.userId
        local activeUserIds = table.clone(arg2.activeUserIds)
        local var2 = table.find(activeUserIds, userId)
        if var2 then
            if var2 ~= #activeUserIds then
                table.remove(activeUserIds, var2)
                table.insert(activeUserIds, userId)
            end
        else
            table.insert(activeUserIds, userId)
        end

        return Cryo.Dictionary.join(arg2, { activeUserIds = activeUserIds })
    end

    tbl3[ParticipantIsInactive.name] = function(arg2, arg3)
        local userId = arg3.payload.userId
        local var1 = table.find(arg2.activeUserIds, userId)
        if not var1 then
            return arg2
        end

        local activeUserIds = table.clone(arg2.activeUserIds)
        table.remove(activeUserIds, var1)
        return Cryo.Dictionary.join(arg2, { activeUserIds = activeUserIds })
    end

    tbl3[ExperienceJoined.name] = function(arg2, arg3)
        local payload = arg3.payload
        if not (payload.participants and payload.activeUserIds) then
            return arg2
        end

        return Cryo.Dictionary.join(arg2, {
            participants = payload.participants,
            activeUserIds = payload.activeUserIds,
            publicVoiceFocusedUserIds = payload.publicVoiceFocusedUserIds
        })
    end
    tbl3[RestoreState.name] = function(arg2, arg3)
        if arg3.payload.Participants then
            return Cryo.Dictionary.join({}, arg3.payload.Participants)
        end
        return arg2
    end

    tbl3[ParticipantAudioFocusChanged.name] = function(arg2, arg3)
        local contextIds = arg3.payload.contextIds

        local publicVoiceFocusedUserIds = table.clone(arg2.publicVoiceFocusedUserIds)

        if contextIds then
            for k, contextId in pairs(contextIds) do
                local var2 = tonumber(k)
                if not var2 then
                    continue
                end

                if contextId == 1 then
                    publicVoiceFocusedUserIds[var2] = true
                else
                    publicVoiceFocusedUserIds[var2] = nil
                end
            end
        end

        return Cryo.Dictionary.join(arg2, { publicVoiceFocusedUserIds = publicVoiceFocusedUserIds })
    end

    tbl3[MuteParticipant.name] = function(arg2, arg3)
        local userId = arg3.payload.userId
        if not arg2.participants[userId] or arg2.participants[userId].isMutedLocally then
            return arg2
        end

        local participants = table.clone(arg2.participants)
        participants[userId].isMutedLocally = true

        return Cryo.Dictionary.join(arg2, { participants = participants })
    end

    tbl3[UnmuteParticipant.name] = function(arg2, arg3)
        local userId = arg3.payload.userId
        if not arg2.participants[userId] or arg2.participants[userId].isMutedLocally ~= true then
            return arg2
        end

        local participants = table.clone(arg2.participants)
        participants[userId].isMutedLocally = false

        return Cryo.Dictionary.join(arg2, { participants = participants })
    end

    tbl3[ExperienceLeft.name] = function()
        return {
            participants = {},
            activeUserIds = {},
            publicVoiceFocusedUserIds = {}
        }
    end

    return createReducer(tbl2, tbl3)
end
