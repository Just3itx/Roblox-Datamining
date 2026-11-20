-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T17:50:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UGCValidationService = game:GetService("UGCValidationService")

local scriptParentParentParent = script.Parent.Parent.Parent

local _Types = require(scriptParentParentParent.util.Types)
local ValidationEnums = require(scriptParentParentParent.validationSystem.ValidationEnums)
local ErrorSourceStrings = require(scriptParentParentParent.validationSystem.ErrorSourceStrings)

local module = {
    categories = { ValidationEnums.UploadCategory.TORSO_AND_LIMBS, ValidationEnums.UploadCategory.DYNAMIC_HEAD },
    requiredData = { ValidationEnums.SharedDataMember.outerCagesData },
    conditionalData = {},
    expectedFailures = {}
}
function module.run(arg1, arg2)
    for partName, value2 in arg2.outerCagesData do
        if not UGCValidationService:ValidateEditableMeshCageUVTriangleArea(value2.editable) then
            arg1:fail(ErrorSourceStrings.Keys.CageUV_ZeroAreaTriangle, { partName = partName })
        end
    end
end

return module
