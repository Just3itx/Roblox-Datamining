-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T17:51:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent

local _Types = require(scriptParentParentParent.util.Types)
local ValidationEnums = require(scriptParentParentParent.validationSystem.ValidationEnums)
local ErrorSourceStrings = require(scriptParentParentParent.validationSystem.ErrorSourceStrings)

local GetFStringUGCValidateAnimationHeightTol = require(scriptParentParentParent.flags.GetFStringUGCValidateAnimationHeightTol)
local GetFStringUGCValidationMaxAnimationBounds = require(scriptParentParentParent.flags.GetFStringUGCValidationMaxAnimationBounds)
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
    local animLength = arg2.animLength
    local var1 = 1 / getFIntUGCValidateMaxAnimationFPS()

    local var2 = GetFStringUGCValidateAnimationHeightTol.asNumber()
    local var3 = GetFStringUGCValidationMaxAnimationBounds.asNumber()

    for value, value2 in animFrames do
        for bodyPart, value4 in value2 do
            if value4.Position.Y < var2 then
                local tbl1 = {
                    time = string.format("%.2f", math.min(animLength, (value - 1) * var1)),
                    bodyPart = bodyPart,
                    height = string.format("%.2f", value4.Position.Y),
                    minHeight = GetFStringUGCValidateAnimationHeightTol.asString()
                }
                if animationName then
                    tbl1.animationName = animationName
                end
                arg1:fail(ErrorSourceStrings.Keys.CurveAnim_PartTooLow, tbl1, arg2.animation)
                return
            end
            if not (var3 < value4.Position.Magnitude) then
                continue
            end

            local tbl1 = {
                time = string.format("%.2f", math.min(animLength, (value - 1) * var1)),
                bodyPart = bodyPart,
                distance = string.format("%.2f", value4.Position.Magnitude),
                maxDistance = GetFStringUGCValidationMaxAnimationBounds.asString()
            }
            if animationName then
                tbl1.animationName = animationName
            end
            arg1:fail(ErrorSourceStrings.Keys.CurveAnim_PartTooFar, tbl1, arg2.animation)
            return
        end
    end
end

function module.run(arg1, arg2)
    for _, value in arg2.curveAnimComputedFrames do
        validateCurveAnimClip(arg1, value)
    end
end

return module
