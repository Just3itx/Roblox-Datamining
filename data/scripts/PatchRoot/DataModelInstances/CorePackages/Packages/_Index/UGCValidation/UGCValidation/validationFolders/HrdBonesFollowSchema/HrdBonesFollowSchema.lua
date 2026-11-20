-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:01:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local _Types = require(scriptParentParentParent.util.Types)
local ValidationEnums = require(scriptParentParentParent.validationSystem.ValidationEnums)
local ErrorSourceStrings = require(scriptParentParentParent.validationSystem.ErrorSourceStrings)

local getAllInstancesIsA = require(scriptParentParentParent.util.getAllInstancesIsA)
local R15plusUtils = require(scriptParentParentParent.util.R15plusUtils)

local getEngineFeatureEngineUGCValidateInstanceTreesEquivalent = require(scriptParentParentParent.flags.getEngineFeatureEngineUGCValidateInstanceTreesEquivalent)
local shouldValidateR15LegacyDuplicate = require(scriptParentParentParent.util.shouldValidateR15LegacyDuplicate)
local module = {
    categories = { ValidationEnums.UploadCategory.TORSO_AND_LIMBS, ValidationEnums.UploadCategory.DYNAMIC_HEAD },
    requiredData = { ValidationEnums.SharedDataMember.rootInstance, ValidationEnums.SharedDataMember.uploadEnum, ValidationEnums.SharedDataMember.consumerConfig },
    fflag = R15plusUtils.checkFlagEnabledForAllowHrd
}
local bool1 = game:DefineFastFlag("UGCValidationRemoveHRDBlocker", false)

local function fillBoneTreeFlatList(arg1, bool2: boolean, tbl1)
    for _, child in arg1:GetChildren() do
        local bool3 = if child:IsA("Bone") then true else bool2

        if bool3 then
            table.insert(tbl1, child)
        end

        fillBoneTreeFlatList(child, bool3, tbl1)
    end
end

local function nameIsMappedInRigDescriptions(arg1, humanoidRigDescription, digitsRigDescription)
    for _, value in R15plusUtils.getHrdJointLabels() do
        if arg1.Name == value.Name then
            local joint = humanoidRigDescription:GetJoint(value)
            return joint and joint.UniqueId == arg1.UniqueId
        end
    end

    if digitsRigDescription then
        for _, value in R15plusUtils.getDrdJointLabels() do
            local str1 = `{digitsRigDescription.Side.Name}Hand{value.Name}`
            if arg1.Name == str1 then
                local joint = digitsRigDescription:GetJoint(value)
                return joint and joint.UniqueId == arg1.UniqueId
            end
        end
    end

    return false
end

local function validateBonesForRoot(arg1, arg2)
    for _, value in getAllInstancesIsA(arg1, "MeshPart") do
        local valueName = value.Name

        local humanoidRigDescription = value:FindFirstChildWhichIsA("HumanoidRigDescription")
        local digitsRigDescription = value:FindFirstChildWhichIsA("DigitsRigDescription")

        if humanoidRigDescription ~= nil and not bool1 then
            arg2:fail(ErrorSourceStrings.Keys.HrdCheck_TempR15BonesUploadNotAllowed, nil, humanoidRigDescription)
        end

        if humanoidRigDescription == nil then
            for _, value2 in (getAllInstancesIsA(value, "Bone")) do
                local hrdCheckBoneWithoutHrd = ErrorSourceStrings.Keys.HrdCheck_BoneWithoutHrd
                local tbl1 = {
                    bonePath = value2:GetFullName()
                }
                arg2:fail(hrdCheckBoneWithoutHrd, tbl1, value2)
            end

            if digitsRigDescription ~= nil then
                arg2:fail(ErrorSourceStrings.Keys.HrdCheck_DrdWithoutHrd, nil, digitsRigDescription)
            end
        else
            local avatarBoneSchema = R15plusUtils.getAvatarBoneSchema(valueName)

            local schemaFlatHierarchyList = R15plusUtils.getSchemaFlatHierarchyList(avatarBoneSchema, { valueName })
            local tbl1 = {}
            fillBoneTreeFlatList(value, false, tbl1)

            local tbl2 = {
                [valueName] = true
            }

            for _, value2 in tbl1 do
                arg2:setReportingInstance(value2)
                local value2Name = value2.Name
                local var1 = schemaFlatHierarchyList[value2Name]
                if value2Name == R15plusUtils.JointRotationName then
                    continue
                end
                if var1 == nil or var1.ClassName ~= value2.ClassName then
                    local hrdCheckUndefinedInstanceInBoneTree = ErrorSourceStrings.Keys.HrdCheck_UndefinedInstanceInBoneTree
                    local tbl3 = {
                        instName = value2Name,
                        className = value2.ClassName
                    }
                    arg2:fail(hrdCheckUndefinedInstanceInBoneTree, tbl3)
                elseif tbl2[value2Name] then
                    arg2:fail(ErrorSourceStrings.Keys.HrdCheck_DuplicateInstance, { instName = value2Name })
                else
                    tbl2[value2Name] = true
                    if var1.ClassName == "Bone" and not nameIsMappedInRigDescriptions(value2, humanoidRigDescription, digitsRigDescription) then
                        arg2:fail(ErrorSourceStrings.Keys.HrdCheck_BoneNotMappedInHRD, { boneName = value2Name })
                    end
                end
            end

            for _, descendant in value:GetDescendants() do
                arg2:setReportingInstance(descendant)
                local var1 = schemaFlatHierarchyList[descendant.Name]
                if not var1 or not descendant:IsA("Attachment") or descendant.Name == R15plusUtils.JointRotationName then
                    continue
                end

                local path = var1.path
                local num1 = #path - 1
                if descendant.ClassName == "Attachment" then
                    while num1 > 1 and not tbl2[path[num1]] do
                        num1 -= 1
                    end
                end

                local expectedParentName = var1.path[num1]
                local descendantParentName = descendant.Parent.Name

                if descendantParentName == expectedParentName then
                    continue
                end
                local hrdCheckImproperParent = ErrorSourceStrings.Keys.HrdCheck_ImproperParent
                local tbl3 = {
                    instName = descendant.Name,
                    parentName = descendantParentName,
                    expectedParentName = expectedParentName
                }
                arg2:fail(hrdCheckImproperParent, tbl3)
            end
        end
    end
end

function module.run(arg1, arg2)
    validateBonesForRoot(arg2.rootInstance, arg1)

    if not getEngineFeatureEngineUGCValidateInstanceTreesEquivalent() or not shouldValidateR15LegacyDuplicate(arg2) then
        return
    end

    if arg2.r15LegacyDuplicateRoot == nil then
        arg1:fail(ErrorSourceStrings.Keys.FolderStructureMismatch)
        return
    end
    arg1:setReportingRoot(arg2.r15LegacyDuplicateRoot)
    validateBonesForRoot(arg2.r15LegacyDuplicateRoot, arg1)
    arg1:setReportingRoot(arg2.rootInstance)
end

return module
