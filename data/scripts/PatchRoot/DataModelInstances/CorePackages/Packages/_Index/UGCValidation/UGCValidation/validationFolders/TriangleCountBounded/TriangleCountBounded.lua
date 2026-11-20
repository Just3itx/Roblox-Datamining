-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:11:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UGCValidationService = game:GetService("UGCValidationService")

local scriptParentParentParent = script.Parent.Parent.Parent

local Constants = require(scriptParentParentParent.Constants)
local _Types = require(scriptParentParentParent.util.Types)
local ValidationEnums = require(scriptParentParentParent.validationSystem.ValidationEnums)
local ErrorSourceStrings = require(scriptParentParentParent.validationSystem.ErrorSourceStrings)

local getFIntUGCValidateTriangleLimitTolerance = require(scriptParentParentParent.flags.getFIntUGCValidateTriangleLimitTolerance)
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
local function runAccessoryCheck(arg1, arg2)
    local maxHatTriangles = Constants.MAX_HAT_TRIANGLES

    for meshName, value2 in arg2.renderMeshesData do
        local editableMeshTriCount = UGCValidationService:GetEditableMeshTriCount(value2.editable)

        if not (maxHatTriangles < editableMeshTriCount) then
            continue
        end

        local meshGeometryTriangleCountExceeded = ErrorSourceStrings.Keys.MeshGeometry_TriangleCountExceeded
        local tbl1 = {
            meshName = meshName,
            triangleCount = tostring(editableMeshTriCount),
            maxTriangles = tostring(maxHatTriangles)
        }
        arg1:fail(meshGeometryTriangleCountExceeded, tbl1)
    end
end

local function runBodyPartCheck(arg1, arg2)
    local assetTypeName = arg2.uploadEnum.assetType.Name
    local var1 = Constants.ASSET_RENDER_MESH_MAX_TRIANGLES[assetTypeName]

    if not var1 then
        return
    end

    local num1 = 0
    for _, value in arg2.renderMeshesData do
        num1 += UGCValidationService:GetEditableMeshTriCount(value.editable)
    end

    if not (var1 + var1 * (getFIntUGCValidateTriangleLimitTolerance() / 100) < num1) then
        return
    end

    arg1:fail(
        ErrorSourceStrings.Keys.MeshGeometry_TotalTriangleCountExceeded,
        {
            triangleCount = tostring(num1),
            assetTypeName = assetTypeName,
            maxTriangles = tostring(var1)
        }
    )
end

function module.run(arg1, arg2)
    if arg2.uploadCategory == ValidationEnums.UploadCategory.TORSO_AND_LIMBS
        or arg2.uploadCategory == ValidationEnums.UploadCategory.DYNAMIC_HEAD
    then
        runBodyPartCheck(arg1, arg2)
        return
    end
    runAccessoryCheck(arg1, arg2)
end

return module
