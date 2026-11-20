-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T17:50:38Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent

local Constants = require(scriptParentParentParent.Constants)
local _Types = require(scriptParentParentParent.util.Types)
local ValidationEnums = require(scriptParentParentParent.validationSystem.ValidationEnums)
local ErrorSourceStrings = require(scriptParentParentParent.validationSystem.ErrorSourceStrings)

local getEngineFeatureEngineUGCValidateInstanceTreesEquivalent = require(scriptParentParentParent.flags.getEngineFeatureEngineUGCValidateInstanceTreesEquivalent)

local module = {
    categories = Constants.AllUploadCategories,
    requiredData = { ValidationEnums.SharedDataMember.entrypointInput },
    fflag = getEngineFeatureEngineUGCValidateInstanceTreesEquivalent
}

local function collectAllInstances(entrypointInput)
    local result = {}
    for _, value in entrypointInput do
        local tbl1 = {}
        if typeof(value) == "Instance" then
            table.insert(tbl1, value)
        elseif typeof(value) == "table" and value.allSelectedInstances ~= nil then
            tbl1 = value.allSelectedInstances
        end

        for _, value2 in tbl1 do
            table.insert(result, value2)
            for _, descendant in value2:GetDescendants() do
                table.insert(result, descendant)
            end
        end
    end

    return result
end

function module.run(arg1, arg2)
    for _, value in collectAllInstances(arg2.entrypointInput) do
        if value.Archivable ~= false then
            continue
        end

        local propertyValueInvalid = ErrorSourceStrings.Keys.PropertyValueInvalid
        local tbl1 = {
            PropertyName = "Archivable",
            InstancePath = value:GetFullName(),
            ComparisonMethod = Constants.COMPARISON_METHODS.EXACT_EQ,
            ExpectedValue = "true"
        }
        arg1:fail(propertyValueInvalid, tbl1)
    end
end

return module
