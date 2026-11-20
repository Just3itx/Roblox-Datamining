-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:01:30Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local _Types = require(scriptParentParentParent.util.Types)
local ValidationEnums = require(scriptParentParentParent.validationSystem.ValidationEnums)
local ErrorSourceStrings = require(scriptParentParentParent.validationSystem.ErrorSourceStrings)
local getDiffBetweenOrientations = require(scriptParentParentParent.util.getDiffBetweenOrientations)
local valueToString = require(scriptParentParentParent.util.valueToString)

local getAllInstancesWithName = require(scriptParentParentParent.util.getAllInstancesWithName)
local R15plusUtils = require(scriptParentParentParent.util.R15plusUtils)
local module = {
    categories = { ValidationEnums.UploadCategory.TORSO_AND_LIMBS, ValidationEnums.UploadCategory.DYNAMIC_HEAD },
    requiredData = { ValidationEnums.SharedDataMember.rootInstance },
    fflag = R15plusUtils.checkFlagEnabledForAllowHrd
}
local num1 = game:DefineFastInt("UGCValidationJointRotationMaximumHundredthPositionOffset", 1)

local num2 = game:DefineFastInt("UGCValidationJointRotationMaximumDegreeOrientationOffset", 1)

local tbl1 = {
    [Enum.AssetType.Torso] = {
        RightShoulderRigAttachment = CFrame.fromOrientation(0, 0, 0),
        LeftShoulderRigAttachment = CFrame.fromOrientation(0, math.pi, 0)
    },
    [Enum.AssetType.RightArm] = {
        RightShoulderRigAttachment = CFrame.fromOrientation(0, 0, -(math.pi / 2))
    },
    [Enum.AssetType.LeftArm] = {
        LeftShoulderRigAttachment = CFrame.fromOrientation(0, math.pi, -(math.pi / 2))
    }
}

function module.run(arg1, arg2)
    local rootInstance = arg2.rootInstance
    local tbl2 = { LeftShoulderRigAttachment = 0, RightShoulderRigAttachment = 0 }

    for _, value in getAllInstancesWithName(rootInstance, R15plusUtils.JointRotationName) do
        local valueParent = value.Parent
        arg1:setReportingInstance(value)

        if value.ClassName ~= "Attachment" or not valueParent:IsA("Attachment") then
            local jointRotAttWrongInstanceClass = ErrorSourceStrings.Keys.JointRotAtt_WrongInstanceClass
            local tbl3 = {
                instPath = value:GetFullName()
            }
            arg1:fail(jointRotAttWrongInstanceClass, tbl3)
        elseif tbl2[valueParent.Name] == nil then
            local jointRotAttUnrecognizedParent = ErrorSourceStrings.Keys.JointRotAtt_UnrecognizedParent
            local tbl3 = {
                parentPath = valueParent:GetFullName()
            }
            arg1:fail(jointRotAttUnrecognizedParent, tbl3)
        elseif tbl2[valueParent.Name] == 1 then
            local jointRotAttMultipleAttachments = ErrorSourceStrings.Keys.JointRotAtt_MultipleAttachments
            local tbl3 = {
                parentPath = valueParent:GetFullName()
            }
            arg1:fail(jointRotAttMultipleAttachments, tbl3)
        else
            local valueParentName = valueParent.Name
            tbl2[valueParentName] += 1

            if tbl1[arg2.uploadEnum.assetType] ~= nil and tbl1[arg2.uploadEnum.assetType][valueParent.Name] ~= nil then
                local var1 = tbl1[arg2.uploadEnum.assetType][valueParent.Name]
                local valueCFrame = value.CFrame

                if getDiffBetweenOrientations(var1, valueCFrame) > num2 then
                    local vec3 = Vector3.new(var1:ToOrientation())
                    local vec3_2 = Vector3.new(math.deg(vec3.X), math.deg(vec3.Y), math.deg(vec3.Z))

                    local jointRotAttRotated = ErrorSourceStrings.Keys.JointRotAtt_Rotated
                    local tbl3 = {
                        instPath = value:GetFullName(),
                        expectedOrientation = valueToString(vec3_2)
                    }
                    arg1:fail(jointRotAttRotated, tbl3)
                end

                if (valueCFrame.Position - Vector3.new(0, 0, 0)).Magnitude > num1 / 100 then
                    local jointRotAttMoved = ErrorSourceStrings.Keys.JointRotAtt_Moved
                    local tbl3 = {
                        instPath = value:GetFullName(),
                        expectedPosition = valueToString(Vector3.new(0, 0, 0))
                    }
                    arg1:fail(jointRotAttMoved, tbl3)
                end
            end
        end
    end
end

return module
