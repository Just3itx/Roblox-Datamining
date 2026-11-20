-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:01:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UGCValidationService = game:GetService("UGCValidationService")

local scriptParentParentParent = script.Parent.Parent.Parent

local _Types = require(scriptParentParentParent.util.Types)
local ValidationEnums = require(scriptParentParentParent.validationSystem.ValidationEnums)
local ErrorSourceStrings = require(scriptParentParentParent.validationSystem.ErrorSourceStrings)

local getFIntFacsJointMaximumDistRatioDirect = require(scriptParentParentParent.flags.getFIntFacsJointMaximumDistRatioDirect)
local getFIntFacsJointMaximumDistRatioAccumulated = require(scriptParentParentParent.flags.getFIntFacsJointMaximumDistRatioAccumulated)

local getEngineFeatureEngineUGCValidateFACSJointTransformsWithinBounds = require(scriptParentParentParent.flags.getEngineFeatureEngineUGCValidateFACSJointTransformsWithinBounds)

local module = {
    categories = { ValidationEnums.UploadCategory.DYNAMIC_HEAD },
    prereqTests = { ValidationEnums.ValidationModule.DynamicHeadFacsPresent },
    requiredData = { ValidationEnums.SharedDataMember.renderMeshesData },
    expectedFailures = {}
}
function module.run(arg1, arg2)
    if not getEngineFeatureEngineUGCValidateFACSJointTransformsWithinBounds() then
        return
    end

    local head = arg2.renderMeshesData.Head

    local success, result = pcall(function()
        return UGCValidationService:GetMaximalJointDistancesWithinFacs(head.editable)
    end)

    if not success then
        arg1:fail(ErrorSourceStrings.Keys.DynHead_JointBoundsCheckFailed)
        return
    end

    local var1, actionName, var3, jointName = unpack(result)
    if getFIntFacsJointMaximumDistRatioDirect() / 100 < var1 then
        arg1:fail(ErrorSourceStrings.Keys.DynHead_JointDirectExceeded, { actionName = actionName })
    end

    if getFIntFacsJointMaximumDistRatioAccumulated() / 100 < var3 then
        arg1:fail(ErrorSourceStrings.Keys.DynHead_JointAccumulatedExceeded, { jointName = jointName })
    end
end

return module
