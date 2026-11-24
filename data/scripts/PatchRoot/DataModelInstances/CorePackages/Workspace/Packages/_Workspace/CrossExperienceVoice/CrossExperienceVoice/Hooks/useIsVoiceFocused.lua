-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T02:11:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CrossExperienceVoice = script:FindFirstAncestor("CrossExperienceVoice")
local AUDIO_FOCUS_MANAGEMENT = require(CrossExperienceVoice.dependencies).CrossExperience.Constants.AUDIO_FOCUS_MANAGEMENT
local useAudioCurrentContextId = require(CrossExperienceVoice.Hooks.useAudioCurrentContextId)

local CONTEXT_ID = AUDIO_FOCUS_MANAGEMENT.CEV.CONTEXT_ID

return function(): boolean
    return useAudioCurrentContextId() == CONTEXT_ID
end
