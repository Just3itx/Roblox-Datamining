-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T22:21:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local VoiceChatParent = script:FindFirstAncestor("VoiceChat").Parent
return require(VoiceChatParent.Rodux).makeActionCreator(script.Name, function(universeId, isPlaceEnabledForVoice, isUniverseEnabledForVoice, isVoiceEnabled, showVoiceOptInOverlay, isUniverseEnabledForAvatarVideo, elegibleToSeeVoiceUpsell)
    return {
        universeId = universeId,
        isPlaceEnabledForVoice = isPlaceEnabledForVoice,
        isUniverseEnabledForVoice = isUniverseEnabledForVoice,
        isVoiceEnabled = isVoiceEnabled,
        isUniverseEnabledForAvatarVideo = isUniverseEnabledForAvatarVideo,
        showVoiceOptInOverlay = showVoiceOptInOverlay,
        elegibleToSeeVoiceUpsell = elegibleToSeeVoiceUpsell
    }
end)
