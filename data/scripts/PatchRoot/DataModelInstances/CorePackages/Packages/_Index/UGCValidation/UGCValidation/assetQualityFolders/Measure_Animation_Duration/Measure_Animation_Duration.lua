-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T16:20:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local _Types = require(scriptParentParentParent.util.Types)
local ValidationEnums = require(scriptParentParentParent.validationSystem.ValidationEnums)
local ErrorSourceStrings = require(scriptParentParentParent.validationSystem.ErrorSourceStrings)
local getAQEmotePartData = require(scriptParentParentParent.util.getAQEmotePartData)

local getEngineFeatureEngineUGCValidateEmoteAnimationExport = require(scriptParentParentParent.flags.getEngineFeatureEngineUGCValidateEmoteAnimationExport)
local getFFlagUGCValidateAQEmoteDuration = require(scriptParentParentParent.flags.getFFlagUGCValidateAQEmoteDuration)
local GetFStringUGCValidateCurveAnimationMinLength = require(scriptParentParentParent.flags.GetFStringUGCValidateCurveAnimationMinLength)
local GetFStringUGCValidationMaxAnimationLength = require(scriptParentParentParent.flags.GetFStringUGCValidationMaxAnimationLength)

local module = {
    categories = { ValidationEnums.UploadCategory.EMOTE_ANIMATION }
}
function module.fflag()
    return getEngineFeatureEngineUGCValidateEmoteAnimationExport() and getFFlagUGCValidateAQEmoteDuration()
end

function module.run(arg1, arg2)
    local aQEmotePartData = getAQEmotePartData(arg2.aqsSummaryData and arg2.aqsSummaryData.Measure_Animation_Duration)
    if not aQEmotePartData or aQEmotePartData.duration_seconds == nil then
        error("Can't find Measure_Animation_Duration.duration_seconds")
    end

    local num1 = tonumber(aQEmotePartData.duration_seconds) or 0
    local var1 = GetFStringUGCValidateCurveAnimationMinLength.asNumber()
    local var2 = GetFStringUGCValidationMaxAnimationLength.asNumber()

    if num1 <= var1 then
        arg1:fail(ErrorSourceStrings.Keys.AQSFail_AnimationTooShort, { duration = tostring(num1), minLength = tostring(var1) })
    elseif var2 < num1 then
        arg1:fail(ErrorSourceStrings.Keys.AQSFail_AnimationTooLong, { duration = tostring(num1), maxLength = tostring(var2) })
    end
end

return module
