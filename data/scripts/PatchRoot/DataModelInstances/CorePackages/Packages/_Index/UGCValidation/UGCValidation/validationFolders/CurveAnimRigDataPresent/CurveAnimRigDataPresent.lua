-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:00:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent

local _Types = require(scriptParentParentParent.util.Types)
local ValidationEnums = require(scriptParentParentParent.validationSystem.ValidationEnums)
local ErrorSourceStrings = require(scriptParentParentParent.validationSystem.ErrorSourceStrings)
local CurveAnimBoneHierarchyUtils = require(scriptParentParentParent.util.CurveAnimBoneHierarchyUtils)

local getEngineFeatureIsValidR15Plus = require(scriptParentParentParent.flags.getEngineFeatureIsValidR15Plus)

local module = {
    categories = { ValidationEnums.UploadCategory.EMOTE_ANIMATION, ValidationEnums.UploadCategory.ANIMATION },
    requiredData = { ValidationEnums.SharedDataMember.curveAnimations },
    expectedFailures = {},
    prereqTests = { ValidationEnums.ValidationModule.CurveAnimDataAvailable }
}
function module.run(arg1, arg2)
    for _, curveAnimation in arg2.curveAnimations do
        local num1 = 0
        for _, child in curveAnimation:GetChildren() do
            if not child:IsA("AnimationRigData") then
                continue
            end

            num1 += 1
            if num1 > 1 then
                arg1:fail(ErrorSourceStrings.Keys.CurveAnim_MultipleRigData)
                return
            end
        end

        if num1 == 0 then
            arg1:fail(ErrorSourceStrings.Keys.CurveAnim_NoRigData)
            return
        end

        if CurveAnimBoneHierarchyUtils.hasBoneFolders(curveAnimation) then
            if getEngineFeatureIsValidR15Plus() then
                for _, child in curveAnimation:GetChildren() do
                    if child:IsA("AnimationRigData") and not child:IsValidR15Plus() then
                        arg1:fail(ErrorSourceStrings.Keys.CurveAnim_InvalidRigDataR15Plus)
                        return
                    end
                end
            end
        else
            for _, child in curveAnimation:GetChildren() do
                if child:IsA("AnimationRigData") and not child:IsValidR15() then
                    arg1:fail(ErrorSourceStrings.Keys.CurveAnim_InvalidRigData)
                    return
                end
            end
        end
    end
end

return module
