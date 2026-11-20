-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T17:51:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UGCValidationService = game:GetService("UGCValidationService")

local scriptParentParentParent = script.Parent.Parent.Parent

local Constants = require(scriptParentParentParent.Constants)
local _Types = require(scriptParentParentParent.util.Types)
local ValidationEnums = require(scriptParentParentParent.validationSystem.ValidationEnums)
local ErrorSourceStrings = require(scriptParentParentParent.validationSystem.ErrorSourceStrings)

local getFIntUniqueUVTolerance = require(scriptParentParentParent.flags.getFIntUniqueUVTolerance)

local module = {
    categories = { ValidationEnums.UploadCategory.TORSO_AND_LIMBS, ValidationEnums.UploadCategory.DYNAMIC_HEAD },
    requiredData = { ValidationEnums.SharedDataMember.outerCagesData },
    conditionalData = {},
    expectedFailures = {}
}
function module.run(arg1, arg2)
    for partName, value2 in arg2.outerCagesData do
        local var1 = Constants.WRAP_TARGET_CAGE_MESH_UV_COUNTS[partName]
        if not var1 then
            continue
        end

        local num1 = UGCValidationService:CalculateEditableMeshUniqueUVCount(value2.editable)

        if not (math.abs(num1 - var1) > getFIntUniqueUVTolerance()) then
            continue
        end

        local cageUvIncorrectUvCount = ErrorSourceStrings.Keys.CageUV_IncorrectUVCount
        local tbl1 = {
            partName = partName,
            requiredUVCount = tostring(var1),
            actualUVCount = tostring(num1)
        }
        arg1:fail(cageUvIncorrectUvCount, tbl1)
    end
end

return module
