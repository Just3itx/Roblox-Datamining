-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T17:51:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent

local _Types = require(scriptParentParentParent.util.Types)
local ValidationEnums = require(scriptParentParentParent.validationSystem.ValidationEnums)
local ErrorSourceStrings = require(scriptParentParentParent.validationSystem.ErrorSourceStrings)

local getFIntUGCValidateMaxAnimationFPS = require(scriptParentParentParent.flags.getFIntUGCValidateMaxAnimationFPS)

local GetFStringUGCValidateMaxJointRotationPerPart = require(script.Parent.GetFStringUGCValidateMaxJointRotationPerPart)

local module = {
    categories = { ValidationEnums.UploadCategory.ANIMATION },
    requiredData = { ValidationEnums.SharedDataMember.curveAnimations, ValidationEnums.SharedDataMember.curveAnimComputedFrames },
    expectedFailures = {},
    prereqTests = { ValidationEnums.ValidationModule.CurveAnimDataAvailable }
}
local function validateCurveAnimClip(arg1, arg2)
    local animationName = arg2.animation and arg2.animation:GetFullName()
    local animLength = arg2.animLength
    local tracks = arg2.tracks
    local var1 = 1 / getFIntUGCValidateMaxAnimationFPS()

    local tbl1 = ({})

    for k, track in tracks do
        if not track.rot then
            continue
        end

        local bodyPart = tostring(k)

        if not tbl1[bodyPart] then
            tbl1[bodyPart] = GetFStringUGCValidateMaxJointRotationPerPart.asNumber(bodyPart)
        end
        local var2 = tbl1[bodyPart]
        local num1 = 0

        while num1 <= animLength do
            local _, var3 = track.rot:GetRotationAtTime(num1):ToAxisAngle()
            local num2 = math.deg(math.abs(var3))

            if var2 < num2 then
                local tbl2 = {
                    time = string.format("%.2f", num1),
                    bodyPart = bodyPart,
                    rotation = string.format("%.2f", num2),
                    maxRotation = tostring(var2)
                }
                if animationName then
                    tbl2.animationName = animationName
                end
                arg1:fail(ErrorSourceStrings.Keys.CurveAnim_JointRotationExceeded, tbl2, arg2.animation)

                return
            end

            num1 += var1
        end

        if not (animLength >= 0) then
            continue
        end

        local _, var3 = track.rot:GetRotationAtTime(animLength):ToAxisAngle()
        local num2 = math.deg(math.abs(var3))

        if not (var2 < num2) then
            continue
        end

        local tbl2 = {
            time = string.format("%.2f", animLength),
            bodyPart = bodyPart,
            rotation = string.format("%.2f", num2),
            maxRotation = tostring(var2)
        }
        if animationName then
            tbl2.animationName = animationName
        end
        arg1:fail(ErrorSourceStrings.Keys.CurveAnim_JointRotationExceeded, tbl2, arg2.animation)

        return
    end
end

function module.run(arg1, arg2)
    for _, value in arg2.curveAnimComputedFrames do
        validateCurveAnimClip(arg1, value)
    end
end

return module
