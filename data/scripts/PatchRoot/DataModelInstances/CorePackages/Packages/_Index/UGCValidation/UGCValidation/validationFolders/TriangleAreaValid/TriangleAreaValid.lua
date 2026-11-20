-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:11:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UGCValidationService = game:GetService("UGCValidationService")

local scriptParentParentParent = script.Parent.Parent.Parent

local _Types = require(scriptParentParentParent.util.Types)
local ValidationEnums = require(scriptParentParentParent.validationSystem.ValidationEnums)
local ErrorSourceStrings = require(scriptParentParentParent.validationSystem.ErrorSourceStrings)

local module = {
    categories = { ValidationEnums.UploadCategory.TORSO_AND_LIMBS, ValidationEnums.UploadCategory.DYNAMIC_HEAD },
    requiredData = { ValidationEnums.SharedDataMember.renderMeshesData },
    conditionalData = { ValidationEnums.SharedDataMember.outerCagesData },
    expectedFailures = {}
}
local function checkTriangleArea(arg1, editable, meshName: string) -- Luacid: Inlined by compiler; 2 call sites recovered
    if not UGCValidationService:ValidateEditableMeshTriangleArea(editable) then
        arg1:fail(ErrorSourceStrings.Keys.MeshGeometry_ZeroAreaTriangle, { meshName = meshName })
    end
end

function module.run(arg1, arg2)
    for value, value2 in arg2.renderMeshesData do
        checkTriangleArea(arg1, value2.editable, value)
    end

    if not arg2.outerCagesData then
        return
    end

    for value, value2 in arg2.outerCagesData do
        checkTriangleArea(arg1, value2.editable, value .. "OuterCage")
    end
end

return module
