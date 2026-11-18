-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-18T23:30:54Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local CrossExperience = script:FindFirstAncestor("CrossExperience")

local Constants = require(CrossExperience.Constants)
local _Types = require(CrossExperience.Types)
local VOICE_STATUS = Constants.VOICE_STATUS

local tbl1 = {
    [VOICE_STATUS.ERROR_VOICE_INIT] = true,
    [VOICE_STATUS.ERROR_VOICE_SETUP] = true,
    [VOICE_STATUS.ERROR_VOICE_JOIN] = true,
    [VOICE_STATUS.ERROR_VOICE_MIC_REJECTED] = true,
    [VOICE_STATUS.ERROR_VOICE_MODERATED] = true,
    [VOICE_STATUS.ERROR_VOICE_FAILED] = true
}

local tbl2 = {
    [VOICE_STATUS.ERROR_START_BACKGROUND_DM] = true,
    [VOICE_STATUS.ERROR_RCC_CONNECTING] = true,
    [VOICE_STATUS.ERROR_VOICE_DISCONNECTED] = true,
    [VOICE_STATUS.ERROR_RCC_TIMEOUT] = true,
    [VOICE_STATUS.ERROR_BACKGROUND_DM_LOAD_LOCALPLAYER_TIMEOUT] = true
}
tbl1[VOICE_STATUS.ERROR_VOICE_MIC_REJECTED] = nil

function isVoiceRetriableErrorByGameJoin(arg1): boolean
    return not (arg1 == nil) and tbl2[arg1] == true
end

function isMicPermissionsError(errorVoiceMicRejected): boolean
    return not (errorVoiceMicRejected == nil) and errorVoiceMicRejected == VOICE_STATUS.ERROR_VOICE_MIC_REJECTED
end

function isVoiceRetriableErrorByVoiceJoin(arg1): boolean
    return not (arg1 == nil) and tbl1[arg1] == true
end

function isVoiceRetriableError(arg1)
    return isVoiceRetriableErrorByGameJoin(arg1) or isVoiceRetriableErrorByVoiceJoin(arg1)
end

return {
    isVoiceRetriableError = isVoiceRetriableError,
    isVoiceRetriableErrorByGameJoin = isVoiceRetriableErrorByGameJoin,
    isVoiceRetriableErrorByVoiceJoin = isVoiceRetriableErrorByVoiceJoin,
    isMicPermissionsError = isMicPermissionsError
}
