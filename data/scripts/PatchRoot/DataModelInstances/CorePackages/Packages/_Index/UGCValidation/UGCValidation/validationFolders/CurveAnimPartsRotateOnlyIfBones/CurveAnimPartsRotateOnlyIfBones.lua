-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:00:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent

local _Types = require(scriptParentParentParent.util.Types)
local ValidationEnums = require(scriptParentParentParent.validationSystem.ValidationEnums)
local ErrorSourceStrings = require(scriptParentParentParent.validationSystem.ErrorSourceStrings)
local CurveAnimationHierarchyUtils = require(scriptParentParentParent.util.CurveAnimationHierarchyUtils)
local CurveAnimBoneHierarchyUtils = require(scriptParentParentParent.util.CurveAnimBoneHierarchyUtils)
local CurveAnimTranslationUtils = require(scriptParentParentParent.util.CurveAnimTranslationUtils)

local num1 = game:DefineFastInt("UGCValidateBodyPartTranslationMaxDistanceHundredths", 100)

local num2 = game:DefineFastInt("UGCValidateLowerTorsoTranslationMaxDistanceHundredths", 200)

local module = {
    categories = { ValidationEnums.UploadCategory.EMOTE_ANIMATION, ValidationEnums.UploadCategory.ANIMATION },
    requiredData = { ValidationEnums.SharedDataMember.curveAnimations },
    conditionalData = {},
    expectedFailures = {},
    prereqTests = { ValidationEnums.ValidationModule.CurveAnimDataAvailable }
}
function module.run(arg1, arg2)
    local bool1 = arg2.uploadCategory == ValidationEnums.UploadCategory.ANIMATION

    local num3 = num1 / 100
    local num4 = num2 / 100

    for _, curveAnimation in arg2.curveAnimations do
        local bool2 = false

        if not bool1 then
            local bool3 = false
            for _, descendant in curveAnimation:GetDescendants() do
                if descendant:IsA("Folder") and CurveAnimBoneHierarchyUtils.isBoneFolderName(descendant.Name) then
                    bool3 = true
                    break
                end
            end

            bool2 = not bool3
        end

        if bool2 then
            continue
        end

        for _, descendant in curveAnimation:GetDescendants() do
            if not (descendant:IsA("Folder") and CurveAnimationHierarchyUtils.isBodyPartFolderNameValid(descendant.Name)) then
                continue
            end

            local num5 = if descendant.Name == "LowerTorso" then num4 else num3
            local var1, var2 = CurveAnimTranslationUtils.translationExceedsThreshold(descendant, num5)
            if not var1 then
                continue
            end

            local curveAnimBodyPartTranslationExceedsThreshold = ErrorSourceStrings.Keys.CurveAnim_BodyPartTranslationExceedsThreshold
            local tbl1 = {
                bodyPartName = descendant.Name,
                distance = string.format("%.3f", var2),
                maxDistance = string.format("%.3f", num5)
            }
            arg1:fail(curveAnimBodyPartTranslationExceedsThreshold, tbl1)
        end
    end
end

return module
