-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T17:51:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent

local _Types = require(scriptParentParentParent.util.Types)
local ValidationEnums = require(scriptParentParentParent.validationSystem.ValidationEnums)
local ErrorSourceStrings = require(scriptParentParentParent.validationSystem.ErrorSourceStrings)
local CurveAnimationHierarchyUtils = require(scriptParentParentParent.util.CurveAnimationHierarchyUtils)
local CurveAnimBoneHierarchyUtils = require(scriptParentParentParent.util.CurveAnimBoneHierarchyUtils)

local getFFlagUGCValidateRestrictNumFaceControls = require(scriptParentParentParent.flags.getFFlagUGCValidateRestrictNumFaceControls)
local getFIntUGCValidateMaxTotalFaceControls = require(scriptParentParentParent.flags.getFIntUGCValidateMaxTotalFaceControls)

local module = {
    categories = { ValidationEnums.UploadCategory.EMOTE_ANIMATION, ValidationEnums.UploadCategory.ANIMATION },
    requiredData = { ValidationEnums.SharedDataMember.curveAnimations },
    conditionalData = { ValidationEnums.SharedDataMember.curveAnimBoneData },
    expectedFailures = {},
    prereqTests = { ValidationEnums.ValidationModule.CurveAnimDataAvailable }
}

local function buildAcceptableForFolder(arg1, str1: string)
    if not CurveAnimBoneHierarchyUtils.isBoneFolderName(arg1.Name) then
        local acceptableChildBodyPartFolders = CurveAnimationHierarchyUtils.calculateAcceptableChildBodyPartFolders(arg1.Name)

        for _, value in CurveAnimBoneHierarchyUtils.getRootBoneNamesForBodyPart(arg1.Name) do
            table.insert(acceptableChildBodyPartFolders, { ClassName = "Folder", Name = value })
        end

        if arg1.Name == CurveAnimationHierarchyUtils.humanoidRootPartName then
            return acceptableChildBodyPartFolders
        end

        table.insert(acceptableChildBodyPartFolders, { ClassName = "Vector3Curve", Name = "Position" })
        table.insert(acceptableChildBodyPartFolders, { ClassName = "EulerRotationCurve", Name = "Rotation" })

        if arg1.Name == "Head" then
            table.insert(
                acceptableChildBodyPartFolders,
                {
                    ClassName = "Folder",
                    Name = CurveAnimationHierarchyUtils.FaceControlsName
                }
            )
        end
        return acceptableChildBodyPartFolders
    end

    local acceptableForFolder = {}
    local childBoneNames = CurveAnimBoneHierarchyUtils.getChildBoneNames(arg1.Name)
    for _, value in childBoneNames do
        table.insert(acceptableForFolder, { ClassName = "Folder", Name = value })
    end

    local bool1 = false
    if #childBoneNames == 1 then
        local var1 = childBoneNames[1]
        for _, child in arg1:GetChildren() do
            if child:IsA("Folder") and child.Name == var1 then
                bool1 = true
                break
            end
        end
    end

    if not bool1 then
        for _, value in CurveAnimationHierarchyUtils.calculateAcceptableChildBodyPartFolders(str1) do
            table.insert(acceptableForFolder, value)
        end
    end
    table.insert(acceptableForFolder, { ClassName = "Vector3Curve", Name = "Position" })
    table.insert(acceptableForFolder, { ClassName = "EulerRotationCurve", Name = "Rotation" })
    return acceptableForFolder
end

local function getFirstUnacceptableChildDetail(arg1, acceptableForFolder)
    if not arg1 then
        return nil
    end
    for _, child in arg1:GetChildren() do
        local bool1 = false
        for value, value2 in acceptableForFolder do
            if value2.ClassName == child.ClassName and value2.Name == child.Name then
                table.remove(acceptableForFolder, value)
                bool1 = true
                break
            end
        end

        if not bool1 then
            return `unexpected {child.ClassName} '{child.Name}'`
        end
    end
    return nil
end

local function validateFolderStructure(arg1, str1: string, str2: string)
    local acceptableForFolder = buildAcceptableForFolder(arg1, str2)
    local firstUnacceptableChildDetail = getFirstUnacceptableChildDetail(arg1, acceptableForFolder)
    if firstUnacceptableChildDetail then
        return `{firstUnacceptableChildDetail} under '{str1}'`
    end

    local acceptableCurveChildrenArray = CurveAnimationHierarchyUtils.calculateAcceptableCurveChildrenArray()
    local position = arg1:FindFirstChild("Position")
    if not CurveAnimationHierarchyUtils.areChildrenAcceptable(position, acceptableCurveChildrenArray) then
        return `unexpected child under '{str1}/Position'`
    end

    local acceptableCurveChildrenArray2 = CurveAnimationHierarchyUtils.calculateAcceptableCurveChildrenArray()
    local rotation = arg1:FindFirstChild("Rotation")
    if not CurveAnimationHierarchyUtils.areChildrenAcceptable(rotation, acceptableCurveChildrenArray2) then
        return `unexpected child under '{str1}/Rotation'`
    end

    local var1 = arg1:FindFirstChild(CurveAnimationHierarchyUtils.FaceControlsName)
    if var1 then
        local children = var1:GetChildren()

        if getFFlagUGCValidateRestrictNumFaceControls() and #children > getFIntUGCValidateMaxTotalFaceControls() then
            return `FaceControls under '{str1}' exceeds max count ({#children})`
        end
        for _, child in children do
            if not child:IsA("FloatCurve") then
                return `unexpected {child.ClassName} '{child.Name}' under '{str1}/FaceControls'`
            end
        end
    end

    if CurveAnimationHierarchyUtils.containsGrandChildren(position) then
        return `'{str1}/Position' contains unexpected grandchildren`
    elseif CurveAnimationHierarchyUtils.containsGrandChildren(rotation) then
        return `'{str1}/Rotation' contains unexpected grandchildren`
    elseif CurveAnimationHierarchyUtils.containsGrandChildren(var1) then
        return `'{str1}/FaceControls' contains unexpected grandchildren`
    end

    return nil
end

local function validateHierarchyTree(arg1, str1: string, str2: string, arg2)
    local detail = validateFolderStructure(arg1, str1, str2)
    if detail then
        arg2:fail(ErrorSourceStrings.Keys.CurveAnim_InvalidBodyPartHierarchyDetail, { folderName = arg1.Name, detail = detail })

        return
    end

    for _, child in arg1:GetChildren() do
        if child:IsA("Folder") and child.Name ~= CurveAnimationHierarchyUtils.FaceControlsName then
            local var2 = if CurveAnimBoneHierarchyUtils.isBoneFolderName(child.Name) then str2 else child.Name
            validateHierarchyTree(child, `{str1}/{child.Name}`, var2, arg2)
        end
    end
end

function module.run(arg1, arg2)
    for _, curveAnimation in arg2.curveAnimations do
        local tbl1 = {}
        local bodyPartFolderRoot = CurveAnimationHierarchyUtils.getBodyPartFolderRoot(curveAnimation)
        if bodyPartFolderRoot then
            table.insert(tbl1, bodyPartFolderRoot)
        end

        for _, value in tbl1 do
            if CurveAnimationHierarchyUtils.isBodyPartFolderNameValid(value.Name) then
                validateHierarchyTree(value, value.Name, value.Name, arg1)
            end
        end
    end
end

return module
