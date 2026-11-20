-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T16:21:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local _Types = require(scriptParentParentParent.util.Types)
local ValidationEnums = require(scriptParentParentParent.validationSystem.ValidationEnums)
local ErrorSourceStrings = require(scriptParentParentParent.validationSystem.ErrorSourceStrings)
local getFFlagUGCValidateAQMeshQualityBlockUpload = require(scriptParentParentParent.flags.getFFlagUGCValidateAQMeshQualityBlockUpload)

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
    local measureUvBound = arg2.aqsSummaryData.Measure_UV_Bound
    if measureUvBound == nil then
        if getFFlagUGCValidateAQMeshQualityBlockUpload() then
            error("Measure_UV_Bound: AQS summary data is nil")
            return
        end
        arg1:warn(ErrorSourceStrings.Keys.AQSWarn_MissingData, { measureName = "Measure_UV_Bound" })

        return
    end
    for partName, value2 in measureUvBound do
        if partName == "measurement_score" then
            continue
        end

        if value2 == nil or value2.score == nil then
            arg1:warn(ErrorSourceStrings.Keys.AQSWarn_MissingData, { measureName = "Measure_UV_Bound" })

            return
        end
        if tonumber(value2.score) == 100 then
            continue
        end

        local tbl1 = {
            partName = partName,
            uv_outside_bound_vert_percent = string.format("%.2f", (tonumber(value2.uv_outside_bound_vert_percent) or 0) * 100)
        }

        if getFFlagUGCValidateAQMeshQualityBlockUpload() then
            arg1:fail(ErrorSourceStrings.Keys.AQSWarn_UVBound, tbl1)
        else
            arg1:warn(ErrorSourceStrings.Keys.AQSWarn_UVBound, tbl1)
        end
    end
end

return module
