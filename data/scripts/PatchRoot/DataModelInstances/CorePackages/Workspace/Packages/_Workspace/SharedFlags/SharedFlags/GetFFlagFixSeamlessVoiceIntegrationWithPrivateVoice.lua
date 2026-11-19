-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T03:31:12Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
game:DefineFastFlag("FixSeamlessVoiceIntegrationWithPrivateVoice2", false)

local GetFFlagEnableCrossExpVoice = require(script.Parent.GetFFlagEnableCrossExpVoice)

return function()
    return GetFFlagEnableCrossExpVoice() and game:GetFastFlag("FixSeamlessVoiceIntegrationWithPrivateVoice2")
end
