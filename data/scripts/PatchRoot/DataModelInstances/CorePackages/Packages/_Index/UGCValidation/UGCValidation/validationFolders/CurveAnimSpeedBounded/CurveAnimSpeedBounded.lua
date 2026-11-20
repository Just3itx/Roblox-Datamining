-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:00:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent

local _Types = require(scriptParentParentParent.util.Types)
local ValidationEnums = require(scriptParentParentParent.validationSystem.ValidationEnums)
local ErrorSourceStrings = require(scriptParentParentParent.validationSystem.ErrorSourceStrings)

local GetFStringUGCValidationMaxAnimationDeltas = require(scriptParentParentParent.flags.GetFStringUGCValidationMaxAnimationDeltas)
local getFIntUGCValidateMaxAnimationFPS = require(scriptParentParentParent.flags.getFIntUGCValidateMaxAnimationFPS)
local module = {
    categories = { ValidationEnums.UploadCategory.EMOTE_ANIMATION, ValidationEnums.UploadCategory.ANIMATION },
    requiredData = { ValidationEnums.SharedDataMember.curveAnimations, ValidationEnums.SharedDataMember.curveAnimComputedFrames },
    expectedFailures = {},
    prereqTests = { ValidationEnums.ValidationModule.CurveAnimDataAvailable }
}
local function validateCurveAnimClip(arg1, arg2)
    local animationName = arg2.animation and arg2.animation:GetFullName()
    local animFrames = arg2.animFrames
    local var1 = 1 / getFIntUGCValidateMaxAnimationFPS()

    local var2 = var1 / (1 / 30)
    local var3 = GetFStringUGCValidationMaxAnimationDeltas.asNumber() * var2

    local var4 = GetFStringUGCValidationMaxAnimationDeltas.asNumber() * 30

    local tbl1 = {}
    for value, value2 in animFrames do
        for bodyPart, value4 in value2 do
            local var5 = tbl1[bodyPart]
            if not var5 then
                continue
            end

            local magnitude = (value4.Position - var5.Position).Magnitude
            if not (var3 < magnitude) then
                continue
            end

            local var6 = (value - 1) * var1
            local var7 = magnitude / var2 * 30

            local tbl2 = {
                time = string.format("%.2f", var6),
                bodyPart = bodyPart,
                speed = string.format("%.2f", var7),
                maxSpeed = string.format("%.2f", var4)
            }
            if animationName then
                tbl2.animationName = animationName
            end
            arg1:fail(ErrorSourceStrings.Keys.CurveAnim_SpeedTooFast, tbl2, arg2.animation)
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
