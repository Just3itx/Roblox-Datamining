-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T02:11:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CrossExperienceVoice = script:FindFirstAncestor("CrossExperienceVoice")
local Utils = require(CrossExperienceVoice.dependencies).CrossExperience.Utils
local useVoiceStatus = require(CrossExperienceVoice.Hooks.useVoiceStatus)

return function()
    local var1 = useVoiceStatus()
    if var1 == nil then
        return false
    end

    return (Utils.VoiceStatus.isVoiceRetriableError(var1))
end
