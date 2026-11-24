-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T15:40:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExperienceStateCaptureService = game:GetService("ExperienceStateCaptureService")
local IXPService = game:GetService("IXPService")

local GenericAbuseReportingParent = script:FindFirstAncestor("GenericAbuseReporting").Parent
local SharedFlags = require(GenericAbuseReportingParent.SharedFlags)

local FStringReportMenuIXPLayer = SharedFlags.FStringReportMenuIXPLayer
local FStringSelectInSceneIXPField = SharedFlags.FStringSelectInSceneIXPField

local function isInSelectInSceneExperiment() -- Luacid: Inlined by compiler; 1 call site recovered
    local success, result = pcall(function()
        return IXPService:GetUserLayerVariables(FStringReportMenuIXPLayer)
    end)
    if not success or not result or result[FStringSelectInSceneIXPField] == nil then
        return false
    end

    IXPService:LogUserLayerExposure(FStringReportMenuIXPLayer)
    return result[FStringSelectInSceneIXPField]
end

local function getIsInExpSceneSelectionAvailable()
    if not game:GetEngineFeature("SafetyServiceCaptureModeReportProp")
        or not game:GetEngineFeature("CaptureModeEnabled")
        or not game:GetEngineFeature("ExperienceStateCaptureHiddenSelection")
        or game:GetEngineFeature("ExperienceStateCaptureMinMemEnabled") and not ExperienceStateCaptureService:CanEnterCaptureMode()
    then
        return false
    end

    return isInSelectInSceneExperiment()
end

return getIsInExpSceneSelectionAvailable
