-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T17:50:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local _Types = require(scriptParentParentParent.util.Types)
local ValidationEnums = require(scriptParentParentParent.validationSystem.ValidationEnums)
local ErrorSourceStrings = require(scriptParentParentParent.validationSystem.ErrorSourceStrings)

local getAllInstancesIsA = require(scriptParentParentParent.util.getAllInstancesIsA)
local R15plusUtils = require(scriptParentParentParent.util.R15plusUtils)
local Vector3Utils = require(scriptParentParentParent.util.Vector3Utils)
local CFrameUtils = require(scriptParentParentParent.util.CFrameUtils)
local module = {}

local num1 = game:DefineFastInt("UGCValidationBoneCFrameBoundsMultiplierHundredths", 110)

module.categories = { ValidationEnums.UploadCategory.TORSO_AND_LIMBS, ValidationEnums.UploadCategory.DYNAMIC_HEAD }
module.requiredData = { ValidationEnums.SharedDataMember.rootInstance, ValidationEnums.SharedDataMember.renderMeshesData }
module.fflag = R15plusUtils.checkFlagEnabledForAllowHrd
local num2 = game:DefineFastInt("UGCValidationMinimumJointDistanceHundredths", 5) / 100

function module.run(arg1, arg2)
    local rootInstance = arg2.rootInstance
    local num3 = num1 / 100

    for _, value in (getAllInstancesIsA(rootInstance, "MeshPart")) do
        local var1 = arg2.renderMeshesData[value.Name]
        if not var1 then
            continue
        end

        local var2 = var1.originalSize * var1.scale * num3 / 2
        local var3 = value.CFrame:Inverse()

        for _, value2 in (getAllInstancesIsA(value, "Bone")) do
            arg1:setReportingInstance(value2)
            local position = (var3 * value2.WorldCFrame).Position

            if not Vector3Utils.isInRange(position, -var2, var2) then
                local hrdBoneOutOfBounds = ErrorSourceStrings.Keys.HrdBone_OutOfBounds
                local tbl1 = {
                    bonePath = value2:GetFullName(),
                    partName = value.Name
                }
                arg1:fail(hrdBoneOutOfBounds, tbl1)
            end

            if not CFrameUtils.fuzzyEq(value2.Transform, CFrame.identity) then
                local hrdBoneTransformNotIdentity = ErrorSourceStrings.Keys.HrdBone_TransformNotIdentity
                local tbl1 = {
                    bonePath = value2:GetFullName()
                }
                arg1:fail(hrdBoneTransformNotIdentity, tbl1)
            end

            if not (value2.Parent:IsA("Bone") and value2.Position.Magnitude < num2) then
                continue
            end
            local hrdBoneTooCloseToParent = ErrorSourceStrings.Keys.HrdBone_TooCloseToParent
            local tbl1 = {
                bonePath = value2:GetFullName()
            }
            arg1:fail(hrdBoneTooCloseToParent, tbl1)
        end
    end
end

return module
