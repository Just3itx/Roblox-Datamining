-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:01:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local _Types = require(scriptParentParentParent.util.Types)
local Constants = require(scriptParentParentParent.Constants)
local ValidationEnums = require(scriptParentParentParent.validationSystem.ValidationEnums)
local CreateExpectedSchema = require(scriptParentParentParent.util.CreateExpectedSchema)
local validateInstanceTreeAgainstSchema = require(scriptParentParentParent.util.validateInstanceTreeAgainstSchema)

local ErrorSourceStrings = require(scriptParentParentParent.validationSystem.ErrorSourceStrings)

local getEngineFeatureEngineUGCValidateInstanceTreesEquivalent = require(scriptParentParentParent.flags.getEngineFeatureEngineUGCValidateInstanceTreesEquivalent)
local shouldValidateR15LegacyDuplicate = require(scriptParentParentParent.util.shouldValidateR15LegacyDuplicate)
local module = {
    categories = Constants.AllUploadCategories,
    requiredData = {
        ValidationEnums.SharedDataMember.entrypointInput,
        ValidationEnums.SharedDataMember.rootInstance,
        ValidationEnums.SharedDataMember.uploadCategory,
        ValidationEnums.SharedDataMember.uploadEnum,
        ValidationEnums.SharedDataMember.consumerConfig
    }
}

function module.run(arg1, arg2)
    local rootInstance = arg2.rootInstance
    local uploadCategory = arg2.uploadCategory
    local uploadEnum = arg2.uploadEnum

    if rootInstance == nil then
        arg1:fail(ErrorSourceStrings.Keys.SelectionCountNotOne)
        return
    end

    local var1

    if uploadEnum.bundleType then
        if uploadEnum.bundleType == Enum.BundleType.Animations then
            var1 = CreateExpectedSchema.generateAnimationPackBundleSchema()
        else
            local entrypointInput = arg2.entrypointInput
            var1 = CreateExpectedSchema.generateBundleSchema(entrypointInput)
        end
    else
        var1 = CreateExpectedSchema.generateAssetSchema(uploadCategory, uploadEnum.assetType, rootInstance)
    end

    validateInstanceTreeAgainstSchema(rootInstance, var1, arg1)

    if not getEngineFeatureEngineUGCValidateInstanceTreesEquivalent() or not shouldValidateR15LegacyDuplicate(arg2) then
        return
    end

    if arg2.r15LegacyDuplicateRoot == nil then
        arg1:fail(ErrorSourceStrings.Keys.FolderStructureMismatch)
        return
    end
    arg1:setReportingRoot(arg2.r15LegacyDuplicateRoot)
    validateInstanceTreeAgainstSchema(arg2.r15LegacyDuplicateRoot, var1, arg1)
    arg1:setReportingRoot(rootInstance)
end

return module
