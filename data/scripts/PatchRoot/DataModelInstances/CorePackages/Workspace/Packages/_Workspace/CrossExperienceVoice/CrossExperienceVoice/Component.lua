-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T02:01:28Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CrossExperienceVoice = script:FindFirstAncestor("CrossExperienceVoice")

local useCrossExperienceVoice = require(CrossExperienceVoice.Hooks.useCrossExperienceVoice)
local FFlagEnableCEVForceInitialize = require(CrossExperienceVoice.Flags).FFlagEnableCEVForceInitialize

local function CrossExperienceVoiceComponent()
    useCrossExperienceVoice(
        {
            handleRCCConnectionTimeout = nil,
            forceInitializeStoreOnMount = if FFlagEnableCEVForceInitialize then true else nil
        }
    )
    return nil
end

return CrossExperienceVoiceComponent
