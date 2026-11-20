-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:00:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent

local _Types = require(scriptParentParentParent.util.Types)
local ValidationEnums = require(scriptParentParentParent.validationSystem.ValidationEnums)
local ErrorSourceStrings = require(scriptParentParentParent.validationSystem.ErrorSourceStrings)

local GetFStringUGCValidationMaxAnimationLength = require(scriptParentParentParent.flags.GetFStringUGCValidationMaxAnimationLength)
local GetFStringUGCValidateFrameDeltaKeyTimeTol = require(scriptParentParentParent.flags.GetFStringUGCValidateFrameDeltaKeyTimeTol)
local getFIntUGCValidateMaxAnimationFPS = require(scriptParentParentParent.flags.getFIntUGCValidateMaxAnimationFPS)
local getFIntUGCValidateMaxMarkerCurveValueLength = require(scriptParentParentParent.flags.getFIntUGCValidateMaxMarkerCurveValueLength)
local getFIntUGCValidateMaxTotalInternalMarkers = require(scriptParentParentParent.flags.getFIntUGCValidateMaxTotalInternalMarkers)
local module = {
    categories = { ValidationEnums.UploadCategory.EMOTE_ANIMATION, ValidationEnums.UploadCategory.ANIMATION },
    requiredData = { ValidationEnums.SharedDataMember.curveAnimations },
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

function module.run(arg1, arg2)
    local var1 = 1 / getFIntUGCValidateMaxAnimationFPS() * GetFStringUGCValidateFrameDeltaKeyTimeTol.asNumber()
    local num1 = math.ceil(1 / var1 * GetFStringUGCValidationMaxAnimationLength.asNumber())

    for _, curveAnimation in arg2.curveAnimations do
        for _, descendant in curveAnimation:GetDescendants() do
            if descendant:IsA("MarkerCurve") then
                local markers = descendant:GetMarkers()
                local num2 = math.min(getFIntUGCValidateMaxTotalInternalMarkers(), num1)
                if num2 < #markers then
                    local curveAnimTooManyMarkers = ErrorSourceStrings.Keys.CurveAnim_TooManyMarkers
                    local tbl1 = {
                        count = tostring(#markers),
                        maxAllowed = tostring(num2)
                    }
                    arg1:fail(curveAnimTooManyMarkers, tbl1)

                    return
                end

                for _, marker in markers do
                    if not marker.Time
                        or not areNumbersGood(marker.Time)
                        or not marker.Value
                        or #marker.Value > getFIntUGCValidateMaxMarkerCurveValueLength()
                    then
                        arg1:fail(ErrorSourceStrings.Keys.CurveAnim_InvalidMarkerData)
                        return
                    end
                end
            elseif descendant:IsA("FloatCurve") then
                local keys = descendant:GetKeys()
                if num1 < #keys then
                    arg1:fail(ErrorSourceStrings.Keys.CurveAnim_TooManyKeys, { maxAllowed = tostring(num1) })

                    return
                end

                local time = nil
                for _, key in keys do
                    if not (key.Time and areNumbersGood(key.Time) and key.Value and areNumbersGood(key.Value)) then
                        arg1:fail(ErrorSourceStrings.Keys.CurveAnim_InvalidCurveData)
                        return
                    end

                    if time then
                        if time + var1 > key.Time then
                            local var2 = if descendant.Parent.Parent then descendant.Parent.Parent.Name else "-"
                            arg1:fail(ErrorSourceStrings.Keys.CurveAnim_KeysTooClose, {
                                curvePath = `{var2}.{descendant.Parent.Name}.{descendant.Name}`,
                                maxFPS = tostring(getFIntUGCValidateMaxAnimationFPS())
                            })
                            return
                        end
                    elseif key.Time < 0 then
                        local var2 = if descendant.Parent.Parent then descendant.Parent.Parent.Name else "-"
                        arg1:fail(
                            ErrorSourceStrings.Keys.CurveAnim_NegativeKeyTime,
                            {
                                curvePath = `{var2}.{descendant.Parent.Name}.{descendant.Name}`
                            }
                        )
                        return
                    end
                    time = key.Time
                end
            end
        end
    end
end
return module
