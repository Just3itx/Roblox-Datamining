-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T16:21:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local _Types = require(scriptParentParentParent.util.Types)
local ValidationEnums = require(scriptParentParentParent.validationSystem.ValidationEnums)
local ErrorSourceStrings = require(scriptParentParentParent.validationSystem.ErrorSourceStrings)

local getFFlagUGCValidateAQScoreWarnings = require(scriptParentParentParent.flags.getFFlagUGCValidateAQScoreWarnings)

local num1 = game:DefineFastInt("UGCMinCageRelevancyThreshold", 10)

local module = {
    categories = { ValidationEnums.UploadCategory.LAYERED_CLOTHING, ValidationEnums.UploadCategory.EYEBROW_EYELASH }
}

function module.run(arg1, arg2)
    local handleOuterCage = arg2.aqsSummaryData.Measure_Cage_Relevancy.Handle_OuterCage
    local var1 = handleOuterCage and tonumber(handleOuterCage.outer_cage_face_relevant_percent)

    if var1 == nil then
        error("Measure_Cage_Relevancy: AQS summary missing required fields")
        return
    end
    if var1 * 100 < num1 then
        arg1:fail(
            ErrorSourceStrings.Keys.MeasureCageRelevancy,
            {
                outer_cage_face_irrelevant_percent = string.format("%.2f", 100 - var1 * 100)
            }
        )
    end

    if not getFFlagUGCValidateAQScoreWarnings() or handleOuterCage.score == nil or tonumber(handleOuterCage.score) == 100 then
        return
    end

    local aqsWarnCageRelevancy = ErrorSourceStrings.Keys.AQSWarn_CageRelevancy
    local tbl1 = {
        irrelevant_percent = string.format("%.2f", 100 - (tonumber(handleOuterCage.outer_cage_face_relevant_percent) or 0) * 100)
    }
    arg1:warn(aqsWarnCageRelevancy, tbl1)
end

return module
