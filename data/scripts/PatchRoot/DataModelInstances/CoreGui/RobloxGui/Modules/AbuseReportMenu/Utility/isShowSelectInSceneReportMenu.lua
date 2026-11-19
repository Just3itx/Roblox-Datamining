-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T18:01:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local AbuseReportMenu = script:FindFirstAncestor("AbuseReportMenu")
local ExperienceStateCaptureService = game:GetService("ExperienceStateCaptureService")

local Constants = require(AbuseReportMenu.Components.Constants)
local isInSelectInSceneReportMenuOverrideList = require(AbuseReportMenu.Utility.isInSelectInSceneReportMenuOverrideList)

local bool1 = false
task.defer(function()
    bool1 = isInSelectInSceneReportMenuOverrideList()
end)

return function(callback: (...any) -> (...any))
    if not game:GetEngineFeature("SafetyServiceCaptureModeReportProp") then
        return false
    end

    if not game:GetEngineFeature("CaptureModeEnabled") then
        return false
    end

    if game:GetEngineFeature("ExperienceStateCaptureMinMemEnabled") then
        if not ExperienceStateCaptureService:CanEnterCaptureMode() then
            callback({ type = Constants.AnalyticsActions.SetMemoryRequirementMet, memoryRequirementMet = 0 })

            return false
        end
        callback({ type = Constants.AnalyticsActions.SetMemoryRequirementMet, memoryRequirementMet = 1 })
    end

    return if game:GetEngineFeature("ExperienceStateCaptureHiddenSelection") then not bool1 or true else false
end
