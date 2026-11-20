-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T17:51:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent

local _Types = require(scriptParentParentParent.util.Types)
local ValidationEnums = require(scriptParentParentParent.validationSystem.ValidationEnums)
local ErrorSourceStrings = require(scriptParentParentParent.validationSystem.ErrorSourceStrings)

local module = {
    categories = { ValidationEnums.UploadCategory.EMOTE_ANIMATION, ValidationEnums.UploadCategory.ANIMATION },
    requiredData = { ValidationEnums.SharedDataMember.curveAnimations, ValidationEnums.SharedDataMember.curveAnimComputedFrames },
    expectedFailures = {},
    prereqTests = { ValidationEnums.ValidationModule.CurveAnimDataAvailable }
}
local function validateCurveAnimClip(arg1, arg2)
    local animationName = arg2.animation and arg2.animation:GetFullName()
    for _, track in arg2.tracks do
        if track.pos or track.rot then
            return
        end
    end
    arg1:fail(ErrorSourceStrings.Keys.CurveAnim_NoJointManipulation, { animationName = animationName }, arg2.animation)
end

function module.run(arg1, arg2)
    for _, value in arg2.curveAnimComputedFrames do
        validateCurveAnimClip(arg1, value)
    end
end

return module
