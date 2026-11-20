-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T17:51:26Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent

local _Types = require(scriptParentParentParent.util.Types)
local ValidationEnums = require(scriptParentParentParent.validationSystem.ValidationEnums)
local ErrorSourceStrings = require(scriptParentParentParent.validationSystem.ErrorSourceStrings)
local CurveAnimationHierarchyUtils = require(scriptParentParentParent.util.CurveAnimationHierarchyUtils)

local module = {
    categories = { ValidationEnums.UploadCategory.EMOTE_ANIMATION, ValidationEnums.UploadCategory.ANIMATION },
    requiredData = { ValidationEnums.SharedDataMember.curveAnimations },
    expectedFailures = {},
    prereqTests = { ValidationEnums.ValidationModule.CurveAnimDataAvailable }
}
function module.run(arg1, arg2)
    for _, curveAnimation in arg2.curveAnimations do
        local bodyPartFolderRoot = CurveAnimationHierarchyUtils.getBodyPartFolderRoot(curveAnimation)
        if not bodyPartFolderRoot then
            arg1:fail(ErrorSourceStrings.Keys.CurveAnim_NoJointManipulation)
            return
        end

        local descendants = bodyPartFolderRoot:GetDescendants()
        table.insert(descendants, bodyPartFolderRoot)
        local bool1 = false
        for _, descendant in descendants do
            if not (descendant:IsA("Folder") and CurveAnimationHierarchyUtils.getBodyPartToParentMap()[descendant.Name]) then
                continue
            end

            local position = descendant:FindFirstChild("Position")
            local rotation = descendant:FindFirstChild("Rotation")
            if position and position:IsA("Vector3Curve") and rotation and rotation:IsA("EulerRotationCurve") then
                bool1 = true
                break
            end
        end

        if not bool1 then
            arg1:fail(ErrorSourceStrings.Keys.CurveAnim_NoJointManipulation)
            return
        end
    end
end

return module
