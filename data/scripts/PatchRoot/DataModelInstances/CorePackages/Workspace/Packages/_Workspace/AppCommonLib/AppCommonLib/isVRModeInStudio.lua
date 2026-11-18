-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-18T23:05:58Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
game:DefineFastFlag("DebugVRModeInStudio", false)

local function isVRModeInStudio()
    return game:GetFastFlag("DebugVRModeInStudio") and UserSettings().GameSettings:InStudioMode()
end

return isVRModeInStudio
