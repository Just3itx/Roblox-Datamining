-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:10:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UGCValidationService = game:GetService("UGCValidationService")

local scriptParentParentParent = script.Parent.Parent.Parent

local Constants = require(scriptParentParentParent.Constants)
local _Types = require(scriptParentParentParent.util.Types)
local ValidationEnums = require(scriptParentParentParent.validationSystem.ValidationEnums)
local ErrorSourceStrings = require(scriptParentParentParent.validationSystem.ErrorSourceStrings)

local getEngineFeatureEngineUGCValidatePropertiesSensible = require(scriptParentParentParent.flags.getEngineFeatureEngineUGCValidatePropertiesSensible)
local getFIntUGCValidateMaxHSRDataLen = require(scriptParentParentParent.flags.getFIntUGCValidateMaxHSRDataLen)
local getFFlagUGCValidateWrapDataCaps = require(scriptParentParentParent.flags.getFFlagUGCValidateWrapDataCaps)
local getFIntUGCValidateMaxHSRMeshIdDataLen = require(scriptParentParentParent.flags.getFIntUGCValidateMaxHSRMeshIdDataLen)
local getFFlagUGCValidateDisallowAeroMeshData = require(scriptParentParentParent.flags.getFFlagUGCValidateDisallowAeroMeshData)
local getFFlagUGCValidateTemporaryIdsBackendOnly = require(scriptParentParentParent.flags.getFFlagUGCValidateTemporaryIdsBackendOnly)

local describeProblematicProperties = require(script.Parent.describeProblematicProperties)

local tbl1 = {
    ValidationEnums.UploadCategory.TORSO_AND_LIMBS,
    ValidationEnums.UploadCategory.DYNAMIC_HEAD,
    ValidationEnums.UploadCategory.LAYERED_CLOTHING,
    ValidationEnums.UploadCategory.EYEBROW_EYELASH
}

local module = {
    categories = if require(scriptParentParentParent.flags.getFFlagUGCValidateMakeupCategoryParity)() then Constants.AllAssetUploadCategories else Constants.AllAssetUploadCategoriesIncludingMakeup,
    requiredData = {
        ValidationEnums.SharedDataMember.rootInstance,
        ValidationEnums.SharedDataMember.hsrAssets,
        ValidationEnums.SharedDataMember.consumerConfig,
        ValidationEnums.SharedDataMember.uploadCategory
    },
    expectedFailures = {}
}
local function walkInstanceTree(arg1, arg2, tbl2)
    local descendants = arg2:GetDescendants()
    table.insert(descendants, arg2)

    for _, descendant in descendants do
        local stringLenRestrictions = tbl2[descendant.ClassName]
        local var1, var2 = UGCValidationService:ValidatePropertiesSensible(descendant, stringLenRestrictions)

        if var1 then
            continue
        end

        local propertiesNotSensible = ErrorSourceStrings.Keys.PropertiesNotSensible
        local tbl3 = {
            ClassName = descendant.ClassName,
            InstancePath = descendant:GetFullName(),
            ProblematicProperties = describeProblematicProperties(var2, stringLenRestrictions)
        }
        arg1:fail(propertiesNotSensible, tbl3)
    end
end

function module.run(arg1, arg2)
    if not getEngineFeatureEngineUGCValidatePropertiesSensible() then
        return
    end

    local tbl2 = {
        HiddenSurfaceRemovalAsset = {
            HSRData = getFIntUGCValidateMaxHSRDataLen()
        }
    }
    if getFFlagUGCValidateDisallowAeroMeshData() then
        tbl2.MeshPart = { AeroMeshData = 0 }
    end

    if getFFlagUGCValidateWrapDataCaps() then
        local consumerEnv = arg2.consumerConfig.consumerEnv
        local bool1 = consumerEnv == ValidationEnums.ConsumerEnv.Backend

        local bool2 = (if getFFlagUGCValidateTemporaryIdsBackendOnly() then consumerEnv == ValidationEnums.ConsumerEnv.Backend else consumerEnv ~= ValidationEnums.ConsumerEnv.IEC)
            and table.find(tbl1, arg2.uploadCategory) ~= nil

        local wrapTarget = {
            HSRMeshIdData = getFIntUGCValidateMaxHSRMeshIdDataLen()
        }
        local wrapLayer = {
            HSRMeshIdData = getFIntUGCValidateMaxHSRMeshIdDataLen()
        }
        if bool1 then
            wrapTarget.HSRData = 0
            wrapLayer.HSRData = 0
        end
        if bool2 then
            wrapTarget.TemporaryCageMeshId = 0
            wrapLayer.TemporaryCageMeshId = 0
            wrapLayer.TemporaryReferenceId = 0
        end

        tbl2.WrapTarget = wrapTarget
        tbl2.WrapLayer = wrapLayer
    end

    walkInstanceTree(arg1, arg2.rootInstance, tbl2)

    for _, hsrAsset in arg2.hsrAssets do
        for _, value in hsrAsset do
            walkInstanceTree(arg1, value, tbl2)
        end
    end
end

return module
