-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T16:21:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local _Types = require(scriptParentParentParent.util.Types)
local ValidationEnums = require(scriptParentParentParent.validationSystem.ValidationEnums)
local ErrorSourceStrings = require(scriptParentParentParent.validationSystem.ErrorSourceStrings)

local getFIntUGCValidationDynamicHeadMinimumQualityPercent = require(scriptParentParentParent.flags.getFIntUGCValidationDynamicHeadMinimumQualityPercent)

local getFFlagUGCValidateAQScoreWarnings = require(scriptParentParentParent.flags.getFFlagUGCValidateAQScoreWarnings)
local getFFlagUGCValidateAQDisableLegacyDynamicHead = require(scriptParentParentParent.flags.getFFlagUGCValidateAQDisableLegacyDynamicHead)
local getFFlagUGCValidationShadowIsDynamicHead = require(scriptParentParentParent.flags.getFFlagUGCValidationShadowIsDynamicHead)

local module = {
    categories = { ValidationEnums.UploadCategory.DYNAMIC_HEAD }
}

function module.fflag(): boolean
    return not getFFlagUGCValidateAQDisableLegacyDynamicHead()
end

function module.shadowFlag()
    return getFFlagUGCValidationShadowIsDynamicHead() and not getFFlagUGCValidateAQDisableLegacyDynamicHead()
end

module.knownAqsUserErrors = {
    INVALID_LANDMARKS = ErrorSourceStrings.Keys.DynamicHeadCageMisaligned,
    NO_FACS = ErrorSourceStrings.Keys.DynamicHeadNOFACS,
    MISSING_CAGE_INFO = ErrorSourceStrings.Keys.DynamicHeadMISSINGCAGE
}

local tbl1 = {
    left_eye_close = ErrorSourceStrings.Keys.DynamicHeadLeftEyeNotClose,
    right_eye_close = ErrorSourceStrings.Keys.DynamicHeadRightEyeNotClose,
    mouth_open = ErrorSourceStrings.Keys.DynamicHeadMouthNotOpen,
    is_happy = ErrorSourceStrings.Keys.DynamicHeadHappyNotShown,
    is_sad = ErrorSourceStrings.Keys.DynamicHeadSadNotShown
}

function module.run(arg1, arg2)
    local var1 = arg2.aqsSummaryData.Measure_Dynamic_Head.Head or arg2.aqsSummaryData.Measure_Dynamic_Head.Head_Geo

    if var1 == nil then
        error("Measure_Dynamic_Head: AQS summary missing required fields")
        return
    end
    for value, value2 in tbl1 do
        if var1[value] ~= nil and tonumber(var1[value]) <= getFIntUGCValidationDynamicHeadMinimumQualityPercent() / 100 then
            arg1:fail(value2)
        end
    end

    if not getFFlagUGCValidateAQScoreWarnings() or var1.score == nil or tonumber(var1.score) == 100 then
        return
    end
    local aqsWarnDynamicHead = ErrorSourceStrings.Keys.AQSWarn_DynamicHead
    local tbl2 = {
        left_eye_close = string.format("%.2f", tonumber(var1.left_eye_close) or 0),
        right_eye_close = string.format("%.2f", tonumber(var1.right_eye_close) or 0),
        mouth_open = string.format("%.2f", tonumber(var1.mouth_open) or 0),
        is_happy = string.format("%.2f", tonumber(var1.is_happy) or 0),
        is_sad = string.format("%.2f", tonumber(var1.is_sad) or 0)
    }
    arg1:warn(aqsWarnDynamicHead, tbl2)
end

return module
