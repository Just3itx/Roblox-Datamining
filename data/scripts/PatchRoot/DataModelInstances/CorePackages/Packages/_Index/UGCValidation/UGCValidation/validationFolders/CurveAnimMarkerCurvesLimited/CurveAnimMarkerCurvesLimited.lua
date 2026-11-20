-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:00:42Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent

local _Types = require(scriptParentParentParent.util.Types)
local ValidationEnums = require(scriptParentParentParent.validationSystem.ValidationEnums)
local ErrorSourceStrings = require(scriptParentParentParent.validationSystem.ErrorSourceStrings)

local getFIntUGCValidateMaxTotalMarkerCurves = require(scriptParentParentParent.flags.getFIntUGCValidateMaxTotalMarkerCurves)
local module = {
    categories = { ValidationEnums.UploadCategory.EMOTE_ANIMATION, ValidationEnums.UploadCategory.ANIMATION },
    requiredData = { ValidationEnums.SharedDataMember.curveAnimations },
    expectedFailures = {},
    prereqTests = { ValidationEnums.ValidationModule.CurveAnimDataAvailable }
}
function module.run(arg1, arg2)
    local fIntUgcValidateMaxTotalMarkerCurves = getFIntUGCValidateMaxTotalMarkerCurves()

    for _, curveAnimation in arg2.curveAnimations do
        local num1 = 0
        for _, descendant in curveAnimation:GetDescendants() do
            if not descendant:IsA("MarkerCurve") then
                continue
            end

            num1 += 1
            if fIntUgcValidateMaxTotalMarkerCurves < num1 then
                arg1:fail(
                    ErrorSourceStrings.Keys.CurveAnim_TooManyMarkerCurves,
                    {
                        maxAllowed = tostring(fIntUgcValidateMaxTotalMarkerCurves)
                    }
                )
                return
            end
        end
    end
end

return module
