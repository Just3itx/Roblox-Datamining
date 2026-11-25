-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T22:21:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local VoiceChat = script:FindFirstAncestor("VoiceChat")
local SetShowAgeVerificationOverlay = require(VoiceChat.AgeVerificationOverlay.SetShowAgeVerificationOverlay)
local VoiceChatParent = VoiceChat.Parent
local Cryo = require(VoiceChatParent.Cryo)

return function(arg1, arg2)
    arg1 = arg1 or {}

    if arg2.type == SetShowAgeVerificationOverlay.name then
        local join = Cryo.Dictionary.join
        local tbl1

        if arg2.universeId == nil then
            tbl1 = {}
        else
            tbl1 = {
                [arg2.universeId] = {
                    universeId = arg2.universeId,
                    isPlaceEnabledForVoice = arg2.isPlaceEnabledForVoice,
                    showVoiceOptInOverlay = arg2.showVoiceOptInOverlay,
                    isUniverseEnabledForVoice = arg2.isUniverseEnabledForVoice,
                    isVoiceEnabled = arg2.isVoiceEnabled,
                    isUniverseEnabledForAvatarVideo = arg2.isUniverseEnabledForAvatarVideo,
                    elegibleToSeeVoiceUpsell = arg2.elegibleToSeeVoiceUpsell
                }
            }
                or {}
        end

        arg1 = join(arg1, tbl1)
    end

    return arg1
end
