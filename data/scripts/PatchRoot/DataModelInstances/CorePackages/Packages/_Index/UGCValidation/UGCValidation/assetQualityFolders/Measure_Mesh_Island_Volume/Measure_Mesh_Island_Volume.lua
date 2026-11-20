-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T16:21:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local _Types = require(scriptParentParentParent.util.Types)
local ValidationEnums = require(scriptParentParentParent.validationSystem.ValidationEnums)
local ErrorSourceStrings = require(scriptParentParentParent.validationSystem.ErrorSourceStrings)
local getFFlagUGCValidateAQMeshQualityBlockUpload = require(scriptParentParentParent.flags.getFFlagUGCValidateAQMeshQualityBlockUpload)

local num1 = game:DefineFastInt("UGCValidationMeshIslandVolumeMaxComponents", 10)

local module = {
    categories = { ValidationEnums.UploadCategory.FULL_BODY, ValidationEnums.UploadCategory.DYNAMIC_HEAD },
    fflag = require(scriptParentParentParent.flags.getFFlagUGCValidateAQMeshIslandVolume)
}
function module.run(arg1, arg2)
    local measureMeshIslandVolume = arg2.aqsSummaryData.Measure_Mesh_Island_Volume
    if measureMeshIslandVolume == nil then
        if getFFlagUGCValidateAQMeshQualityBlockUpload() then
            error("Measure_Mesh_Island_Volume: AQS summary data is nil")
            return
        end
        arg1:warn(ErrorSourceStrings.Keys.AQSWarn_MissingData, { measureName = "Measure_Mesh_Island_Volume" })

        return
    end
    for partName, value2 in measureMeshIslandVolume do
        if partName == "measurement_score" then
            continue
        end

        if value2 == nil or value2.score == nil then
            arg1:warn(ErrorSourceStrings.Keys.AQSWarn_MissingData, { measureName = "Measure_Mesh_Island_Volume" })

            return
        end

        local num2 = tonumber(value2.num_disconnected_components) or 0
        if num1 < num2 then
            local tbl1 = {
                partName = partName,
                num_disconnected_components = tostring(num2),
                max_disconnected_components = tostring(num1)
            }
            if getFFlagUGCValidateAQMeshQualityBlockUpload() then
                arg1:fail(ErrorSourceStrings.Keys.AQSFail_TooManyDisconnectedComponents, tbl1)
            else
                arg1:warn(ErrorSourceStrings.Keys.AQSFail_TooManyDisconnectedComponents, tbl1)
            end
        end

        if tonumber(value2.score) == 100 then
            continue
        end

        local tbl1 = {
            partName = partName,
            num_small_volume_islands = value2.num_small_volume_islands or "unknown",
            num_disconnected_components = value2.num_disconnected_components or "unknown"
        }
        if getFFlagUGCValidateAQMeshQualityBlockUpload() then
            arg1:fail(ErrorSourceStrings.Keys.AQSWarn_MeshIslandVolume, tbl1)
        else
            arg1:warn(ErrorSourceStrings.Keys.AQSWarn_MeshIslandVolume, tbl1)
        end
    end
end

return module
