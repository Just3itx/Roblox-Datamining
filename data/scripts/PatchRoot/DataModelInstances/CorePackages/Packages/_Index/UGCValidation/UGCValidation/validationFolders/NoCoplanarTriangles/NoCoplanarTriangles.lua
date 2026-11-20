-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:10:40Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UGCValidationService = game:GetService("UGCValidationService")

local scriptParentParentParent = script.Parent.Parent.Parent

local _Types = require(scriptParentParentParent.util.Types)
local ValidationEnums = require(scriptParentParentParent.validationSystem.ValidationEnums)
local ErrorSourceStrings = require(scriptParentParentParent.validationSystem.ErrorSourceStrings)
local floatEquals = require(scriptParentParentParent.util.floatEquals)

local getFIntMaxCoplanarIntersectionsPercentage = require(scriptParentParentParent.flags.getFIntMaxCoplanarIntersectionsPercentage)
local getFFlagUGCValidateCoplanarTriTestBody = require(scriptParentParentParent.flags.getFFlagUGCValidateCoplanarTriTestBody)

local module = {
    categories = {
        ValidationEnums.UploadCategory.TORSO_AND_LIMBS,
        ValidationEnums.UploadCategory.DYNAMIC_HEAD,
        ValidationEnums.UploadCategory.LAYERED_CLOTHING,
        ValidationEnums.UploadCategory.EYEBROW_EYELASH,
        ValidationEnums.UploadCategory.RIGID_ACCESSORY
    },
    requiredData = { ValidationEnums.SharedDataMember.renderMeshesData },
    expectedFailures = {}
}
function module.run(arg1, arg2)
    local uploadCategory = arg2.uploadCategory

    if (uploadCategory == ValidationEnums.UploadCategory.TORSO_AND_LIMBS
        or uploadCategory == ValidationEnums.UploadCategory.DYNAMIC_HEAD)
        and not getFFlagUGCValidateCoplanarTriTestBody()
    then
        return
    end

    for meshName, value2 in arg2.renderMeshesData do
        local editable = value2.editable
        local scale = value2.scale

        local originalSize = value2.originalSize
        if floatEquals(originalSize.X, 0) or floatEquals(originalSize.Y, 0) or floatEquals(originalSize.Z, 0) then
            continue
        end

        local editableMeshTriCount = UGCValidationService:GetEditableMeshTriCount(editable)
        local num1 = math.floor(getFIntMaxCoplanarIntersectionsPercentage() / 100 * editableMeshTriCount)

        if not UGCValidationService:IsEditableMeshNumCoplanarIntersectionsOverLimit(editable, num1, scale, true) then
            continue
        end

        local coplanarTriTooMany = ErrorSourceStrings.Keys.CoplanarTri_TooMany
        local tbl1 = {
            MeshName = meshName,
            MaxIntersections = tostring(num1),
            TriangleCount = tostring(editableMeshTriCount)
        }
        arg1:fail(coplanarTriTooMany, tbl1)
    end
end

return module
