-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T16:21:10Z
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
    local measureDegenTriangles = arg2.aqsSummaryData.Measure_Degen_Triangles
    local var1 = getFFlagUGCValidateAQMeshQualityBlockUpload() and tbl1[arg2.uploadCategory]
    if measureDegenTriangles == nil then
        if var1 then
            error("Measure_Degen_Triangles: AQS summary data is nil")
            return
        end
        arg1:warn(ErrorSourceStrings.Keys.AQSWarn_MissingData, { measureName = "Measure_Degen_Triangles" })

        return
    end
    for partName, value2 in measureDegenTriangles do
        if partName == "measurement_score" then
            continue
        end

        if value2 == nil or value2.score == nil then
            arg1:warn(ErrorSourceStrings.Keys.AQSWarn_MissingData, { measureName = "Measure_Degen_Triangles" })

            return
        end
        if tonumber(value2.score) == 100 then
            continue
        end

        local tbl2 = {
            partName = partName,
            degenerate_triangle_percent = string.format("%.2f", (tonumber(value2.degenerate_triangle_percent) or 0) * 100)
        }

        if var1 then
            arg1:fail(ErrorSourceStrings.Keys.AQSWarn_DegenTriangles, tbl2)
        else
            arg1:warn(ErrorSourceStrings.Keys.AQSWarn_DegenTriangles, tbl2)
        end
    end
end

return module
