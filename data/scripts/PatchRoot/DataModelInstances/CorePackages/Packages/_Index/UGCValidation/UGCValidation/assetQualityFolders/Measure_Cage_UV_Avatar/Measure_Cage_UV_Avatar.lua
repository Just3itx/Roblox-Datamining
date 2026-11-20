-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T16:21:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local _Types = require(scriptParentParentParent.util.Types)
local ValidationEnums = require(scriptParentParentParent.validationSystem.ValidationEnums)
local ErrorSourceStrings = require(scriptParentParentParent.validationSystem.ErrorSourceStrings)
local Constants = require(scriptParentParentParent.Constants)
local getFFlagUGCValidateAQScoreWarnings = require(scriptParentParentParent.flags.getFFlagUGCValidateAQScoreWarnings)
local getFFlagUGCValidateLCCageUVScoreCheck = require(scriptParentParentParent.flags.getFFlagUGCValidateLCCageUVScoreCheck)

local num1 = game:DefineFastInt("UGCValidateLCCagingIncorrectUVThresholdBodyPart", 7)
local num2 = game:DefineFastInt("UGCValidateLCCageUVAvatarMinScore", 95)

local module = {
    categories = { ValidationEnums.UploadCategory.FULL_BODY }
}
function module.run(arg1, arg2)
    local measureCageUvAvatar = arg2.aqsSummaryData.Measure_Cage_UV_Avatar
    if measureCageUvAvatar == nil then
        error("Measure_Cage_UV_Avatar: AQS summary data is nil")
    end
    local fFlagUgcValidateLcCageUvScoreCheck = getFFlagUGCValidateLCCageUVScoreCheck()
    for _, cageName in Constants.R15_CAGE_PARTS do
        if measureCageUvAvatar[cageName] == nil or measureCageUvAvatar[cageName].incorrect_uv_count == nil then
            error("Measure_Cage_UV_Avatar: AQS summary missing required fields for cage " .. cageName)
        else
            local score = measureCageUvAvatar[cageName].score
            local var1 = if score == nil then nil else tonumber(score)
            local incorrectUvCount = tonumber(measureCageUvAvatar[cageName].incorrect_uv_count) or 0
            local unreferencedVertexCount = measureCageUvAvatar[cageName].unreferenced_vertex_count or "0"
            local nonTemplateUvCount = measureCageUvAvatar[cageName].non_template_uv_count or "0"
            local unmatchedTemplateCount = measureCageUvAvatar[cageName].unmatched_template_count or "0"
            local duplicateMappingCount = measureCageUvAvatar[cageName].duplicate_mapping_count or "0"

            if fFlagUgcValidateLcCageUvScoreCheck then
                if var1 == nil then
                    error("Measure_Cage_UV_Avatar: AQS summary missing score for cage " .. cageName)
                elseif var1 < num2 then
                    local aqsFailCageUv = ErrorSourceStrings.Keys.AQSFail_CageUV
                    local tbl1 = {
                        cage_name = cageName,
                        incorrect_uv_count = tostring(incorrectUvCount),
                        unreferenced_vertex_count = unreferencedVertexCount,
                        non_template_uv_count = nonTemplateUvCount,
                        unmatched_template_count = unmatchedTemplateCount,
                        duplicate_mapping_count = duplicateMappingCount
                    }
                    arg1:fail(aqsFailCageUv, tbl1)
                elseif getFFlagUGCValidateAQScoreWarnings() and var1 ~= 100 then
                    local aqsWarnCageUv = ErrorSourceStrings.Keys.AQSWarn_CageUV
                    local tbl1 = {
                        cage_name = cageName,
                        incorrect_uv_count = tostring(incorrectUvCount),
                        unreferenced_vertex_count = unreferencedVertexCount,
                        non_template_uv_count = nonTemplateUvCount,
                        unmatched_template_count = unmatchedTemplateCount,
                        duplicate_mapping_count = duplicateMappingCount
                    }
                    arg1:warn(aqsWarnCageUv, tbl1)
                end
            else
                if num1 < incorrectUvCount then
                    arg1:fail(ErrorSourceStrings.Keys.MeasureCageUV, { cage_name = cageName, incorrect_uv_count = incorrectUvCount })
                end

                if getFFlagUGCValidateAQScoreWarnings() and var1 ~= nil and var1 ~= 100 then
                    local aqsWarnCageUv = ErrorSourceStrings.Keys.AQSWarn_CageUV
                    local tbl1 = {
                        cage_name = cageName,
                        incorrect_uv_count = tostring(incorrectUvCount),
                        unreferenced_vertex_count = unreferencedVertexCount,
                        non_template_uv_count = nonTemplateUvCount,
                        unmatched_template_count = unmatchedTemplateCount,
                        duplicate_mapping_count = duplicateMappingCount
                    }
                    arg1:warn(aqsWarnCageUv, tbl1)
                end
            end
        end
    end
end

return module
