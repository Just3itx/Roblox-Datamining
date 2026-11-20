-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T16:21:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local _Types = require(scriptParentParentParent.util.Types)
local ValidationEnums = require(scriptParentParentParent.validationSystem.ValidationEnums)
local ErrorSourceStrings = require(scriptParentParentParent.validationSystem.ErrorSourceStrings)

local num1 = game:DefineFastInt("UGCValidationCageMeshDistanceMaxCageMeshDistanceLC", 60)
local num2 = game:DefineFastInt("UGCValidationCageMeshDistanceMaxNegativeSDFThresholdLC", 30)

local getFFlagUGCValidateAQScoreWarnings = require(scriptParentParentParent.flags.getFFlagUGCValidateAQScoreWarnings)

local module = {
    categories = { ValidationEnums.UploadCategory.LAYERED_CLOTHING, ValidationEnums.UploadCategory.EYEBROW_EYELASH }
}

function module.run(arg1, arg2)
    local handleOuterCage = arg2.aqsSummaryData.Measure_Cage_Mesh_Distance.Handle_OuterCage
    if handleOuterCage == nil or handleOuterCage.max_distance == nil or handleOuterCage.negative_sdf_percent == nil then
        error("Measure_Cage_Mesh_Distance: AQS summary missing required fields")
        return
    end
    if tonumber(handleOuterCage.max_distance) > num1 / 100 then
        local measureCageMeshDistanceCageTooFar = ErrorSourceStrings.Keys.MeasureCageMeshDistance_CageTooFar
        local tbl1 = {
            max_sdf = tonumber(handleOuterCage.max_distance),
            max_sdf_threshold = num1 / 100
        }
        arg1:fail(measureCageMeshDistanceCageTooFar, tbl1)
    end

    if tonumber(handleOuterCage.negative_sdf_percent) * 100 > num2 then
        local measureCageMeshDistanceCageInsideMesh = ErrorSourceStrings.Keys.MeasureCageMeshDistance_CageInsideMesh
        local tbl1 = {
            negtiveSDFPercent = string.format("%.2f", tonumber(handleOuterCage.negative_sdf_percent) * 100)
        }
        arg1:fail(measureCageMeshDistanceCageInsideMesh, tbl1)
    end

    if not getFFlagUGCValidateAQScoreWarnings() or handleOuterCage.score == nil or tonumber(handleOuterCage.score) == 100 then
        return
    end

    local aqsWarnCageMeshDistance = ErrorSourceStrings.Keys.AQSWarn_CageMeshDistance
    local tbl1 = {
        max_distance = handleOuterCage.max_distance or "unknown",
        negative_sdf_percent = string.format("%.2f", (tonumber(handleOuterCage.negative_sdf_percent) or 0) * 100)
    }
    arg1:warn(aqsWarnCageMeshDistance, tbl1)
end

return module
