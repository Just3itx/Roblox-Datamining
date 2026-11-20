-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T16:21:20Z
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
    local measureMeshWatertight = arg2.aqsSummaryData.Measure_Mesh_Watertight
    if measureMeshWatertight == nil then
        arg1:warn(ErrorSourceStrings.Keys.AQSWarn_MissingData, { measureName = "Measure_Mesh_Watertight" })

        return
    end
    local tbl1 = { Head = true, Head_Geo = true, Head_OuterCage = true }
    for partName, value2 in measureMeshWatertight do
        if partName == "measurement_score" then
            continue
        end

        if value2 == nil or value2.boundary_edges_percent == nil then
            arg1:warn(ErrorSourceStrings.Keys.AQSWarn_MissingData, { measureName = "Measure_Mesh_Watertight" })

            return
        end
        if tbl1[partName] or not ((tonumber(value2.boundary_edges_percent) or 0) > 0) then
            continue
        end

        local aqsWarnMeshNotWatertight = ErrorSourceStrings.Keys.AQSWarn_MeshNotWatertight
        local tbl2 = {
            partName = partName,
            boundary_edges_percent = string.format("%.2f", (tonumber(value2.boundary_edges_percent) or 0) * 100)
        }
        arg1:warn(aqsWarnMeshNotWatertight, tbl2)
    end
end

return module
