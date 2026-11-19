-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T16:11:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GetFFlagEnableCrossExpVoice = require(script.Parent.GetFFlagEnableCrossExpVoice)

return function()
    return GetFFlagEnableCrossExpVoice() and game:GetEngineFeature("CrossExperienceVoiceMuteAll")
end
