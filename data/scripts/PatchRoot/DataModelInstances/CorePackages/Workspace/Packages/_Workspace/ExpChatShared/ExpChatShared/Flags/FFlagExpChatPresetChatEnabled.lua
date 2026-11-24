-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T10:21:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserInputService = game:GetService("UserInputService")

local FFlagExpChatPresetChatVREnabled = require(script.Parent.FFlagExpChatPresetChatVREnabled)

local function isSupportedPlatform() -- Luacid: unused: defined but never referenced
    return not UserInputService.VREnabled or FFlagExpChatPresetChatVREnabled
end

local engineFeature = game:DefineFastFlag("ExpChatPresetChatEnabled10", false) and game:GetEngineFeature("TextChatPresetsEnabled")

if engineFeature then
    if UserInputService.VREnabled then
        return FFlagExpChatPresetChatVREnabled
    end

    engineFeature = true
end

return engineFeature
