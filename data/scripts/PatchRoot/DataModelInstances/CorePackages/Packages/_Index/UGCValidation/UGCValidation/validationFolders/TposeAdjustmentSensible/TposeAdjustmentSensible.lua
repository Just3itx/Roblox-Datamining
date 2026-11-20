-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:11:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local _Types = require(scriptParentParentParent.util.Types)
local ValidationEnums = require(scriptParentParentParent.validationSystem.ValidationEnums)
local ErrorSourceStrings = require(scriptParentParentParent.validationSystem.ErrorSourceStrings)
local getAllInstancesIsA = require(scriptParentParentParent.util.getAllInstancesIsA)
local Vector3Utils = require(scriptParentParentParent.util.Vector3Utils)
local valueToString = require(scriptParentParentParent.util.valueToString)
local CFrameUtils = require(scriptParentParentParent.util.CFrameUtils)
local getDiffBetweenOrientations = require(scriptParentParentParent.util.getDiffBetweenOrientations)

local module = {
    categories = { ValidationEnums.UploadCategory.TORSO_AND_LIMBS, ValidationEnums.UploadCategory.DYNAMIC_HEAD },
    requiredData = { ValidationEnums.SharedDataMember.rootInstance, ValidationEnums.SharedDataMember.renderMeshesData },
    fflag = require(scriptParentParentParent.flags.getEngineFeatureEngineUGCValidateTPoseAdjustment)
}
local UGCValidationService = game:GetService("UGCValidationService")
local num1 = game:DefineFastInt("UGCValidationTposeShoulderDegreeOffsetThreshold", 30)
local num2 = game:DefineFastInt("UGCValidationTposeElbowDegreeOffsetThreshold", 30)
local num3 = game:DefineFastInt("UGCValidationTposeWristDegreeOffsetThreshold", 30)
local num4 = game:DefineFastInt("UGCValidationTposeClavicleDegreeOffsetThreshold", 30)
local num5 = game:DefineFastInt("UGCValidationTposeFingerDegreeOffsetThreshold", 30)
local num6 = game:DefineFastInt("UGCValidationTposeGeneralDegreeOffsetThreshold", 30)
local num7 = game:DefineFastInt("UGCValidationTposePositionOffsetPercentThreshold", 40) / 100

local tbl1 = {
    [Enum.RigLabel.LeftShoulder] = num1,
    [Enum.RigLabel.RightShoulder] = num1,
    [Enum.RigLabel.LeftElbow] = num2,
    [Enum.RigLabel.RightElbow] = num2,
    [Enum.RigLabel.LeftWrist] = num3,
    [Enum.RigLabel.RightWrist] = num3,
    [Enum.RigLabel.LeftClavicle] = num4,
    [Enum.RigLabel.RightClavicle] = num4
}

local function checkJointTposeAdjustment(arg1, rigLabel: Enum.RigLabel, cFrame: CFrame, partsFolder: Instance, vec1: vector, degLimit: number)
    local cFrame2 = UGCValidationService:GetExpectedTposeRotation(rigLabel, partsFolder)

    if degLimit < getDiffBetweenOrientations(cFrame.Rotation, cFrame2) then
        arg1:fail(
            ErrorSourceStrings.Keys.HrdTposeRotation,
            {
                jointName = rigLabel.Name,
                degLimit = degLimit,
                expectedOrientation = CFrameUtils.getRotationString(cFrame2)
            }
        )
    end
    if not Vector3Utils.isInRange(cFrame.Position, vec1 * -1, vec1) then
        arg1:fail(ErrorSourceStrings.Keys.HrdTposePosition, { jointName = rigLabel.Name, offsetLimit = valueToString(vec1) })
    end
end

function module.run(arg1, arg2)
    local rootInstance = arg2.rootInstance
    for _, value in getAllInstancesIsA(rootInstance, "MeshPart") do
        local humanoidRigDescription = value:FindFirstChildWhichIsA("HumanoidRigDescription")
        if humanoidRigDescription == nil then
            continue
        end

        arg1:setReportingInstance(value)

        local var1 = arg2.renderMeshesData[value.Name]
        local var2 = var1.originalSize * var1.scale * num7
        for _, containedJointLabel in (humanoidRigDescription:GetContainedJointLabels(value.Name)) do
            if humanoidRigDescription:GetJoint(containedJointLabel) then
                checkJointTposeAdjustment(
                    arg1,
                    containedJointLabel,
                    humanoidRigDescription:GetTposeAdjustment(containedJointLabel),
                    rootInstance,
                    var2,
                    tbl1[containedJointLabel] or num6
                )
            end
        end

        local digitsRigDescription = value:FindFirstChildWhichIsA("DigitsRigDescription")
        if digitsRigDescription == nil then
            continue
        end

        for _, jointLabel in digitsRigDescription:GetJointLabels() do
            if digitsRigDescription:GetJoint(jointLabel) then
                checkJointTposeAdjustment(
                    arg1,
                    jointLabel,
                    digitsRigDescription:GetTposeAdjustment(jointLabel),
                    rootInstance,
                    var2,
                    tbl1[jointLabel] or num5
                )
            end
        end
    end
end

return module
