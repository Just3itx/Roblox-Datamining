-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:01:27Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent

local _Types = require(scriptParentParentParent.util.Types)
local ValidationEnums = require(scriptParentParentParent.validationSystem.ValidationEnums)
local ErrorSourceStrings = require(scriptParentParentParent.validationSystem.ErrorSourceStrings)
local ValidationRulesUtil = require(scriptParentParentParent.util.ValidationRulesUtil)

local getFFlagUGCValidateIndividualMeshPartBounds = require(scriptParentParentParent.flags.getFFlagUGCValidateIndividualMeshPartBounds)

local getEngineFeatureEngineUGCValidateMeshPartBoundsFromRules = require(scriptParentParentParent.flags.getEngineFeatureEngineUGCValidateMeshPartBoundsFromRules)

local module = {
    categories = { ValidationEnums.UploadCategory.TORSO_AND_LIMBS, ValidationEnums.UploadCategory.DYNAMIC_HEAD },
    requiredData = { ValidationEnums.SharedDataMember.rootInstance, ValidationEnums.SharedDataMember.uploadEnum, ValidationEnums.SharedDataMember.renderMeshesData },
    conditionalData = {},
    fflag = getFFlagUGCValidateIndividualMeshPartBounds,
    expectedFailures = {},
    prereqTests = {}
}
function module.run(arg1, arg2)
    local rootInstance = arg2.rootInstance
    local renderMeshesData = arg2.renderMeshesData
    local num1, num2

    if getEngineFeatureEngineUGCValidateMeshPartBoundsFromRules() then
        local meshRules = ValidationRulesUtil:getRules().MeshRules
        num1 = meshRules.MeshPartBoundsMin
        num2 = meshRules.MeshPartBoundsMax
    else
        num1 = 0.05
        num2 = 4
    end

    for partName, value2 in renderMeshesData do
        local var1 = value2.originalSize * value2.scale

        local function checkAxis(axis: string, num3: number)
            if num3 < num1 then
                arg1:fail(
                    ErrorSourceStrings.Keys.MeshPartBounds_TooSmall,
                    {
                        partName = partName,
                        axis = axis,
                        currentSize = string.format("%.2f", num3),
                        minSize = string.format("%.2f", num1)
                    },
                    rootInstance
                )
                return
            end

            if not (num2 < num3) then
                return
            end

            arg1:fail(
                ErrorSourceStrings.Keys.MeshPartBounds_TooLarge,
                {
                    partName = partName,
                    axis = axis,
                    currentSize = string.format("%.2f", num3),
                    maxSize = string.format("%.2f", num2)
                },
                rootInstance
            )
        end

        checkAxis("X", var1.X)
        checkAxis("Y", var1.Y)
        checkAxis("Z", var1.Z)
    end
end

return module
