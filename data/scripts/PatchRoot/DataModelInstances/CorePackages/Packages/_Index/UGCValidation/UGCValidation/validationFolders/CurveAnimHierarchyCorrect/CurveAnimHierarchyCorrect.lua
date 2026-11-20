-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T17:51:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent

local _Types = require(scriptParentParentParent.util.Types)
local ValidationEnums = require(scriptParentParentParent.validationSystem.ValidationEnums)
local ErrorSourceStrings = require(scriptParentParentParent.validationSystem.ErrorSourceStrings)
local CurveAnimationHierarchyUtils = require(scriptParentParentParent.util.CurveAnimationHierarchyUtils)

local getFFlagUGCValidateMaxTotalInstances = require(scriptParentParentParent.flags.getFFlagUGCValidateMaxTotalInstances)

local module = {
    categories = { ValidationEnums.UploadCategory.EMOTE_ANIMATION, ValidationEnums.UploadCategory.ANIMATION },
    requiredData = { ValidationEnums.SharedDataMember.curveAnimations },
    expectedFailures = {},
    prereqTests = { ValidationEnums.ValidationModule.CurveAnimDataAvailable }
}
function module.run(arg1, arg2)
    for _, curveAnimation in arg2.curveAnimations do
        local num1 = #curveAnimation:GetDescendants()
        if getFFlagUGCValidateMaxTotalInstances() < num1 then
            arg1:fail(
                ErrorSourceStrings.Keys.CurveAnim_TooManyDescendants,
                {
                    count = tostring(num1),
                    maxAllowed = tostring(getFFlagUGCValidateMaxTotalInstances())
                }
            )
            return
        end

        local num2 = 0
        for _, child in curveAnimation:GetChildren() do
            if not (child:IsA("Folder") and CurveAnimationHierarchyUtils.isBodyPartFolderNameValid(child.Name)) then
                continue
            end

            num2 += 1
            if num2 > 1 then
                arg1:fail(ErrorSourceStrings.Keys.CurveAnim_MultipleBodyRoots)
                return
            end
        end

        if num2 == 0 then
            arg1:fail(ErrorSourceStrings.Keys.CurveAnim_NoBodyRoot)
            return
        end

        for _, child in curveAnimation:GetChildren() do
            if child:IsA("MarkerCurve") or child:IsA("AnimationRigData") then
                if #child:GetChildren() > 0 then
                    arg1:fail(ErrorSourceStrings.Keys.CurveAnim_ChildrenOnMarkerOrRig)
                    return
                end
            elseif not child:IsA("Folder") then
                arg1:fail(ErrorSourceStrings.Keys.CurveAnim_UnexpectedChild, { childName = child.Name })

                return
            end
        end
    end
end
return module
