-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:00:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent

local _Types = require(scriptParentParentParent.util.Types)
local ValidationEnums = require(scriptParentParentParent.validationSystem.ValidationEnums)
local ErrorSourceStrings = require(scriptParentParentParent.validationSystem.ErrorSourceStrings)

local getFFlagUGCValidateCurveAnimRotationSpeed = require(scriptParentParentParent.flags.getFFlagUGCValidateCurveAnimRotationSpeed)
local getFIntUGCValidateMaxAnimationFPS = require(scriptParentParentParent.flags.getFIntUGCValidateMaxAnimationFPS)

local getFIntUGCValidationMaxAnimationRotationSpeedPerSecond = require(scriptParentParentParent.flags.getFIntUGCValidationMaxAnimationRotationSpeedPerSecond)
local module = {
    categories = { ValidationEnums.UploadCategory.EMOTE_ANIMATION, ValidationEnums.UploadCategory.ANIMATION },
    requiredData = { ValidationEnums.SharedDataMember.curveAnimations, ValidationEnums.SharedDataMember.curveAnimComputedFrames },
    expectedFailures = {},
    prereqTests = { ValidationEnums.ValidationModule.CurveAnimDataAvailable }
}
local function validateCurveAnimClip(arg1, arg2)
    local animationName = arg2.animation and arg2.animation:GetFullName()
    if not getFFlagUGCValidateCurveAnimRotationSpeed() then
        return
    end

    local animFrames = arg2.animFrames
    local var1 = 1 / getFIntUGCValidateMaxAnimationFPS()

    local fIntUgcValidationMaxAnimationRotationSpeedPerSecond = getFIntUGCValidationMaxAnimationRotationSpeedPerSecond()
    local var2 = fIntUgcValidationMaxAnimationRotationSpeedPerSecond / getFIntUGCValidateMaxAnimationFPS()

    local tbl1 = {}
    for value, value2 in animFrames do
        for bodyPart, value4 in value2 do
            local var3 = tbl1[bodyPart]
            if not var3 then
                continue
            end

            local num1 = math.deg(math.abs((value4:AngleBetween(var3))))
            if not (var2 < num1) then
                continue
            end

            local var4 = (value - 1) * var1
            local var5 = num1 * getFIntUGCValidateMaxAnimationFPS()

            local tbl2 = {
                time = string.format("%.2f", var4),
                bodyPart = bodyPart,
                speed = string.format("%.2f", var5),
                maxSpeed = tostring(fIntUgcValidationMaxAnimationRotationSpeedPerSecond)
            }
            if animationName then
                tbl2.animationName = animationName
            end
            arg1:fail(ErrorSourceStrings.Keys.CurveAnim_RotationTooFast, tbl2, arg2.animation)
            return
        end

        tbl1 = value2
    end
end

function module.run(arg1, arg2)
    for _, value in arg2.curveAnimComputedFrames do
        validateCurveAnimClip(arg1, value)
    end
end

return module
