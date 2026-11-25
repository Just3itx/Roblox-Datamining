-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T22:21:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local VoiceChat = script:FindFirstAncestor("VoiceChat")
local GetShowAgeVerificationOverlay = require(VoiceChat.AgeVerificationOverlay.GetShowAgeVerificationOverlay)
local SetShowAgeVerificationOverlay = require(VoiceChat.AgeVerificationOverlay.SetShowAgeVerificationOverlay)

local VoiceChatParent = VoiceChat.Parent
local Promise = require(VoiceChatParent.Promise)
local PerformFetch = require(VoiceChatParent.Http).PerformFetch
local mutedError = require(VoiceChatParent.Loggers).mutedError

local Logging = require(VoiceChatParent.AppCommonLib).Logging

local module = {}

local function keyMapper(arg1) -- Luacid: Inlined by compiler; 2 call sites recovered
    return "luaapp.showageverificationoverlay." .. arg1
end

module.KeyMapper = keyMapper

function module.Fetch(arg1, str1: string, str2: string?)
    if type(str1) ~= "string" then
        error("ApiFetchShowAgeVerificationOverlay thunk expects universeId to be a string")
    end

    local str3 = str2 or ""
    if type(str3) ~= "string" then
        error("ApiFetchShowAgeVerificationOverlay thunk expects placeId to be a string")
    end

    return PerformFetch.Single(keyMapper(str1), function(arg2)
        return GetShowAgeVerificationOverlay(arg1, str1, str3):andThen(function(arg3)
            local responseBody = arg3.responseBody
            local isVoiceEnabled = not (responseBody.voiceSettings == nil) and responseBody.voiceSettings.isVoiceEnabled

            if responseBody.showAgeVerificationOverlay then
                mutedError(`showAgeVerificationOverlay is deprecated but was truthy for universe {str1}`)
            end

            if responseBody == nil
                or responseBody.showAgeVerificationOverlay == nil
                or responseBody.universePlaceVoiceEnabledSettings == nil
            then
                Logging.warn("Response from GetShowAgeVerificationOverlay is malformed!")
                return Promise.reject({ HttpError = Enum.HttpError.OK })
            end

            local isPlaceEnabledForVoice = responseBody.universePlaceVoiceEnabledSettings.isPlaceEnabledForVoice
            local isUniverseEnabledForVoice = responseBody.universePlaceVoiceEnabledSettings.isUniverseEnabledForVoice
            local isUniverseEnabledForAvatarVideo = responseBody.universePlaceVoiceEnabledSettings.isUniverseEnabledForAvatarVideo

            arg2:dispatch(
                SetShowAgeVerificationOverlay(
                    str1,
                    isPlaceEnabledForVoice,
                    isUniverseEnabledForVoice,
                    isVoiceEnabled,
                    responseBody.showVoiceOptInOverlay,
                    isUniverseEnabledForAvatarVideo,
                    responseBody.elegibleToSeeVoiceUpsell
                )
            )
            return Promise.resolve(arg3)
        end)
    end)
end

function module.GetFetchingStatus(arg1, arg2)
    return PerformFetch.GetStatus(arg1, (keyMapper(arg2)))
end

return module
