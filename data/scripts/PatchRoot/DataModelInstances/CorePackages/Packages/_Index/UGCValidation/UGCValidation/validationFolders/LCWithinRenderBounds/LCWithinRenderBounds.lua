-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:01:34Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UGCValidationService = game:GetService("UGCValidationService")

local scriptParentParentParent = script.Parent.Parent.Parent

local _Types = require(scriptParentParentParent.util.Types)
local ValidationEnums = require(scriptParentParentParent.validationSystem.ValidationEnums)
local ErrorSourceStrings = require(scriptParentParentParent.validationSystem.ErrorSourceStrings)

local getEngineFeatureEngineUGCValidationLCOOB = require(scriptParentParentParent.flags.getEngineFeatureEngineUGCValidationLCOOB)

local module = {
    categories = { ValidationEnums.UploadCategory.LAYERED_CLOTHING, ValidationEnums.UploadCategory.EYEBROW_EYELASH },
    requiredData = {},
    expectedFailures = {}
}
function module.run(arg1, arg2)
    if arg2.consumerConfig.consumerEnv == "IEC" then
        return
    end

    local rootInstance = arg2.rootInstance

    if not getEngineFeatureEngineUGCValidationLCOOB() then
        arg1:fail(ErrorSourceStrings.Keys.LCWithinRenderBounds_EngineFeatureDisabled, { accessoryName = rootInstance.Name })

        return
    end
    local handle = rootInstance:FindFirstChild("Handle")
    if not handle then
        arg1:fail(ErrorSourceStrings.Keys.LCWithinRenderBounds_NoHandle, { accessoryName = rootInstance.Name })

        return
    end

    local wrapLayer = handle:FindFirstChildWhichIsA("WrapLayer")
    if not wrapLayer then
        arg1:fail(ErrorSourceStrings.Keys.LCWithinRenderBounds_NoWrapLayer, { accessoryName = rootInstance.Name })
        return
    end

    if wrapLayer.MaxSize ~= Vector3.new(0, 0, 0) then
        arg1:fail(ErrorSourceStrings.Keys.LCWithinRenderBounds_NonZeroMaxSize, {})
        return
    end

    if wrapLayer.Offset ~= Vector3.new(0, 0, 0) then
        arg1:fail(ErrorSourceStrings.Keys.LCWithinRenderBounds_NonZeroOffset, {})
        return
    end

    if UGCValidationService:IsDeformedLayeredClothingOutOfRenderBounds(rootInstance) then
        arg1:fail(ErrorSourceStrings.Keys.LCWithinRenderBounds_OutOfBounds, { accessoryName = rootInstance.Name })
    end
end

return module
