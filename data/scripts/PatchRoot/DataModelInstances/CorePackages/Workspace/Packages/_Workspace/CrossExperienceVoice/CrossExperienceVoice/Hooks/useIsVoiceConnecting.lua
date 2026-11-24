-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T02:11:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CrossExperienceVoice = script:FindFirstAncestor("CrossExperienceVoice")
local Constants = require(CrossExperienceVoice.dependencies).CrossExperience.Constants
local useVoiceStatus = require(CrossExperienceVoice.Hooks.useVoiceStatus)

return function(): boolean
    local var1 = useVoiceStatus()
    return var1 == Constants.VOICE_STATUS.RCC_CONNECTING
        or var1 == Constants.VOICE_STATUS.RCC_CONNECTED
        or var1 == Constants.VOICE_STATUS.RCC_RECONNECTING
        or var1 == Constants.VOICE_STATUS.VOICE_RECONNECTING
        or var1 == Constants.VOICE_STATUS.VOICE_CONNECTING
end
