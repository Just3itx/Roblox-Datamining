-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T03:01:29Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SoundService = game:GetService("SoundService")

local function enableAudioPlaybackInApp()
    if game:GetEngineFeature("SoundServiceSetSoundEnabled") then
        SoundService:SetSoundEnabled(true)
    end
end

return enableAudioPlaybackInApp
