-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T14:31:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SceneUnderstanding = script:FindFirstAncestor("SceneUnderstanding")

local UserGameSettings = UserSettings():GetService("UserGameSettings")

local safelyAccessProperty = require(SceneUnderstanding.safelyAccessProperty)

local function getAudibleVolume(arg1)
    if not arg1.IsPlaying then
        return 0
    end

    local var1 = safelyAccessProperty(UserGameSettings, "MasterVolume", 0)
    local var2 = safelyAccessProperty(arg1, "RollOffGain", 0)

    return var1 * (if arg1.SoundGroup then arg1.SoundGroup.Volume else 1) * arg1.Volume * var2
end

return getAudibleVolume
