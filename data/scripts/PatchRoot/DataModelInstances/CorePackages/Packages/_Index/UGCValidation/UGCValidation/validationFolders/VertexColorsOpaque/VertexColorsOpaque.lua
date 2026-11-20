-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:11:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UGCValidationService = game:GetService("UGCValidationService")

local scriptParentParentParent = script.Parent.Parent.Parent

local _Types = require(scriptParentParentParent.util.Types)
local ValidationEnums = require(scriptParentParentParent.validationSystem.ValidationEnums)
local ErrorSourceStrings = require(scriptParentParentParent.validationSystem.ErrorSourceStrings)

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

    local bool1 = uploadCategory == ValidationEnums.UploadCategory.TORSO_AND_LIMBS
        or uploadCategory == ValidationEnums.UploadCategory.DYNAMIC_HEAD

    for meshName, value2 in arg2.renderMeshesData do
        local editable = value2.editable

        if not UGCValidationService:ValidateEditableMeshVertColors(editable, bool1) then
            arg1:fail(
                ErrorSourceStrings.Keys.VertexColors_NotOpaque,
                {
                    MeshName = meshName,
                    TransparencyNote = if bool1 then "with no transparency" else ""
                }
            )
        end
    end
end
return module
