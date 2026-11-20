-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T17:51:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent

local _Types = require(scriptParentParentParent.util.Types)
local ValidationEnums = require(scriptParentParentParent.validationSystem.ValidationEnums)
local ErrorSourceStrings = require(scriptParentParentParent.validationSystem.ErrorSourceStrings)

local getFFlagUGCValidateAddObjectValueToAcceptableTypes = require(scriptParentParentParent.flags.getFFlagUGCValidateAddObjectValueToAcceptableTypes)

local module = {
    categories = { ValidationEnums.UploadCategory.EMOTE_ANIMATION, ValidationEnums.UploadCategory.ANIMATION },
    requiredData = { ValidationEnums.SharedDataMember.curveAnimations },
    expectedFailures = {},
    prereqTests = { ValidationEnums.ValidationModule.CurveAnimDataAvailable }
}
local tbl1 = {
    "MarkerCurve",
    "AnimationRigData",
    "Folder",
    "Vector3Curve",
    "EulerRotationCurve",
    "FloatCurve"
}

if getFFlagUGCValidateAddObjectValueToAcceptableTypes() then
    table.insert(tbl1, "ObjectValue")
end

function module.run(arg1, arg2)
    for _, curveAnimation in arg2.curveAnimations do
        for _, descendant in curveAnimation:GetDescendants() do
            local bool1 = false
            for _, value in tbl1 do
                if descendant:IsA(value) then
                    bool1 = true
                    break
                end
            end

            if not bool1 then
                arg1:fail(ErrorSourceStrings.Keys.CurveAnim_InvalidInstanceTypes, { allowedTypes = table.concat(tbl1, ", ") })

                return
            end
        end
    end
end

return module
