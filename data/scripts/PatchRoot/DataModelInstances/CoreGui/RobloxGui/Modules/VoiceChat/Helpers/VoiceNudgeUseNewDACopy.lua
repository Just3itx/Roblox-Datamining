-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T01:31:38Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local IXPService = game:GetService("IXPService")

local CorePackages = game:GetService("CorePackages")
local var1 = require(CorePackages.Workspace.Packages.CoreScriptsInitializer).CoreLogger:new(script.Name)

local GetFFlagVoiceChatDisruptiveVoiceNudgeForceUseNewDACopy = require(script.Parent.Parent.Flags.GetFFlagVoiceChatDisruptiveVoiceNudgeForceUseNewDACopy)

local layerName = game:DefineFastString("DisruptiveVoiceNudgeVariantIXPLayerName", "Voice.CivilityAndSafety")
local str1 = game:DefineFastString("DisruptiveVoiceNudgeVariantIXPVariableName", "UseNewDACopy")

local function VoiceNudgeUseNewDACopy()
    if GetFFlagVoiceChatDisruptiveVoiceNudgeForceUseNewDACopy() then
        return true
    end
    local success, result = pcall(function()
        return IXPService:GetUserLayerVariables(layerName)
    end)
    if not success or not result or result[str1] == nil then
        var1:debug("Failed to get IXP data for layer: " .. layerName .. " with variable: " .. str1)
        return false
    end
    IXPService:LogUserLayerExposure(layerName)
    var1:debug("Experiment variant for " .. str1 .. ": " .. tostring(result[str1]))
    return result[str1]
end

return VoiceNudgeUseNewDACopy
