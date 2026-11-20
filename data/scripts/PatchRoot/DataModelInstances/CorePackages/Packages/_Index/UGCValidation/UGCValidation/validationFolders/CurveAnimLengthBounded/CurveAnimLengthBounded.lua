-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:00:39Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent

local _Types = require(scriptParentParentParent.util.Types)
local ValidationEnums = require(scriptParentParentParent.validationSystem.ValidationEnums)
local ErrorSourceStrings = require(scriptParentParentParent.validationSystem.ErrorSourceStrings)

local GetFStringUGCValidateCurveAnimationMinLength = require(scriptParentParentParent.flags.GetFStringUGCValidateCurveAnimationMinLength)
local GetFStringUGCValidationMaxAnimationLength = require(scriptParentParentParent.flags.GetFStringUGCValidationMaxAnimationLength)

local getEngineFeatureEngineUGCValidateEmoteAnimationExport = require(scriptParentParentParent.flags.getEngineFeatureEngineUGCValidateEmoteAnimationExport)
local getFFlagUGCValidateAQEmoteDuration = require(scriptParentParentParent.flags.getFFlagUGCValidateAQEmoteDuration)

local module = {}

local fFlagUGCValidateAQEmoteDuration = getEngineFeatureEngineUGCValidateEmoteAnimationExport() and getFFlagUGCValidateAQEmoteDuration()

module.categories = {}
if not fFlagUGCValidateAQEmoteDuration then
    table.insert(module.categories, ValidationEnums.UploadCategory.EMOTE_ANIMATION)
end
table.insert(module.categories, ValidationEnums.UploadCategory.ANIMATION)
module.requiredData = { ValidationEnums.SharedDataMember.curveAnimations, ValidationEnums.SharedDataMember.curveAnimComputedFrames }

module.expectedFailures = {}
module.prereqTests = { ValidationEnums.ValidationModule.CurveAnimDataAvailable }

local function validateCurveAnimClip(arg1, arg2)
    local animationName = arg2.animation and arg2.animation:GetFullName()
    local animLength = arg2.animLength

    local var1 = GetFStringUGCValidateCurveAnimationMinLength.asNumber()

    if not (animLength <= var1) and not (GetFStringUGCValidationMaxAnimationLength.asNumber() < animLength) then
        return
    end

    local tbl1 = {
        minLength = tostring(var1),
        maxLength = GetFStringUGCValidationMaxAnimationLength.asString()
    }
    if animationName then
        tbl1.animationName = animationName
    end
    arg1:fail(ErrorSourceStrings.Keys.CurveAnim_InvalidLength, tbl1, arg2.animation)
end

function module.run(arg1, arg2)
    for _, value in arg2.curveAnimComputedFrames do
        validateCurveAnimClip(arg1, value)
    end
end

return module
