-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T17:41:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local _Types = require(scriptParentParent.util.Types)

local validateTags = require(scriptParentParent.validation.validateTags)
local validateSingleInstance = require(scriptParentParent.validation.validateSingleInstance)
local validateDependencies = require(scriptParentParent.validation.validateDependencies)

local FailureReasonsAccumulator = require(scriptParentParent.util.FailureReasonsAccumulator)
local getFFlagUGCValidateMakeupCategoryParity = require(scriptParentParent.flags.getFFlagUGCValidateMakeupCategoryParity)

local function validateMakeupAsset(arg1)
    local instances = arg1.instances

    if not getFFlagUGCValidateMakeupCategoryParity() then
        local var1, var2 = validateSingleInstance(instances, arg1)
        if not var1 then
            return false, var2
        end
    end

    local var1 = instances[1]

    local var2, var3 = validateDependencies(var1, arg1, { skipExistenceCheck = true, skipOwnershipCheck = true })
    if not var2 then
        return false, var3
    end

    local failureReasonsAccumulator = FailureReasonsAccumulator.new()

    if not getFFlagUGCValidateMakeupCategoryParity() then
        failureReasonsAccumulator:updateReasons(validateTags(var1, arg1))
    end

    return failureReasonsAccumulator:getFinalResults()
end

return validateMakeupAsset
