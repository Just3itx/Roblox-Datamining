-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T16:21:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local _Types = require(scriptParentParentParent.util.Types)
local ValidationEnums = require(scriptParentParentParent.validationSystem.ValidationEnums)
local ErrorSourceStrings = require(scriptParentParentParent.validationSystem.ErrorSourceStrings)
local readAQSummaryNumber = require(scriptParentParentParent.util.readAQSummaryNumber)

local getFFlagUGCValidateAQDynamicHeadMLHybrid = require(scriptParentParentParent.flags.getFFlagUGCValidateAQDynamicHeadMLHybrid)

local getFFlagUGCValidateAQDynamicHeadMLHybridShadow = require(scriptParentParentParent.flags.getFFlagUGCValidateAQDynamicHeadMLHybridShadow)

local getFFlagUGCValidateAQDynamicHeadMLHybridNewFacsMessages = require(scriptParentParentParent.flags.getFFlagUGCValidateAQDynamicHeadMLHybridNewFacsMessages)

local getFFlagUGCValidateAQDynamicHeadMLHybridWarnings = require(scriptParentParentParent.flags.getFFlagUGCValidateAQDynamicHeadMLHybridWarnings)

local getFIntUGCValidationDynamicHeadMLEyesMinScorePerMillion = require(scriptParentParentParent.flags.getFIntUGCValidationDynamicHeadMLEyesMinScorePerMillion)

local getFIntUGCValidationDynamicHeadMLMouthMinScorePerMillion = require(scriptParentParentParent.flags.getFIntUGCValidationDynamicHeadMLMouthMinScorePerMillion)

local getFIntUGCValidationDynamicHeadMLAnimationMinScorePerMillion = require(scriptParentParentParent.flags.getFIntUGCValidationDynamicHeadMLAnimationMinScorePerMillion)

local getFIntUGCValidationDynamicHeadMinimumQualityPercent = require(scriptParentParentParent.flags.getFIntUGCValidationDynamicHeadMinimumQualityPercent)

local tbl1 = {
    step2a_left_eye_landmark_valid = ErrorSourceStrings.Keys.DynamicHeadCageMisalignedLeftEye,
    step2a_right_eye_landmark_valid = ErrorSourceStrings.Keys.DynamicHeadCageMisalignedRightEye,
    step2a_mouth_landmark_valid = ErrorSourceStrings.Keys.DynamicHeadCageMisalignedMouth
}

local tbl2 = {
    step2b_deformation_left_eye_close = ErrorSourceStrings.Keys.DynamicHeadLeftEyeNotClose,
    step2b_deformation_right_eye_close = ErrorSourceStrings.Keys.DynamicHeadRightEyeNotClose,
    step2b_deformation_mouth_open = ErrorSourceStrings.Keys.DynamicHeadMouthNotOpen,
    step2b_deformation_happy = ErrorSourceStrings.Keys.DynamicHeadHappyNotShown,
    step2b_deformation_sad = ErrorSourceStrings.Keys.DynamicHeadSadNotShown
}

local tbl3 = {
    step2b_deformation_left_eye_close = ErrorSourceStrings.Keys.FacsDeformation_LeftEyeNotClose,
    step2b_deformation_right_eye_close = ErrorSourceStrings.Keys.FacsDeformation_RightEyeNotClose,
    step2b_deformation_mouth_open = ErrorSourceStrings.Keys.FacsDeformation_MouthNotOpen,
    step2b_deformation_happy = ErrorSourceStrings.Keys.FacsDeformation_HappyNotShown,
    step2b_deformation_sad = ErrorSourceStrings.Keys.FacsDeformation_SadNotShown
}

local module = {
    categories = { ValidationEnums.UploadCategory.DYNAMIC_HEAD },
    fflag = getFFlagUGCValidateAQDynamicHeadMLHybrid,
    shadowFlag = getFFlagUGCValidateAQDynamicHeadMLHybridShadow,
    knownAqsUserErrors = {
        MISSING_CAGE_INFO = ErrorSourceStrings.Keys.DynamicHeadMISSINGCAGE,
        NO_FACS = ErrorSourceStrings.Keys.DynamicHeadNOFACS
    }
}
local function requireStageCompleted(tbl4, str1: string) -- Luacid: unused: defined but never referenced
    local var1 = tbl4[`{str1}_status`]
    if var1 ~= "completed" then
        error(
            `Measure_Dynamic_Head_ML_Hybrid: {str1} is {tostring(var1)}, expected completed. ` .. "A threshold here may be looser than the asset-quality cutoff."
        )
    end
end

local function meetsPerMillionCutoff(num1: number, num2: number): boolean -- Luacid: Inlined by compiler; 3 call sites recovered
    return num2 / 1000000 <= num1
end

local function warnExpressionQuality(arg1, tbl4)
    if tbl4.step2b_status ~= "completed" or tbl4.score == nil or tonumber(tbl4.score) == 100 then
        return
    end

    local function formatMetric(str1: string) -- Luacid: Inlined by compiler; 5 call sites recovered
        return string.format("%.2f", tonumber(tbl4[str1]) or 0)
    end
    arg1:warn(ErrorSourceStrings.Keys.AQSWarn_DynamicHead, {
        left_eye_close = formatMetric("step2b_deformation_left_eye_close"),
        right_eye_close = formatMetric("step2b_deformation_right_eye_close"),
        mouth_open = formatMetric("step2b_deformation_mouth_open"),
        is_happy = formatMetric("step2b_deformation_happy"),
        is_sad = formatMetric("step2b_deformation_sad")
    })
end

local tbl4 = {
    function(arg1, tbl4): boolean -- name: checkFacialFeatures
        local step1Status = tbl4.step1_status
        if step1Status ~= "completed" then
            error(
                `Measure_Dynamic_Head_ML_Hybrid: step1 is {tostring(step1Status)}, expected completed. ` .. "A threshold here may be looser than the asset-quality cutoff."
            )
        end

        local bool1

        if meetsPerMillionCutoff(
            readAQSummaryNumber(tbl4, "step1_has_eyes_score", "Measure_Dynamic_Head_ML_Hybrid", 0, 1),
            (getFIntUGCValidationDynamicHeadMLEyesMinScorePerMillion())
        ) then
            bool1 = true
        else
            arg1:fail(ErrorSourceStrings.Keys.FacialFeaturePresence_EyesMissing)
            bool1 = false
        end

        if not meetsPerMillionCutoff(
            readAQSummaryNumber(tbl4, "step1_has_mouth_score", "Measure_Dynamic_Head_ML_Hybrid", 0, 1),
            (getFIntUGCValidationDynamicHeadMLMouthMinScorePerMillion())
        ) then
            arg1:fail(ErrorSourceStrings.Keys.FacialFeaturePresence_MouthMissing)
            bool1 = false
        end

        return bool1
    end,
    function(arg1, tbl4): boolean -- name: checkCageLandmarks
        local step2aStatus = tbl4.step2a_status
        if step2aStatus ~= "completed" then
            error(
                `Measure_Dynamic_Head_ML_Hybrid: step2a is {tostring(step2aStatus)}, expected completed. ` .. "A threshold here may be looser than the asset-quality cutoff."
            )
        end

        local bool1 = true

        for value, value2 in tbl1 do
            local var1 = tbl4[value]
            if var1 == "0" then
                arg1:fail(value2)
                bool1 = false
            elseif var1 ~= "1" then
                error(`Measure_Dynamic_Head_ML_Hybrid: {value} is not "1" or "0": {tostring(var1)}`)
            end
        end

        return bool1
    end,
    function(arg1, tbl4): boolean -- name: checkFacsDeformation
        local step2bStatus = tbl4.step2b_status
        if step2bStatus ~= "completed" then
            error(
                `Measure_Dynamic_Head_ML_Hybrid: step2b is {tostring(step2bStatus)}, expected completed. ` .. "A threshold here may be looser than the asset-quality cutoff."
            )
        end

        local bool1 = true

        local var1 = getFIntUGCValidationDynamicHeadMinimumQualityPercent() / 100

        for value, value2 in if getFFlagUGCValidateAQDynamicHeadMLHybridNewFacsMessages() then tbl3 else tbl2 do
            if readAQSummaryNumber(tbl4, value, "Measure_Dynamic_Head_ML_Hybrid") <= var1 then
                arg1:fail(value2)
                bool1 = false
            end
        end

        return bool1
    end,
    function(arg1, tbl4): boolean -- name: checkAnimationQuality
        local step3Status = tbl4.step3_status
        if step3Status ~= "completed" then
            error(
                `Measure_Dynamic_Head_ML_Hybrid: step3 is {tostring(step3Status)}, expected completed. ` .. "A threshold here may be looser than the asset-quality cutoff."
            )
        end

        if meetsPerMillionCutoff(
            readAQSummaryNumber(tbl4, "step3_animation_pass_score", "Measure_Dynamic_Head_ML_Hybrid", 0, 1),
            (getFIntUGCValidationDynamicHeadMLAnimationMinScorePerMillion())
        ) then
            return true
        end

        arg1:fail(ErrorSourceStrings.Keys.RenderedAnimation_RequiredExpressionsMissing)
        return false
    end
}

function module.run(arg1, arg2)
    local measureDynamicHeadMlHybrid = arg2.aqsSummaryData.Measure_Dynamic_Head_ML_Hybrid
    if measureDynamicHeadMlHybrid == nil then
        error("Measure_Dynamic_Head_ML_Hybrid: missing AQS summary data")
    end

    local num1 = 0
    for value, value2 in measureDynamicHeadMlHybrid do
        if value == "measurement_score" then
            continue
        end

        num1 += 1

        for _, value3 in tbl4 do
            if not value3(arg1, value2) then
                break
            end
        end

        if getFFlagUGCValidateAQDynamicHeadMLHybridWarnings() then
            warnExpressionQuality(arg1, value2)
        end
    end

    if num1 == 0 then
        error("Measure_Dynamic_Head_ML_Hybrid: AQS summary has no head mesh")
    end
end

return module
