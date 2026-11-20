-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:00:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent

local _Types = require(scriptParentParentParent.util.Types)
local ValidationEnums = require(scriptParentParentParent.validationSystem.ValidationEnums)
local ErrorSourceStrings = require(scriptParentParentParent.validationSystem.ErrorSourceStrings)
local buildStaticCurveAnimationSchema = require(scriptParentParentParent.util.buildStaticCurveAnimationSchema)
local validateInstanceTreeAgainstSchema = require(scriptParentParentParent.util.validateInstanceTreeAgainstSchema)
local CurveAnimationHierarchyUtils = require(scriptParentParentParent.util.CurveAnimationHierarchyUtils)

local getFFlagUGCValidateCurveAnimStrictSchema = require(scriptParentParentParent.flags.getFFlagUGCValidateCurveAnimStrictSchema)

local module = {
    categories = { ValidationEnums.UploadCategory.EMOTE_ANIMATION, ValidationEnums.UploadCategory.ANIMATION },
    requiredData = { ValidationEnums.SharedDataMember.curveAnimations },
    fflag = getFFlagUGCValidateCurveAnimStrictSchema,
    expectedFailures = {},
    prereqTests = { ValidationEnums.ValidationModule.CurveAnimDataAvailable }
}

local function validateNoBodyPartDuplicates(arg1, arg2)
    local tbl1 = {}
    for _, descendant in arg1:GetDescendants() do
        if not (descendant:IsA("Folder") and CurveAnimationHierarchyUtils.isBodyPartFolderNameValid(descendant.Name)) then
            continue
        end

        if tbl1[descendant.Name] then
            local curveAnimDuplicateBodyPartFolder = ErrorSourceStrings.Keys.CurveAnim_DuplicateBodyPartFolder
            local tbl2 = {
                bodyPartName = descendant.Name,
                instancePath = descendant:GetFullName()
            }
            arg2:fail(curveAnimDuplicateBodyPartFolder, tbl2)
        end

        tbl1[descendant.Name] = true
    end
end

function module.run(arg1, arg2)
    local var1 = buildStaticCurveAnimationSchema

    for _, curveAnimation in arg2.curveAnimations do
        local var2 = validateInstanceTreeAgainstSchema
        local tbl1 = {
            missingErrorKey = ErrorSourceStrings.Keys.CurveAnim_StrictSchemaViolation,
            unauthorizedErrorKey = ErrorSourceStrings.Keys.CurveAnim_StrictSchemaViolation,
            skipRootClassCheck = true,
            skipInstanceContext = true
        }
        var2(curveAnimation, var1, arg1, tbl1)

        validateNoBodyPartDuplicates(curveAnimation, arg1)
    end
end

return module
