-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T17:41:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local util = scriptParentParent.util
local _Types = require(util.Types)
local createEmoteSchema = require(util.createEmoteSchema)
local FailureReasonsAccumulator = require(util.FailureReasonsAccumulator)
local validation = scriptParentParent.validation
local validateSingleInstance = require(validation.validateSingleInstance)
local validateInstanceTree = require(validation.validateInstanceTree)
local validateTags = require(validation.validateTags)
local validateDependencies = require(validation.validateDependencies)
local ValidatePropertiesSensible = require(validation.ValidatePropertiesSensible)

local getEngineFeatureEngineUGCValidatePropertiesSensible = require(scriptParentParent.flags.getEngineFeatureEngineUGCValidatePropertiesSensible)

local module = {}

function module.validateStructure(arg1)
    local var1, var2 = validateSingleInstance(arg1.instances or {}, arg1)
    if not var1 then
        return false, var2
    end

    local var3 = arg1.instances[1]

    local var4, var5 = validateInstanceTree(createEmoteSchema(), var3, arg1)
    if not var4 then
        return false, var5
    end

    return true, nil, var3
end

function module.validate(arg1)
    local var1, var2, var3 = module.validateStructure(arg1)
    if not var1 then
        return false, var2
    end

    if getEngineFeatureEngineUGCValidatePropertiesSensible() then
        local var4, var5 = ValidatePropertiesSensible.validate(var3, arg1)
        if not var4 then
            return false, var5
        end
    end

    local var4, var5 = validateDependencies(var3, arg1, { skipExistenceCheck = true, skipOwnershipCheck = true })
    if not var4 then
        return false, var5
    end

    local failureReasonsAccumulator = FailureReasonsAccumulator.new()
    failureReasonsAccumulator:updateReasons(validateTags(var3, arg1))

    return failureReasonsAccumulator:getFinalResults()
end

return module
