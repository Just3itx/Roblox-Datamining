-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:00:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent

local Constants = require(scriptParentParentParent.Constants)
local _Types = require(scriptParentParentParent.util.Types)
local ValidationEnums = require(scriptParentParentParent.validationSystem.ValidationEnums)
local ErrorSourceStrings = require(scriptParentParentParent.validationSystem.ErrorSourceStrings)

local GetFStringUGCValidateMaxAnimationMovementPerPart = require(scriptParentParentParent.flags.GetFStringUGCValidateMaxAnimationMovementPerPart)
local module = {
    categories = { ValidationEnums.UploadCategory.EMOTE_ANIMATION, ValidationEnums.UploadCategory.ANIMATION },
    requiredData = { ValidationEnums.SharedDataMember.curveAnimations, ValidationEnums.SharedDataMember.curveAnimComputedFrames },
    expectedFailures = {},
    prereqTests = { ValidationEnums.ValidationModule.CurveAnimDataAvailable }
}
local function validateCurveAnimClip(arg1, arg2)
    local animationName = arg2.animation and arg2.animation:GetFullName()
    local tbl1 = ({})
    for _, value in arg2.positionMagnitudeFrames do
        for bodyPart, value3 in value do
            if bodyPart == Constants.NAMED_R15_BODY_PARTS.LowerTorso then
                continue
            end

            if not tbl1[bodyPart] then
                tbl1[bodyPart] = GetFStringUGCValidateMaxAnimationMovementPerPart.asNumber(bodyPart)
            end
            if not (tbl1[bodyPart] < value3) then
                continue
            end

            local tbl2 = {
                bodyPart = bodyPart,
                maxMovement = tostring(tbl1[bodyPart])
            }
            if animationName then
                tbl2.animationName = animationName
            end
            arg1:fail(ErrorSourceStrings.Keys.CurveAnim_PositionSeparation, tbl2, arg2.animation)
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
