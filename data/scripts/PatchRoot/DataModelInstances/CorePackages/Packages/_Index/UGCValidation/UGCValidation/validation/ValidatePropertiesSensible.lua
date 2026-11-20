-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T17:41:29Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local UGCValidationService = game:GetService("UGCValidationService")

local scriptParentParent = script.Parent.Parent

local Analytics = require(scriptParentParent.Analytics)

local util = scriptParentParent.util
local FailureReasonsAccumulator = require(util.FailureReasonsAccumulator)
local _Types = require(util.Types)

local getFIntUGCValidateMaxHSRDataLen = require(scriptParentParent.flags.getFIntUGCValidateMaxHSRDataLen)

local getEngineFeatureEngineUGCValidatePropertiesSensible = require(scriptParentParent.flags.getEngineFeatureEngineUGCValidatePropertiesSensible)

local module = {}

local var1 = nil

local function createPropertyLengthRestrictions() -- Luacid: Inlined by compiler; 1 call site recovered
    if var1 then
        return
    end

    var1 = {
        HiddenSurfaceRemovalAsset = {
            HSRData = getFIntUGCValidateMaxHSRDataLen()
        }
    }
end

function module.resetPropertyLengthRestrictions()
    var1 = nil
end

local function validateIndividual(instance: Instance)
    local var2, properties = UGCValidationService:ValidatePropertiesSensible(instance, var1[instance.ClassName])

    if not var2 then
        return false, { string.format(
                "%s %s has invalid properties: %s. These properties may be numeric values with NaNs or Infs, or strings/BinaryStrings longer than the max number of characters.",
                instance.ClassName,
                instance:GetFullName(),
                table.concat(properties, ", ")
            ) }
    end

    return true
end

function module.validate(arg1, arg2)
    if not getEngineFeatureEngineUGCValidatePropertiesSensible() then
        return true
    end

    local now = tick()
    createPropertyLengthRestrictions()
    local failureReasonsAccumulator = FailureReasonsAccumulator.new()

    local descendants = arg1:GetDescendants()
    table.insert(descendants, arg1)

    for _, descendant in descendants do
        failureReasonsAccumulator:updateReasons(validateIndividual(descendant))
    end

    if not failureReasonsAccumulator:getFinalResults() then
        Analytics.reportFailure(Analytics.ErrorType.validatePropertiesSensible_IncorrectPropertiesFound, nil, arg2)
    end

    Analytics.recordScriptTime(script.Name, now, arg2)
    return failureReasonsAccumulator:getFinalResults()
end

return module
