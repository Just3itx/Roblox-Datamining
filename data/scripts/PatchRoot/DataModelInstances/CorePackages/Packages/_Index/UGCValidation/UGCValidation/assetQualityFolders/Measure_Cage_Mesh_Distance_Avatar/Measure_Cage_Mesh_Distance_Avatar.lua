-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T16:21:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local _Types = require(scriptParentParentParent.util.Types)
local ValidationEnums = require(scriptParentParentParent.validationSystem.ValidationEnums)
local ErrorSourceStrings = require(scriptParentParentParent.validationSystem.ErrorSourceStrings)

local num1 = game:DefineFastInt("UGCValidationCageMeshDistanceMaxCageMeshDistanceAvatar", 60)
local num2 = game:DefineFastInt("UGCValidationCageMeshDistanceMaxNegativeSDFThresholdAvatar", 30)

local getFFlagUGCValidateAQScoreWarnings = require(scriptParentParentParent.flags.getFFlagUGCValidateAQScoreWarnings)

local module = {
    categories = { ValidationEnums.UploadCategory.FULL_BODY }
}
function module.run(arg1, arg2)
    local fullBodyCage = arg2.aqsSummaryData.Measure_Cage_Mesh_Distance_Avatar.full_body_cage
    if fullBodyCage == nil or fullBodyCage.max_distance == nil or fullBodyCage.negative_sdf_percent == nil then
        error("Measure_Cage_Mesh_Distance_Avatar: AQS summary missing required fields")
        return
    end
    if tonumber(fullBodyCage.max_distance) > num1 / 100 then
        local measureCageMeshDistanceAvatarCageTooFar = ErrorSourceStrings.Keys.MeasureCageMeshDistanceAvatar_CageTooFar
        local tbl1 = {
            max_sdf = tonumber(fullBodyCage.max_distance),
            max_sdf_threshold = num1 / 100
        }
        arg1:fail(measureCageMeshDistanceAvatarCageTooFar, tbl1)
    end

    if tonumber(fullBodyCage.negative_sdf_percent) * 100 > num2 then
        local measureCageMeshDistanceAvatarCageInsideMesh = ErrorSourceStrings.Keys.MeasureCageMeshDistanceAvatar_CageInsideMesh
        local tbl1 = {
            negtiveSDFPercent = string.format("%.2f", tonumber(fullBodyCage.negative_sdf_percent) * 100)
        }
        arg1:fail(measureCageMeshDistanceAvatarCageInsideMesh, tbl1)
    end

    if not getFFlagUGCValidateAQScoreWarnings() or fullBodyCage.score == nil or tonumber(fullBodyCage.score) == 100 then
        return
    end

    local aqsWarnCageMeshDistanceAvatar = ErrorSourceStrings.Keys.AQSWarn_CageMeshDistanceAvatar
    local tbl1 = {
        max_distance = fullBodyCage.max_distance or "unknown",
        negative_sdf_percent = string.format("%.2f", (tonumber(fullBodyCage.negative_sdf_percent) or 0) * 100)
    }
    arg1:warn(aqsWarnCageMeshDistanceAvatar, tbl1)
end

return module
