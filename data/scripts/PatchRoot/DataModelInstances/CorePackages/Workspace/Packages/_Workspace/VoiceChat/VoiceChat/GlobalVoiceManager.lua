-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T22:30:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local VoiceChatParent = script:FindFirstAncestor("VoiceChat").Parent
local VoiceChatCore = require(VoiceChatParent.VoiceChatCore)
local CrossExperienceVoice = require(VoiceChatParent.CrossExperienceVoice)
local CrossExperience = require(VoiceChatParent.CrossExperience)
local SharedFlags = require(VoiceChatParent.SharedFlags)

local default = VoiceChatCore.CoreVoiceManager.default
local default2 = CrossExperienceVoice.CrossExperienceVoiceManager.default
local AUDIO_FOCUS_MANAGEMENT = CrossExperience.Constants.AUDIO_FOCUS_MANAGEMENT

local fFlagEnableCrossExpVoice = SharedFlags.GetFFlagEnableCrossExpVoice()
local fFlagEnableCrossExperienceVoiceCaptureMute = SharedFlags.GetFFlagEnableCrossExperienceVoiceCaptureMute()

local module = {}
module.__index = module

function module.new()
    local result = {}
    setmetatable(result, module)
    return result
end

function module.isPublicVoiceFocused(_): boolean
    return not fFlagEnableCrossExpVoice or default2:getCurrentAudioContext() == AUDIO_FOCUS_MANAGEMENT.UGC.CONTEXT_ID
end

function module.isPrivateVoiceFocused(_)
    return fFlagEnableCrossExpVoice and default2:getCurrentAudioContext() == AUDIO_FOCUS_MANAGEMENT.CEV.CONTEXT_ID
end

function module.MuteAll(tbl1, str1: string?)
    if tbl1:isPrivateVoiceFocused() and fFlagEnableCrossExperienceVoiceCaptureMute then
        default2:muteAll(str1)
    end

    if tbl1:isPublicVoiceFocused() and default:UserVoiceEnabled() and default:IsInitialized() then
        default:MuteAll(true, str1)
    end
end

function module.UnmuteAll(tbl1, str1: string?)
    if tbl1:isPrivateVoiceFocused() and fFlagEnableCrossExperienceVoiceCaptureMute then
        default2:unmuteAll(str1)
    end

    if tbl1:isPublicVoiceFocused() and default:UserVoiceEnabled() and default:IsInitialized() then
        default:MuteAll(false, str1)
    end
end

module.default = module.new()

return module
