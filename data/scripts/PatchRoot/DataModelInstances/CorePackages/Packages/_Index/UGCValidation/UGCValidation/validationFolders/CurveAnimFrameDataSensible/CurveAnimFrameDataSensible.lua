-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T17:51:18Z
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
local function areNumbersGood(...)
    local function isNaN(num1: number): boolean -- Luacid: Inlined by compiler; 1 call site recovered
        return num1 ~= num1
    end

    local function isInfinite(num1: number): boolean -- Luacid: Inlined by compiler; 1 call site recovered
        return num1 == math.huge or num1 == -math.huge
    end

    for _, value in { ... } do
        if isNaN(value) then
            return false
        end

        if isInfinite(value) then
            return false
        end
    end
    return true
end

local function validateCurveAnimClip(arg1, arg2)
    local animationName = arg2.animation and arg2.animation:GetFullName()
    for _, value in arg2.animFrames do
        for _, value2 in value do
            if not areNumbersGood(value2:GetComponents()) then
                arg1:fail(ErrorSourceStrings.Keys.CurveAnim_InvalidNumericalData, { animationName = animationName }, arg2.animation)

                return
            end
        end
    end

    for _, value in arg2.positionMagnitudeFrames do
        for _, value2 in value do
            if not areNumbersGood(value2) then
                arg1:fail(ErrorSourceStrings.Keys.CurveAnim_InvalidNumericalData, { animationName = animationName }, arg2.animation)

                return
            end
        end
    end
end

function module.run(arg1, arg2)
    for _, value in arg2.curveAnimComputedFrames do
        validateCurveAnimClip(arg1, value)
    end
end

return module
