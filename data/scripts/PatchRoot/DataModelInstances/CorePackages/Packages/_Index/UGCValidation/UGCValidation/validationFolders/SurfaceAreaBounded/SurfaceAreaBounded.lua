-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:11:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UGCValidationService = game:GetService("UGCValidationService")

local scriptParentParentParent = script.Parent.Parent.Parent

local _Types = require(scriptParentParentParent.util.Types)
local ValidationEnums = require(scriptParentParentParent.validationSystem.ValidationEnums)
local ErrorSourceStrings = require(scriptParentParentParent.validationSystem.ErrorSourceStrings)

local getFIntMaxTotalSurfaceArea = require(scriptParentParentParent.flags.getFIntMaxTotalSurfaceArea)
local module = {
    categories = {
        ValidationEnums.UploadCategory.LAYERED_CLOTHING,
        ValidationEnums.UploadCategory.EYEBROW_EYELASH,
        ValidationEnums.UploadCategory.RIGID_ACCESSORY,
        ValidationEnums.UploadCategory.TORSO_AND_LIMBS,
        ValidationEnums.UploadCategory.DYNAMIC_HEAD
    },
    requiredData = { ValidationEnums.SharedDataMember.renderMeshesData },
    expectedFailures = {}
}
function module.run(arg1, arg2)
    for meshName, value2 in arg2.renderMeshesData do
        local num1 = UGCValidationService:CalculateEditableMeshTotalSurfaceArea(value2.editable, value2.scale)

        if not (getFIntMaxTotalSurfaceArea() < num1) then
            continue
        end

        local meshGeometrySurfaceAreaExceeded = ErrorSourceStrings.Keys.MeshGeometry_SurfaceAreaExceeded
        local tbl1 = {
            meshName = meshName,
            surfaceArea = string.format("%.2f", num1),
            maxSurfaceArea = tostring(getFIntMaxTotalSurfaceArea())
        }
        arg1:fail(meshGeometrySurfaceAreaExceeded, tbl1)
    end
end

return module
