-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T02:11:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CrossExperienceVoice = script:FindFirstAncestor("CrossExperienceVoice")
local Constants = require(CrossExperienceVoice.dependencies).CrossExperience.Constants
local useVoiceStatus = require(CrossExperienceVoice.Hooks.useVoiceStatus)

return function(): boolean
    return useVoiceStatus() == Constants.VOICE_STATUS.VOICE_CONNECTED
end
