-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T16:21:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local _Types = require(scriptParentParentParent.util.Types)
local ValidationEnums = require(scriptParentParentParent.validationSystem.ValidationEnums)
local ErrorSourceStrings = require(scriptParentParentParent.validationSystem.ErrorSourceStrings)

local num1 = game:DefineFastInt("UGCValidationCageMeshDistanceHeadMaxCageMeshDistance", 60)
local num2 = game:DefineFastInt("UGCValidationCageMeshDistanceHeadMaxNegativeSDFThreshold", 30)

local getFFlagUGCValidateAQScoreWarnings = require(scriptParentParentParent.flags.getFFlagUGCValidateAQScoreWarnings)

local module = {
    categories = { ValidationEnums.UploadCategory.DYNAMIC_HEAD },
    fflag = require(scriptParentParentParent.flags.getFFlagUGCValidateCageMeshDistanceHead)
}
function module.run(arg1, arg2)
    local headOuterCage = arg2.aqsSummaryData.Measure_Cage_Distance_Head.Head_OuterCage
    if headOuterCage == nil or headOuterCage.max_distance == nil or headOuterCage.negative_sdf_percent == nil then
        error("Measure_Cage_Distance_Head: AQS summary missing required fields")
        return
    end
    if tonumber(headOuterCage.max_distance) > num1 / 100 then
        local measureCageMeshDistanceHeadCageTooFar = ErrorSourceStrings.Keys.MeasureCageMeshDistanceHead_CageTooFar
        local tbl1 = {
            max_sdf = tonumber(headOuterCage.max_distance),
            max_sdf_threshold = num1 / 100
        }
        arg1:fail(measureCageMeshDistanceHeadCageTooFar, tbl1)
    end

    if tonumber(headOuterCage.negative_sdf_percent) * 100 > num2 then
        local measureCageMeshDistanceHeadCageInsideMesh = ErrorSourceStrings.Keys.MeasureCageMeshDistanceHead_CageInsideMesh
        local tbl1 = {
            negtiveSDFPercent = string.format("%.2f", tonumber(headOuterCage.negative_sdf_percent) * 100)
        }
        arg1:fail(measureCageMeshDistanceHeadCageInsideMesh, tbl1)
    end

    if not getFFlagUGCValidateAQScoreWarnings() or headOuterCage.score == nil or tonumber(headOuterCage.score) == 100 then
        return
    end

    local aqsWarnCageMeshDistanceHead = ErrorSourceStrings.Keys.AQSWarn_CageMeshDistanceHead
    local tbl1 = {
        max_distance = headOuterCage.max_distance or "unknown",
        negative_sdf_percent = string.format("%.2f", (tonumber(headOuterCage.negative_sdf_percent) or 0) * 100)
    }
    arg1:warn(aqsWarnCageMeshDistanceHead, tbl1)
end

return module
