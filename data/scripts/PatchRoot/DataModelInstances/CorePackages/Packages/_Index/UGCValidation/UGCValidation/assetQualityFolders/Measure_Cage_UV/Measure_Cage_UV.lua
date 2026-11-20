-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T16:21:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local _Types = require(scriptParentParentParent.util.Types)
local ValidationEnums = require(scriptParentParentParent.validationSystem.ValidationEnums)
local ErrorSourceStrings = require(scriptParentParentParent.validationSystem.ErrorSourceStrings)
local getFFlagUGCValidateAQScoreWarnings = require(scriptParentParentParent.flags.getFFlagUGCValidateAQScoreWarnings)
local getFFlagUGCValidateLCCageUVScoreCheck = require(scriptParentParentParent.flags.getFFlagUGCValidateLCCageUVScoreCheck)

local num1 = game:DefineFastInt("UGCValidateLCCagingIncorrectUVThreshold", 100)
local num2 = game:DefineFastInt("UGCValidateLCCageUVMinScore", 90)

local module = {
    categories = { ValidationEnums.UploadCategory.LAYERED_CLOTHING, ValidationEnums.UploadCategory.EYEBROW_EYELASH }
}

local tbl1 = { "Handle_InnerCage", "Handle_OuterCage" }

function module.run(arg1, arg2)
    local measureCageUv = arg2.aqsSummaryData.Measure_Cage_UV
    if measureCageUv == nil then
        error("Measure_Cage_UV: AQS summary data is nil")
    end

    local bool1 = arg2.uploadCategory == ValidationEnums.UploadCategory.EYEBROW_EYELASH
    local var1 = getFFlagUGCValidateLCCageUVScoreCheck() and not bool1
    for _, cageName in tbl1 do
        if measureCageUv[cageName] == nil or measureCageUv[cageName].incorrect_uv_count == nil then
            error("Measure_Cage_UV: AQS summary missing required fields for cage " .. cageName)
        else
            local score = measureCageUv[cageName].score
            local var2 = if score == nil then nil else tonumber(score)
            local incorrectUvCount = tonumber(measureCageUv[cageName].incorrect_uv_count) or 0
            local unreferencedVertexCount = measureCageUv[cageName].unreferenced_vertex_count or "0"
            local nonTemplateUvCount = measureCageUv[cageName].non_template_uv_count or "0"
            local unmatchedTemplateCount = measureCageUv[cageName].unmatched_template_count or "0"
            local duplicateMappingCount = measureCageUv[cageName].duplicate_mapping_count or "0"

            if var1 then
                if var2 == nil then
                    error("Measure_Cage_UV: AQS summary missing score for cage " .. cageName)
                elseif var2 < num2 then
                    local aqsFailCageUv = ErrorSourceStrings.Keys.AQSFail_CageUV
                    local tbl2 = {
                        cage_name = cageName,
                        incorrect_uv_count = tostring(incorrectUvCount),
                        unreferenced_vertex_count = unreferencedVertexCount,
                        non_template_uv_count = nonTemplateUvCount,
                        unmatched_template_count = unmatchedTemplateCount,
                        duplicate_mapping_count = duplicateMappingCount
                    }
                    arg1:fail(aqsFailCageUv, tbl2)
                elseif getFFlagUGCValidateAQScoreWarnings() and var2 ~= 100 then
                    local aqsWarnCageUv = ErrorSourceStrings.Keys.AQSWarn_CageUV
                    local tbl2 = {
                        cage_name = cageName,
                        incorrect_uv_count = tostring(incorrectUvCount),
                        unreferenced_vertex_count = unreferencedVertexCount,
                        non_template_uv_count = nonTemplateUvCount,
                        unmatched_template_count = unmatchedTemplateCount,
                        duplicate_mapping_count = duplicateMappingCount
                    }
                    arg1:warn(aqsWarnCageUv, tbl2)
                end
            else
                if num1 < incorrectUvCount then
                    arg1:fail(ErrorSourceStrings.Keys.MeasureCageUV, { cage_name = cageName, incorrect_uv_count = incorrectUvCount })
                end

                if getFFlagUGCValidateAQScoreWarnings() and not bool1 and var2 ~= nil and var2 ~= 100 then
                    local aqsWarnCageUv = ErrorSourceStrings.Keys.AQSWarn_CageUV
                    local tbl2 = {
                        cage_name = cageName,
                        incorrect_uv_count = tostring(incorrectUvCount),
                        unreferenced_vertex_count = unreferencedVertexCount,
                        non_template_uv_count = nonTemplateUvCount,
                        unmatched_template_count = unmatchedTemplateCount,
                        duplicate_mapping_count = duplicateMappingCount
                    }
                    arg1:warn(aqsWarnCageUv, tbl2)
                end
            end
        end
    end
end

return module
