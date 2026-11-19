-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T12:01:26Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CrossExperience = script:FindFirstAncestor("CrossExperience")
local dependencies = require(CrossExperience.dependencies)

local Rodux = dependencies.Rodux
local Cryo = dependencies.Cryo
local SharedFlags = dependencies.SharedFlags

local ExperienceJoined = require(CrossExperience.Actions).ExperienceJoined
local ExperienceLeft = require(CrossExperience.Actions).ExperienceLeft
local RestoreState = require(CrossExperience.Actions).RestoreState
local VoiceStatusChanged = require(CrossExperience.Actions).VoiceStatusChanged

local _Types = require(CrossExperience.Types)
local Constants = require(CrossExperience.Constants)

local FStringTimeoutLoadingLocalPlayerInBackgroundDM = SharedFlags.FStringTimeoutLoadingLocalPlayerInBackgroundDM

local VOICE_STATUS = Constants.VOICE_STATUS

local tbl1 = {
    jobId = nil,
    gameId = nil,
    placeId = nil,
    voiceStatus = VOICE_STATUS.DISCONNECTED,
    voiceChannelId = nil,
    voiceSessionId = nil
}

local function isAllowedVoiceStatusTransition(errorVoiceMicRejected, voiceConnecting): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return if SharedFlags.GetFFlagFixPartyVoiceGetPermissions() and errorVoiceMicRejected == VOICE_STATUS.ERROR_VOICE_MIC_REJECTED then voiceConnecting == VOICE_STATUS.VOICE_CONNECTING else errorVoiceMicRejected ~= voiceConnecting
end

return function(arg1)
    local createReducer = Rodux.createReducer
    local var1 = arg1 or tbl1
    local tbl2 = {}

    tbl2[ExperienceJoined.name] = function(arg2, arg3)
        local payload = arg3.payload
        return Cryo.Dictionary.join(arg2, { jobId = payload.jobId, gameId = payload.gameId, placeId = payload.placeId })
    end

    tbl2[ExperienceLeft.name] = function(arg2)
        local voiceStatus = arg2.voiceStatus
        local voiceStatus2 = arg2.voiceStatus

        if voiceStatus ~= Constants.VOICE_STATUS.ERROR_VOICE_DISCONNECTED
            and voiceStatus ~= Constants.VOICE_STATUS.ERROR_START_BACKGROUND_DM
            and voiceStatus ~= Constants.VOICE_STATUS.ERROR_RCC_CONNECTING
            and voiceStatus ~= Constants.VOICE_STATUS.ERROR_RCC_TIMEOUT
            and (FStringTimeoutLoadingLocalPlayerInBackgroundDM == Constants.LOCAL_PLAYER_LOADING_TIMEOUT_ENUM.Disable
                or voiceStatus ~= Constants.VOICE_STATUS.ERROR_BACKGROUND_DM_LOAD_LOCALPLAYER_TIMEOUT)
        then
            voiceStatus2 = Constants.VOICE_STATUS.DISCONNECTED
        end
        return {
            jobId = nil,
            gameId = nil,
            placeId = nil,
            voiceChannelId = nil,
            voiceSessionId = nil,
            voiceStatus = voiceStatus2
        }
    end

    tbl2[RestoreState.name] = function(arg2, arg3)
        if arg3.payload.Experience then
            return Cryo.Dictionary.join({}, arg3.payload.Experience)
        end
        return arg2
    end

    tbl2[VoiceStatusChanged.name] = function(arg2, arg3)
        if not isAllowedVoiceStatusTransition(arg2.voiceStatus, arg3.payload.status) then
            return arg2
        end

        local var2 = Cryo.Dictionary.join(arg2, { voiceStatus = arg3.payload.status })

        if arg3.payload.status == VOICE_STATUS.VOICE_CONNECTED then
            var2 = Cryo.Dictionary.join(
                var2,
                {
                    voiceChannelId = arg3.payload.voiceChannelId,
                    voiceSessionId = arg3.payload.voiceSessionId
                }
            )
        end

        return var2
    end

    return createReducer(var1, tbl2)
end
