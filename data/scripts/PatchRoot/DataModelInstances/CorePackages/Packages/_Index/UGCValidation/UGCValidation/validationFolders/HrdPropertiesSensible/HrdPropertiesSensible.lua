-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:01:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local _Types = require(scriptParentParentParent.util.Types)
local ValidationEnums = require(scriptParentParentParent.validationSystem.ValidationEnums)
local ErrorSourceStrings = require(scriptParentParentParent.validationSystem.ErrorSourceStrings)
local ValidationRulesUtil = require(scriptParentParentParent.util.ValidationRulesUtil)

local getAllInstancesIsA = require(scriptParentParentParent.util.getAllInstancesIsA)
local R15plusUtils = require(scriptParentParentParent.util.R15plusUtils)
local Vector3Utils = require(scriptParentParentParent.util.Vector3Utils)
local valueToString = require(scriptParentParentParent.util.valueToString)
local CFrameUtils = require(scriptParentParentParent.util.CFrameUtils)
local module = {
    categories = { ValidationEnums.UploadCategory.TORSO_AND_LIMBS, ValidationEnums.UploadCategory.DYNAMIC_HEAD },
    requiredData = { ValidationEnums.SharedDataMember.rootInstance },
    fflag = R15plusUtils.checkFlagEnabledForAllowHrd
}
local num1 = game:DefineFastInt("UGCValidationHrdJointSizeHundredthsLimit", 150) / 100
local num2 = game:DefineFastInt("UGCValidationHrdJointRangeMinXHundredths", 0)
local num3 = game:DefineFastInt("UGCValidationHrdJointRangeMaxXHundredths", 0)
local num4 = game:DefineFastInt("UGCValidationHrdJointRangeMinYHundredths", 0)
local num5 = game:DefineFastInt("UGCValidationHrdJointRangeMaxYHundredths", 0)
local num6 = game:DefineFastInt("UGCValidationHrdJointRangeMinZHundredths", 0)
local num7 = game:DefineFastInt("UGCValidationHrdJointRangeMaxZHundredths", 0)
local num8 = game:DefineFastInt("UGCValidationHrdOriginOffsetMinYHundredths", -500)
local num9 = game:DefineFastInt("UGCValidationHrdOriginOffsetMaxYHundredths", 500)
local vec3 = Vector3.new(num2 / 100, num4 / 100, num6 / 100)
local vec3_2 = Vector3.new(num3 / 100, num5 / 100, num7 / 100)
local vec3_3 = Vector3.new(0, num8 / 100, 0)
local vec3_4 = Vector3.new(0, num9 / 100, 0)

local num10 = game:DefineFastInt("UGCValidationDrdJointSizeHundredthsLimit", 150) / 100
local num11 = game:DefineFastInt("UGCValidationDrdJointRangeMinXHundredths", 0)
local num12 = game:DefineFastInt("UGCValidationDrdJointRangeMaxXHundredths", 0)
local num13 = game:DefineFastInt("UGCValidationDrdJointRangeMinYHundredths", 0)
local num14 = game:DefineFastInt("UGCValidationDrdJointRangeMaxYHundredths", 0)
local num15 = game:DefineFastInt("UGCValidationDrdJointRangeMinZHundredths", 0)
local num16 = game:DefineFastInt("UGCValidationDrdJointRangeMaxZHundredths", 0)
local vec3_5 = Vector3.new(num11 / 100, num13 / 100, num15 / 100)
local vec3_6 = Vector3.new(num12 / 100, num14 / 100, num16 / 100)

local function checkVectorRange(arg1, jointName: string, propertyName: string, vec1: vector, vec2: vector, vec4: vector)
    if Vector3Utils.isInRange(vec1, vec2, vec4) then
        return
    end

    arg1:fail(ErrorSourceStrings.Keys.HrdProperties_PropertyOutOfRange, {
        jointName = jointName,
        propertyName = propertyName,
        currentValue = valueToString(vec1),
        valueMin = valueToString(vec2),
        valueMax = valueToString(vec4)
    })
end

local function checkSize(arg1, jointName: string, propertyName: string, num17: number, num18: number)
    if not (num17 < 0) and not (num18 < num17) then
        return
    end

    arg1:fail(ErrorSourceStrings.Keys.HrdProperties_PropertyOutOfRange, {
        jointName = jointName,
        propertyName = propertyName,
        currentValue = valueToString(num17),
        valueMin = "0",
        valueMax = valueToString(num18)
    })
end

function module.run(arg1, arg2)
    local rootInstance = arg2.rootInstance
    for _, value in getAllInstancesIsA(rootInstance, "MeshPart") do
        local humanoidRigDescription = value:FindFirstChildWhichIsA("HumanoidRigDescription")
        local var1 = ValidationRulesUtil.rigAttachmentToParentMap[value.Name]
        if humanoidRigDescription == nil then
            continue
        end

        arg1:setReportingInstance(humanoidRigDescription)

        local originOffset = humanoidRigDescription.OriginOffset
        if value.Name == "LowerTorso" then
            if not (CFrameUtils.fuzzyEq(originOffset.Rotation, CFrame.identity)
                and Vector3Utils.isInRange(originOffset.Position, vec3_3, vec3_4)) then
                local hrdPropertiesOriginOutsideBounds = ErrorSourceStrings.Keys.HrdProperties_OriginOutsideBounds
                local tbl1 = {
                    valueMin = valueToString(vec3_3),
                    valueMax = valueToString(vec3_4)
                }
                arg1:fail(hrdPropertiesOriginOutsideBounds, tbl1)
            end
        elseif not CFrameUtils.fuzzyEq(originOffset, CFrame.identity) then
            local hrdPropertiesUncontainedJoint = ErrorSourceStrings.Keys.HrdProperties_UncontainedJoint
            local tbl1 = {
                jointName = "originOffset",
                foundMeshName = value.Name
            }
            arg1:fail(hrdPropertiesUncontainedJoint, tbl1)
        end

        local containedJointLabels = humanoidRigDescription:GetContainedJointLabels(value.Name)
        for _, value2 in R15plusUtils.getHrdJointLabels() do
            local bool1 = `{value2.Name}RigAttachment` == var1
            local joint = humanoidRigDescription:GetJoint(value2)

            if bool1 and (not joint or joint.Name ~= var1 or joint.ClassName ~= "Attachment") then
                local hrdMissingStandardJoint = ErrorSourceStrings.Keys.HrdMissingStandardJoint
                local tbl1 = {
                    jointName = value2.Name
                }
                arg1:fail(hrdMissingStandardJoint, tbl1)
            end

            if not joint then
                continue
            end
            if not table.find(containedJointLabels, value2) then
                local hrdPropertiesUncontainedJoint = ErrorSourceStrings.Keys.HrdProperties_UncontainedJoint
                local tbl1 = {
                    jointName = value2.Name,
                    foundMeshName = value.Name
                }
                arg1:fail(hrdPropertiesUncontainedJoint, tbl1)
            else
                if not bool1 and (joint.Name ~= value2.Name or joint.ClassName ~= "Bone") then
                    local hrdImproperJointMapping = ErrorSourceStrings.Keys.HrdImproperJointMapping
                    local tbl1 = {
                        jointName = value2.Name,
                        boneName = value2.Name
                    }
                    arg1:fail(hrdImproperJointMapping, tbl1)
                end

                local jointSize = humanoidRigDescription:GetJointSize(value2)
                local vec3_7 = humanoidRigDescription:GetJointRangeMin(value2)
                local vec3_8 = humanoidRigDescription:GetJointRangeMax(value2)

                checkSize(arg1, value2.Name, "size", jointSize, num1)
                checkVectorRange(arg1, value2.Name, "rangeMin", vec3_7, vec3, vec3_2)

                checkVectorRange(arg1, value2.Name, "rangeMax", vec3_8, vec3, vec3_2)

                if not Vector3Utils.isFirstLessOrEqual(vec3_7, vec3_8) then
                    local hrdPropertiesMinAboveMax = ErrorSourceStrings.Keys.HrdProperties_MinAboveMax
                    local tbl1 = {
                        jointName = value2.Name
                    }
                    arg1:fail(hrdPropertiesMinAboveMax, tbl1)
                end
            end
        end

        local digitsRigDescription = value:FindFirstChildWhichIsA("DigitsRigDescription")
        if digitsRigDescription == nil then
            continue
        end

        arg1:setReportingInstance(digitsRigDescription)

        if (value.Name ~= "LeftHand" or digitsRigDescription.Side ~= Enum.DigitsRigDescriptionSide.Left)
            and (value.Name ~= "RightHand" or digitsRigDescription.Side ~= Enum.DigitsRigDescriptionSide.Right)
        then
            local str1 = "None"
            if value.Name == "LeftHand" then
                str1 = "Left"
            elseif value.Name == "RightHand" then
                str1 = "Right"
            end

            local hrdCheckDrdInvalidSide = ErrorSourceStrings.Keys.HrdCheck_DrdInvalidSide
            local tbl1 = {
                partName = value.Name,
                expectedSide = str1,
                foundSide = digitsRigDescription.Side.Name
            }
            arg1:fail(hrdCheckDrdInvalidSide, tbl1)
        end

        checkSize(arg1, "Index", "size", digitsRigDescription.IndexSize, num10)
        checkSize(arg1, "Thumb", "size", digitsRigDescription.ThumbSize, num10)
        checkSize(arg1, "Middle", "size", digitsRigDescription.MiddleSize, num10)
        checkSize(arg1, "Pinky", "size", digitsRigDescription.PinkySize, num10)
        checkSize(arg1, "Ring", "size", digitsRigDescription.RingSize, num10)
        checkVectorRange(arg1, "Index", "range", digitsRigDescription.IndexRange, vec3_5, vec3_6)
        checkVectorRange(arg1, "Thumb", "range", digitsRigDescription.ThumbRange, vec3_5, vec3_6)
        checkVectorRange(arg1, "Pinky", "range", digitsRigDescription.PinkyRange, vec3_5, vec3_6)
        checkVectorRange(arg1, "Ring", "range", digitsRigDescription.RingRange, vec3_5, vec3_6)
        checkVectorRange(arg1, "Middle", "range", digitsRigDescription.MiddleRange, vec3_5, vec3_6)
    end
end

return module
