-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T02:10:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CrossExperienceVoice = script:FindFirstAncestor("CrossExperienceVoice")

local useBackgroundExperience = require(CrossExperienceVoice.Hooks.useBackgroundExperience)

return function(): boolean
    local var1 = useBackgroundExperience()
    local jobId = var1 and var1.jobId
    return not (jobId == nil) and jobId ~= ""
end
