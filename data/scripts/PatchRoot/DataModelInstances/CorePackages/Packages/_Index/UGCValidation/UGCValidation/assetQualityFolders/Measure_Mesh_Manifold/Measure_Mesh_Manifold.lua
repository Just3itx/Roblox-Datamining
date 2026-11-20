-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T16:21:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local _Types = require(scriptParentParentParent.util.Types)
local ValidationEnums = require(scriptParentParentParent.validationSystem.ValidationEnums)
local ErrorSourceStrings = require(scriptParentParentParent.validationSystem.ErrorSourceStrings)

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
    local measureMeshManifold = arg2.aqsSummaryData.Measure_Mesh_Manifold
    if measureMeshManifold == nil then
        arg1:warn(ErrorSourceStrings.Keys.AQSWarn_MissingData, { measureName = "Measure_Mesh_Manifold" })

        return
    end
    for partName, value2 in measureMeshManifold do
        if partName == "measurement_score" then
            continue
        end

        if value2 == nil or value2.score == nil then
            arg1:warn(ErrorSourceStrings.Keys.AQSWarn_MissingData, { measureName = "Measure_Mesh_Manifold" })

            return
        end
        if tonumber(value2.score) ~= 100 then
            arg1:warn(ErrorSourceStrings.Keys.AQSWarn_MeshManifold, { partName = partName })
        end
    end
end

return module
