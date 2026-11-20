-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T17:51:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent

local _Types = require(scriptParentParentParent.util.Types)
local ValidationEnums = require(scriptParentParentParent.validationSystem.ValidationEnums)
local ErrorSourceStrings = require(scriptParentParentParent.validationSystem.ErrorSourceStrings)
local CurveAnimationHierarchyUtils = require(scriptParentParentParent.util.CurveAnimationHierarchyUtils)
local CurveAnimBoneHierarchyUtils = require(scriptParentParentParent.util.CurveAnimBoneHierarchyUtils)

local module = {
    categories = { ValidationEnums.UploadCategory.EMOTE_ANIMATION, ValidationEnums.UploadCategory.ANIMATION },
    requiredData = { ValidationEnums.SharedDataMember.curveAnimations },
    conditionalData = { ValidationEnums.SharedDataMember.curveAnimBoneData },
    expectedFailures = {},
    prereqTests = { ValidationEnums.ValidationModule.CurveAnimDataAvailable }
}
function module.run(arg1, arg2)
    for _, curveAnimation in arg2.curveAnimations do
        for _, descendant in curveAnimation:GetDescendants() do
            if not descendant:IsA("Folder") then
                continue
            end

            local var1 = CurveAnimationHierarchyUtils.folderHasAnimationTracks(descendant)
            local var2 = CurveAnimationHierarchyUtils.isBodyPartFolderNameValid(descendant.Name)
            local var3 = CurveAnimBoneHierarchyUtils.isBoneFolderName(descendant.Name)

            if not var1 or var2 or var3 then
                continue
            end

            local curveAnimInvalidBoneName = ErrorSourceStrings.Keys.CurveAnim_InvalidBoneName
            local tbl1 = {
                boneName = descendant.Name
            }
            arg1:fail(curveAnimInvalidBoneName, tbl1)
        end
    end
end

return module
