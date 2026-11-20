-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T17:51:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent

local _Types = require(scriptParentParentParent.util.Types)
local ValidationEnums = require(scriptParentParentParent.validationSystem.ValidationEnums)
local ErrorSourceStrings = require(scriptParentParentParent.validationSystem.ErrorSourceStrings)
local CurveAnimBoneHierarchyUtils = require(scriptParentParentParent.util.CurveAnimBoneHierarchyUtils)
local CurveAnimTranslationUtils = require(scriptParentParentParent.util.CurveAnimTranslationUtils)

local num1 = game:DefineFastInt("UGCValidateBoneTranslationMaxDistanceHundredths", 100)

local module = {
    categories = { ValidationEnums.UploadCategory.EMOTE_ANIMATION, ValidationEnums.UploadCategory.ANIMATION },
    requiredData = { ValidationEnums.SharedDataMember.curveAnimations },
    conditionalData = { ValidationEnums.SharedDataMember.curveAnimBoneData },
    expectedFailures = {},
    prereqTests = { ValidationEnums.ValidationModule.CurveAnimDataAvailable }
}
function module.run(arg1, arg2)
    local num2 = num1 / 100

    for _, curveAnimation in arg2.curveAnimations do
        for _, descendant in curveAnimation:GetDescendants() do
            if not (descendant:IsA("Folder") and CurveAnimBoneHierarchyUtils.isBoneFolderName(descendant.Name)) then
                continue
            end

            local var1, var2 = CurveAnimTranslationUtils.translationExceedsThreshold(descendant, num2)
            if not var1 then
                continue
            end

            local curveAnimBoneTranslationExceedsThreshold = ErrorSourceStrings.Keys.CurveAnim_BoneTranslationExceedsThreshold
            local tbl1 = {
                boneName = descendant.Name,
                distance = string.format("%.3f", var2),
                maxDistance = string.format("%.3f", num2)
            }
            arg1:fail(curveAnimBoneTranslationExceedsThreshold, tbl1)
        end
    end
end

return module
