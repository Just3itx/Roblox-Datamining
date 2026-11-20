-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T17:41:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local Analytics = require(scriptParentParent.Analytics)

local validateDependencies = require(scriptParentParent.validation.validateDependencies)
local validateDescendantMeshMetrics = require(scriptParentParent.validation.validateDescendantMeshMetrics)
local validateTags = require(scriptParentParent.validation.validateTags)
local ValidatePropertiesSensible = require(scriptParentParent.validation.ValidatePropertiesSensible)

local validateWithSchema = require(scriptParentParent.util.validateWithSchema)
local FailureReasonsAccumulator = require(scriptParentParent.util.FailureReasonsAccumulator)
local ValidateMeshPartOnlySkinnedToR15 = require(scriptParentParent.validation.ValidateMeshPartOnlySkinnedToR15)

local getEngineFeatureEngineUGCValidatePropertiesSensible = require(scriptParentParent.flags.getEngineFeatureEngineUGCValidatePropertiesSensible)
local getFFlagUGCValidationEnableR15plusSkinning = require(scriptParentParent.flags.getFFlagUGCValidationEnableR15plusSkinning)

local resetPhysicsData = require(scriptParentParent.util.resetPhysicsData)
local _Types = require(scriptParentParent.util.Types)

local function validateMeshPartBodyPart(arg1, arg2, arg3)
    local assetTypeEnum = arg3.assetTypeEnum

    local var1 = validateWithSchema(arg2, arg1, arg3)
    if not var1.success then
        Analytics.reportFailure(Analytics.ErrorType.validateMeshPartBodyPart_ValidateWithSchema, nil, arg3)
        return false, { string.format("Body part '%s' does not follow R15 schema. The specific issues are: ", arg1.Name), var1.message }
    end

    local var2, var3 = validateDependencies(arg1, arg3, { skipExistenceCheck = true, skipOwnershipCheck = true })
    if not var2 then
        return var2, var3
    end

    local var4, var5 = resetPhysicsData({ arg1 }, arg3)
    if not var4 then
        return false, { var5 }
    end

    if getEngineFeatureEngineUGCValidatePropertiesSensible() then
        local var6, var7 = ValidatePropertiesSensible.validate(arg1, arg3)
        if not var6 then
            return false, var7
        end
    end

    local failureReasonsAccumulator = FailureReasonsAccumulator.new()

    failureReasonsAccumulator:updateReasons(validateDescendantMeshMetrics(arg1, arg3))

    failureReasonsAccumulator:updateReasons(validateTags(arg1, arg3))

    if not getFFlagUGCValidationEnableR15plusSkinning() and assetTypeEnum ~= Enum.AssetType.DynamicHead then
        failureReasonsAccumulator:updateReasons(ValidateMeshPartOnlySkinnedToR15.validateBodyParts(arg1, arg3))
    end

    return failureReasonsAccumulator:getFinalResults()
end

return validateMeshPartBodyPart
