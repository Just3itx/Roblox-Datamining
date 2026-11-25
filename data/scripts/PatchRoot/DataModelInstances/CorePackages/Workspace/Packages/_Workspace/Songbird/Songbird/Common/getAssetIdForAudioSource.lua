-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T16:51:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function getAssetIdForAudioSource(arg1): number?
    return tonumber(
        ((if arg1:IsA("Sound") then arg1.SoundId elseif arg1:IsA("AudioPlayer") then arg1.Asset else nil):match(
            "rbxassetid://(.+)"
        ))
    )
end

return getAssetIdForAudioSource
