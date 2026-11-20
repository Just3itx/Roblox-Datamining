-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T16:21:27Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local _Types = require(scriptParentParentParent.util.Types)
local ValidationEnums = require(scriptParentParentParent.validationSystem.ValidationEnums)
local ErrorSourceStrings = require(scriptParentParentParent.validationSystem.ErrorSourceStrings)
local getFFlagUGCValidateAQMeshQualityBlockUpload = require(scriptParentParentParent.flags.getFFlagUGCValidateAQMeshQualityBlockUpload)

local tbl1 = {
    [ValidationEnums.UploadCategory.FULL_BODY] = true,
    [ValidationEnums.UploadCategory.DYNAMIC_HEAD] = true
}

local num1 = game:DefineFastInt("UGCValidationVertexSimilarityMaxPercent", 30)

local module = {
    categories = {
        ValidationEnums.UploadCategory.LAYERED_CLOTHING,
        ValidationEnums.UploadCategory.EYEBROW_EYELASH,
        ValidationEnums.UploadCategory.FULL_BODY,
        ValidationEnums.UploadCategory.RIGID_ACCESSORY,
        ValidationEnums.UploadCategory.DYNAMIC_HEAD
    },
    fflag = require(scriptParentParentParent.flags.getFFlagUGCValidateAQMeshQuality)
}
function module.run(arg1, arg2)
    local measureVertexSimilarity = arg2.aqsSummaryData.Measure_Vertex_Similarity
    local var1 = getFFlagUGCValidateAQMeshQualityBlockUpload() and tbl1[arg2.uploadCategory]
    if measureVertexSimilarity == nil then
        if var1 then
            error("Measure_Vertex_Similarity: AQS summary data is nil")
            return
        end
        arg1:warn(ErrorSourceStrings.Keys.AQSWarn_MissingData, { measureName = "Measure_Vertex_Similarity" })

        return
    end

    local num2 = num1 / 100

    for partName, value2 in measureVertexSimilarity do
        if partName == "measurement_score" then
            continue
        end

        if value2 == nil or value2.similar_vertex_percent == nil then
            arg1:warn(ErrorSourceStrings.Keys.AQSWarn_MissingData, { measureName = "Measure_Vertex_Similarity" })

            return
        end

        local num3 = tonumber(value2.similar_vertex_percent) or 0
        if not (num2 < num3) then
            continue
        end

        local tbl2 = {
            partName = partName,
            similar_vertex_percent = string.format("%.2f", num3 * 100),
            threshold = tostring(num1)
        }
        if var1 then
            arg1:fail(ErrorSourceStrings.Keys.AQSWarn_VertexSimilarity, tbl2)
        else
            arg1:warn(ErrorSourceStrings.Keys.AQSWarn_VertexSimilarity, tbl2)
        end
    end
end

return module
