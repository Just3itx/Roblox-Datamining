-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T17:50:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent

local Constants = require(scriptParentParentParent.Constants)
local _Types = require(scriptParentParentParent.util.Types)
local ValidationEnums = require(scriptParentParentParent.validationSystem.ValidationEnums)
local ErrorSourceStrings = require(scriptParentParentParent.validationSystem.ErrorSourceStrings)

local getFFlagUGCValidateCurveAnimAttributes = require(scriptParentParentParent.flags.getFFlagUGCValidateCurveAnimAttributes)
local getFFlagUGCValidateMakeupCategoryParity = require(scriptParentParentParent.flags.getFFlagUGCValidateMakeupCategoryParity)
local getFFlagUGCValidateR15FixedAttributes = require(scriptParentParentParent.flags.getFFlagUGCValidateR15FixedAttributes)

game:DefineFastFlag("UGCValidateAllowEmoteAttributes", false)

local module = {}

local tbl1 = {
    [Constants.EmoteIsUGCAttributeName] = true,
    [Constants.EmoteMaxPartTranslationAttributeName] = true
}

module.categories = if getFFlagUGCValidateMakeupCategoryParity() then Constants.AllAssetUploadCategories else Constants.AllAssetUploadCategoriesIncludingMakeup

module.requiredData = { ValidationEnums.SharedDataMember.rootInstance, ValidationEnums.SharedDataMember.consumerConfig, ValidationEnums.SharedDataMember.hsrAssets }

if getFFlagUGCValidateCurveAnimAttributes() then
    table.insert(module.requiredData, ValidationEnums.SharedDataMember.curveAnimations)
end
module.expectedFailures = {}

local function hasOnlyAllowedAttribute(attributes, bool1: boolean, tbl2)
    for value, value2 in attributes do
        if bool1 and value == Constants.AlternateMeshIdAttributeName or tbl2 and tbl2[value] then
            continue
        end

        if value ~= Constants.GUIDAttributeName then
            return false
        end

        if typeof(value2) ~= "string" then
            return false
        end

        if string.len(value2) > Constants.GUIDAttributeMaxLength then
            return false
        end
    end
    return true
end

local function reportInstanceWithDisallowedAttributes(arg1, arg2) -- Luacid: Inlined by compiler; 1 call site recovered
    arg1:fail(ErrorSourceStrings.Keys.NoAttributes, { RootInstanceName = arg2.Name, InstanceNameList = arg2:GetFullName() })
end

local function walkInstanceTree(arg1, arg2, bool1: boolean, tbl2)
    if not hasOnlyAllowedAttribute(arg2:GetAttributes(), bool1, tbl2) then
        reportInstanceWithDisallowedAttributes(arg1, arg2)
    end

    for _, descendant in arg2:GetDescendants() do
        if bool1 and descendant:GetAttribute(Constants.AlternateMeshIdAttributeName) or next(descendant:GetAttributes()) == nil then
            continue
        end

        local noAttributes = ErrorSourceStrings.Keys.NoAttributes
        local tbl3 = {
            RootInstanceName = descendant.Name,
            InstanceNameList = descendant:GetFullName()
        }
        arg1:fail(noAttributes, tbl3)
    end
end

function module.run(arg1, arg2)
    local bool1 = arg2.consumerConfig.consumerEnv == ValidationEnums.ConsumerEnv.IEC

    walkInstanceTree(arg1, arg2.rootInstance, bool1)

    if getFFlagUGCValidateR15FixedAttributes()
        and arg2.consumerConfig.consumerEnv == ValidationEnums.ConsumerEnv.Backend
        and arg2.r15LegacyDuplicateRoot ~= nil
    then
        walkInstanceTree(arg1, arg2.r15LegacyDuplicateRoot, bool1)
    end

    for _, hsrAsset in arg2.hsrAssets do
        for _, value in hsrAsset do
            walkInstanceTree(arg1, value, bool1)
        end
    end

    if not getFFlagUGCValidateCurveAnimAttributes() then
        return
    end

    local var1 = if game:GetFastFlag("UGCValidateAllowEmoteAttributes")
        and arg2.uploadCategory == ValidationEnums.UploadCategory.EMOTE_ANIMATION then tbl1 else nil

    for _, curveAnimation in arg2.curveAnimations do
        walkInstanceTree(arg1, curveAnimation, bool1, var1)
    end
end

return module
