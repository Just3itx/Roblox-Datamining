-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T16:20:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local script2 = script

local getEngineFeatureUGCValidationWithContextEntrypoint = require(script2.flags.getEngineFeatureUGCValidationWithContextEntrypoint)

local Analytics = require(script2.Analytics)
local Constants = require(script2.Constants)

local BundlesMetadata = require(script2.util.BundlesMetadata)
local canUploadBundlesAsync = require(script2.util.canUploadBundlesAsync)
local createUGCBodyPartFolders = require(script2.util.createUGCBodyPartFolders)
local isLayeredClothing = require(script2.util.isLayeredClothing)
local RigidOrLayeredAllowed = require(script2.util.RigidOrLayeredAllowed)
local _Types = require(script2.util.Types)
local createEditableInstancesForContext = require(script2.util.createEditableInstancesForContext)
local destroyEditableInstances = require(script2.util.destroyEditableInstances)
local ValidationHints = require(script2.util.ValidationHints)

local validateInternal = require(script2.validation.validateInternal)

local validateLayeredClothingAccessoryMeshPartAssetFormat = require(script2.validation.validateLayeredClothingAccessoryMeshPartAssetFormat)
local validateLegacyAccessoryMeshPartAssetFormat = require(script2.validation.validateLegacyAccessoryMeshPartAssetFormat)
local validateFullBody = require(script2.validation.validateFullBody)
local validateShoes = require(script2.validation.validateShoes)

local validateBundleReadyForUpload = require(script2.validation.validateBundleReadyForUpload)
local validateShoesBundleReadyForUpload = require(script2.validation.validateShoesBundleReadyForUpload)
local validateAnimationBundleReadyForUpload = require(script2.validation.validateAnimationBundleReadyForUpload)
local validateDynamicHeadMeshPartFormat = require(script2.validation.validateDynamicHeadMeshPartFormat)
local ValidationManager = require(script2.validationSystem.ValidationManager)
local getFFlagDebugUGCDisableAssetQualityChecks = require(script2.flags.getFFlagDebugUGCDisableAssetQualityChecks)

local getFFlagUGCValidateBackendInExperienceViaCanPublish = require(script2.flags.getFFlagUGCValidateBackendInExperienceViaCanPublish)
local getFFlagUGCValidationAllowFullVaas = require(script2.flags.getFFlagUGCValidationAllowFullVaas)
local LegacyValidationAdapter = require(script2.util.LegacyValidationAdapter)
local AssetQualityValidationClient = require(script2.util.AssetQualityValidationClient)
local SplitHumanoidRigDescriptionForUpload = require(script2.util.SplitHumanoidRigDescriptionForUpload)
local UnpublishedDependencies = require(script2.util.UnpublishedDependencies)
local module = {
    ValidateAsset = ValidationManager.ValidateAsset,
    ValidateFinalizedBundle = ValidationManager.ValidateFinalizedBundle,
    combineResultsIntoLegacy = LegacyValidationAdapter.combineResultsIntoLegacy,
    mergeLegacyIntoModern = LegacyValidationAdapter.mergeLegacyIntoModern,
    isBackendInExperienceViaCanPublishEnabled = getFFlagUGCValidateBackendInExperienceViaCanPublish,
    shouldSkipAssetQualityChecks = getFFlagDebugUGCDisableAssetQualityChecks,
    isFullVaasEnabled = getFFlagUGCValidationAllowFullVaas,
    SplitHrdInUpload = SplitHumanoidRigDescriptionForUpload.fixUploadInstance,
    AssetQualityValidationClient = AssetQualityValidationClient
}

if getEngineFeatureUGCValidationWithContextEntrypoint() then
    function module.validateWithContext(arg1)
        assert(arg1.instances ~= nil, "instances required in validationContext for validateWithContext")
        assert(arg1.assetTypeEnum ~= nil, "assetTypeEnum required in validationContext for validateWithContext")

        local instances = arg1.instances
        local isServer = arg1.isServer
        local assetTypeEnum = arg1.assetTypeEnum
        local allowEditableInstances = arg1.allowEditableInstances

        local now = tick()

        Analytics.setMetadata({ entrypoint = "validate", assetType = assetTypeEnum.Name, isServer = isServer })

        local var1, var2 = createEditableInstancesForContext.processAll(instances, allowEditableInstances)
        if not var1 then
            if not isServer then
                return var1, var2
            end

            if UnpublishedDependencies.shouldReturnOnLoadFailure(arg1) then
                return false, {}
            end
            error(var2[1])
        end

        arg1.editableMeshes = var2.editableMeshes
        arg1.editableImages = var2.editableImages
        arg1.lastTickSeconds = tick()

        if arg1.requireAllFolders == nil then
            arg1.requireAllFolders = true
        end

        local var3, var4 = validateInternal(arg1)

        destroyEditableInstances(arg1.editableMeshes, arg1.editableImages)

        if var3 then
            Analytics.recordScriptTime(script.Name, now, arg1)
            Analytics.reportScriptTimes(arg1)
        end

        Analytics.reportCounter(var3, if assetTypeEnum == Enum.AssetType.DynamicHead then "Head" else "BodyPart", arg1)

        return var3, var4
    end
end

function module.validate(instances, assetType, isServer: boolean?, allowUnreviewedAssets: boolean?, restrictedUserIds, token: string?, universeId: number?, allowEditableInstances: boolean?, bypassFlags, shouldYield: boolean?, validateMeshPartAccessories: boolean?, requireAllFolders: boolean?)
    local now = tick()

    Analytics.setMetadata({ entrypoint = "validate", assetType = assetType.Name, isServer = isServer })

    local var1, var2 = createEditableInstancesForContext.processAll(instances, allowEditableInstances)
    if not var1 then
        if not isServer then
            return var1, var2
        end

        error(var2[1])
    end

    local tbl1 = {
        instances = instances,
        assetTypeEnum = assetType,
        allowUnreviewedAssets = allowUnreviewedAssets,
        restrictedUserIds = restrictedUserIds,
        isServer = isServer,
        token = token,
        universeId = universeId,
        isAsync = false,
        allowEditableInstances = allowEditableInstances,
        bypassFlags = bypassFlags,
        validateMeshPartAccessories = 0,
        lastTickSeconds = 0,
        shouldYield = 0,
        editableMeshes = 0,
        editableImages = 0,
        requireAllFolders = 0
    }

    if validateMeshPartAccessories == nil then
        validateMeshPartAccessories = true
    end

    tbl1.validateMeshPartAccessories = validateMeshPartAccessories
    tbl1.lastTickSeconds = tick()
    tbl1.shouldYield = shouldYield
    tbl1.editableMeshes = var2.editableMeshes
    tbl1.editableImages = var2.editableImages
    if requireAllFolders == nil then
        requireAllFolders = true
    end

    tbl1.requireAllFolders = requireAllFolders

    local var3, var4 = validateInternal(tbl1)

    destroyEditableInstances(tbl1.editableMeshes, tbl1.editableImages)

    if var3 then
        Analytics.recordScriptTime(script.Name, now, tbl1)
        Analytics.reportScriptTimes(tbl1)
    end

    Analytics.reportCounter(var3, if assetType == Enum.AssetType.DynamicHead then "Head" else "BodyPart", tbl1)

    return var3, var4
end

function module.validateAsync(instances, assetTypeEnum, callback: (...any) -> (...any), isServer: boolean?, allowUnreviewedAssets: boolean?, restrictedUserIds)
    Analytics.setMetadata({ entrypoint = "validateAsync", assetType = assetTypeEnum.Name, isServer = isServer })

    local var1, var2 = createEditableInstancesForContext.processAll(instances)
    if not var1 then
        if isServer then
            error(var2[1])
        else
            callback(var1, var2)
        end
    end

    local tbl1 = {
        instances = instances,
        assetTypeEnum = assetTypeEnum,
        allowUnreviewedAssets = allowUnreviewedAssets,
        restrictedUserIds = restrictedUserIds,
        isServer = isServer,
        token = "",
        isAsync = true,
        validateMeshPartAccessories = false,
        editableMeshes = var2.editableMeshes,
        editableImages = var2.editableImages
    }

    coroutine.wrap(function()
        callback(validateInternal(tbl1))
        destroyEditableInstances(tbl1.editableMeshes, tbl1.editableImages)
    end)()
end

function module.validateMeshPartFormat(instances, assetType, isServer: boolean?, allowUnreviewedAssets: boolean?, restrictedUserIds)
    Analytics.setMetadata({ entrypoint = "validateMeshPartFormat", assetType = assetType.Name, isServer = isServer })

    assert(Enum.AssetType.DynamicHead == assetType)

    local var1, var2 = createEditableInstancesForContext.processAll(instances)
    if not var1 then
        if not isServer then
            return var1, var2
        end

        error(var2[1])
    end

    local tbl1 = {
        instances = instances,
        assetTypeEnum = assetType,
        allowUnreviewedAssets = allowUnreviewedAssets,
        restrictedUserIds = restrictedUserIds,
        isServer = isServer,
        validateMeshPartAccessories = false,
        editableMeshes = var2.editableMeshes,
        editableImages = var2.editableImages
    }

    local var3, var4 = validateDynamicHeadMeshPartFormat(tbl1)

    destroyEditableInstances(tbl1.editableMeshes, tbl1.editableImages)

    return var3, var4
end

function module.validateAsyncMeshPartFormat(instances, assetType, callback: (...any) -> (...any), isServer: boolean?, allowUnreviewedAssets: boolean?, restrictedUserIds)
    Analytics.setMetadata({ entrypoint = "validateAsyncMeshPartFormat", assetType = assetType.Name, isServer = isServer })

    assert(Enum.AssetType.DynamicHead == assetType)

    local var1, var2 = createEditableInstancesForContext.processAll(instances)
    if not var1 then
        if isServer then
            error(var2[1])
        else
            callback(var1, var2)
        end
    end

    local tbl1 = {
        instances = instances,
        assetTypeEnum = assetType,
        allowUnreviewedAssets = allowUnreviewedAssets,
        restrictedUserIds = restrictedUserIds,
        isServer = isServer,
        validateMeshPartAccessories = false,
        editableMeshes = var2.editableMeshes,
        editableImages = var2.editableImages
    }

    coroutine.wrap(function()
        callback(validateDynamicHeadMeshPartFormat(tbl1))
        destroyEditableInstances(tbl1.editableMeshes, tbl1.editableImages)
    end)()
end

if getEngineFeatureUGCValidationWithContextEntrypoint() then
    function module.validateMeshPartAssetFormatWithContext(arg1)
        assert(
            arg1.assetTypeEnum ~= nil,
            "assetTypeEnum required in validationContext for validateMeshPartAssetFormatWithContext"
        )

        assert(arg1.instances ~= nil, "instances required in validationContext for validateMeshPartAssetFormatWithContext")

        local instances = arg1.instances
        local assetTypeEnum = arg1.assetTypeEnum
        local isServer = arg1.isServer
        local specialMeshAccessory = arg1.specialMeshAccessory

        Analytics.setMetadata(
            {
                entrypoint = "validateMeshPartAssetFormat2",
                assetType = assetTypeEnum.Name,
                isServer = isServer
            }
        )
        local var1, var2 = createEditableInstancesForContext.processAll(instances)
        if not var1 then
            if not isServer then
                return var1, var2
            end

            error(var2[1])
        end

        arg1.editableMeshes = var2.editableMeshes
        arg1.editableImages = var2.editableImages
        arg1.validateMeshPartAccessories = false
        local var3, var4

        if isLayeredClothing(instances[1]) then
            var3, var4 = validateLayeredClothingAccessoryMeshPartAssetFormat(specialMeshAccessory, arg1)
        else
            var3, var4 = validateLegacyAccessoryMeshPartAssetFormat(specialMeshAccessory, arg1)
        end

        destroyEditableInstances(arg1.editableMeshes, arg1.editableImages)

        return var3, var4
    end
end

function module.validateMeshPartAssetFormat2(instances, arg1, assetTypeEnum, isServer: boolean?, allowUnreviewedAssets: boolean?, _)
    Analytics.setMetadata(
        {
            entrypoint = "validateMeshPartAssetFormat2",
            assetType = assetTypeEnum.Name,
            isServer = isServer
        }
    )
    local var1, var2 = createEditableInstancesForContext.processAll(instances)
    if not var1 then
        if not isServer then
            return var1, var2
        end

        error(var2[1])
    end

    local tbl1 = {
        instances = instances,
        assetTypeEnum = assetTypeEnum,
        allowUnreviewedAssets = allowUnreviewedAssets,
        isServer = isServer,
        validateMeshPartAccessories = false,
        editableMeshes = var2.editableMeshes,
        editableImages = var2.editableImages
    }
    local var3, var4

    if isLayeredClothing(instances[1]) then
        var3, var4 = validateLayeredClothingAccessoryMeshPartAssetFormat(arg1, tbl1)
    else
        var3, var4 = validateLegacyAccessoryMeshPartAssetFormat(arg1, tbl1)
    end

    destroyEditableInstances(tbl1.editableMeshes, tbl1.editableImages)

    return var3, var4
end

module.validateBundleReadyForUpload = validateBundleReadyForUpload
module.validateShoesBundleReadyForUpload = validateShoesBundleReadyForUpload
module.validateAnimationBundleReadyForUpload = validateAnimationBundleReadyForUpload

module.util = {
    BundlesMetadata = BundlesMetadata,
    createUGCBodyPartFolders = createUGCBodyPartFolders,
    canUploadBundlesAsync = canUploadBundlesAsync
}

module.util.isLayeredClothingAllowed = RigidOrLayeredAllowed.isLayeredClothingAllowed
module.util.isRigidAccessoryAllowed = RigidOrLayeredAllowed.isRigidAccessoryAllowed

if getEngineFeatureUGCValidationWithContextEntrypoint() then
    function module.validateFullBodyWithContext(arg1)
        assert(arg1.fullBodyData ~= nil, "fullBodyData required in validationContext for validateFullBodyWithContext")

        local isServer = arg1.isServer
        local fullBodyData = arg1.fullBodyData
        local allowEditableInstances = arg1.allowEditableInstances

        Analytics.setMetadata({ entrypoint = "validateFullBody", assetType = "", isServer = isServer })

        local now = tick()

        local tbl1 = {}
        for _, value in fullBodyData do
            for _, value2 in value.allSelectedInstances do
                table.insert(tbl1, value2)
            end
        end

        local var1, var2 = createEditableInstancesForContext.processAll(tbl1, allowEditableInstances)
        if not var1 then
            if not isServer then
                return var1, var2
            end

            if UnpublishedDependencies.shouldReturnOnLoadFailure(arg1) then
                return false, {}
            end
            error(var2[1])
        end

        arg1.editableMeshes = var2.editableMeshes
        arg1.editableImages = var2.editableImages
        arg1.lastTickSeconds = tick()

        if arg1.requireAllFolders == nil then
            arg1.requireAllFolders = true
        end

        local var3, var4 = validateFullBody(arg1)

        destroyEditableInstances(arg1.editableMeshes, arg1.editableImages)

        if var3 then
            Analytics.recordScriptTime(script.Name, now, arg1)
            Analytics.reportScriptTimes(arg1)
        end

        Analytics.reportCounter(var3, "FullBody", arg1)

        return var3, var4
    end
end

function module.validateFullBody(fullBodyData, isServer: boolean?, allowEditableInstances: boolean?, bypassFlags, shouldYield: boolean?, requireAllFolders: boolean?)
    Analytics.setMetadata({ entrypoint = "validateFullBody", assetType = "", isServer = isServer })

    local now = tick()

    local tbl1 = {}
    for _, value in fullBodyData do
        for _, value2 in value.allSelectedInstances do
            table.insert(tbl1, value2)
        end
    end

    local var1, var2 = createEditableInstancesForContext.processAll(tbl1, allowEditableInstances)
    if not var1 then
        if not isServer then
            return var1, var2
        end

        error(var2[1])
    end

    local tbl2 = {
        fullBodyData = fullBodyData,
        isServer = isServer,
        allowEditableInstances = allowEditableInstances,
        bypassFlags = bypassFlags,
        validateMeshPartAccessories = false,
        lastTickSeconds = tick(),
        shouldYield = shouldYield,
        editableMeshes = var2.editableMeshes,
        editableImages = var2.editableImages,
        requireAllFolders = 0
    }

    if requireAllFolders == nil then
        requireAllFolders = true
    end

    tbl2.requireAllFolders = requireAllFolders

    local var3, var4 = validateFullBody(tbl2)

    destroyEditableInstances(tbl2.editableMeshes, tbl2.editableImages)

    if var3 then
        Analytics.recordScriptTime(script.Name, now, tbl2)
        Analytics.reportScriptTimes(tbl2)
    end

    Analytics.reportCounter(var3, "FullBody", tbl2)

    return var3, var4
end

function module.validateShoesWithContext(arg1)
    assert(arg1.fullBodyData ~= nil, "fullBodyData required in validationContext for validateShoes")

    local isServer = arg1.isServer
    local fullBodyData = arg1.fullBodyData
    local allowEditableInstances = arg1.allowEditableInstances

    Analytics.setMetadata({ entrypoint = "validateShoes", assetType = "", isServer = isServer })

    local now = tick()

    local tbl1 = {}
    for _, value in fullBodyData do
        for _, value2 in value.allSelectedInstances do
            table.insert(tbl1, value2)
        end
    end

    local var1, var2 = createEditableInstancesForContext.processAll(tbl1, allowEditableInstances)
    if not var1 then
        if not isServer then
            return var1, var2
        end

        if UnpublishedDependencies.shouldReturnOnLoadFailure(arg1) then
            return false, {}
        end
        error(var2[1])
    end

    arg1.editableMeshes = var2.editableMeshes
    arg1.editableImages = var2.editableImages
    arg1.lastTickSeconds = tick()

    local var3, var4 = validateShoes(arg1)

    destroyEditableInstances(arg1.editableMeshes, arg1.editableImages)

    if var3 then
        Analytics.recordScriptTime(script.Name, now, arg1)
        Analytics.reportScriptTimes(arg1)
    end

    Analytics.reportCounter(var3, "Shoes", arg1)

    return var3, var4
end

function module.preprocessDataAsync(arg1, isServer: boolean?, allowEditableInstances: boolean?, bypassFlags, shouldYield: boolean?)
    Analytics.setMetadata({ entrypoint = "preprocessDataAsync", assetType = "", isServer = isServer })

    local now = tick()

    local tbl1 = {}
    for _, value in arg1 do
        table.insert(tbl1, value)
    end

    local var1, errors = createEditableInstancesForContext.processAll(tbl1, allowEditableInstances)
    if not var1 then
        if not isServer then
            return { ok = false, errors = errors }
        end

        error(errors[1])
    end

    local tbl2 = {
        isServer = isServer,
        allowEditableInstances = allowEditableInstances,
        bypassFlags = bypassFlags,
        validateMeshPartAccessories = false,
        lastTickSeconds = tick(),
        shouldYield = shouldYield,
        editableMeshes = errors.editableMeshes,
        editableImages = errors.editableImages
    }

    local var3 = ValidationHints.preprocessDataAsync(arg1, tbl2)

    destroyEditableInstances(tbl2.editableMeshes, tbl2.editableImages)

    if var3.ok then
        Analytics.recordScriptTime("preprocessDataAsync", now, tbl2)
        Analytics.reportScriptTimes(tbl2)
    end

    return var3
end

function module.isPreprocessDataCached(arg1, arg2, isServer: boolean?)
    Analytics.setMetadata({ entrypoint = "isPreprocessDataCached", assetType = "", isServer = isServer })

    local now = tick()

    local var1 = ValidationHints.isPreprocessDataCached(arg1, arg2)

    local tbl1 = { isServer = isServer }

    Analytics.recordScriptTime("isPreprocessDataCached", now, tbl1)
    Analytics.reportScriptTimes(tbl1)

    return var1
end

function module.calculateScaleToValidateBoundsAsync(arg1, isServer: boolean?, allowEditableInstances: boolean?, bypassFlags, shouldYield: boolean?, arg2)
    Analytics.setMetadata({ entrypoint = "calculateScaleToValidateBoundsAsync", assetType = "", isServer = isServer })

    local now = tick()
    local var1

    if arg2 then
        var1 = nil
    else
        local tbl1 = {}
        for _, value in arg1 do
            table.insert(tbl1, value)
        end

        local var2
        var2, var1 = createEditableInstancesForContext.processAll(tbl1, allowEditableInstances)
        if not var2 then
            if not isServer then
                return { ok = false, errors = var1 }
            end

            error(var1[1])
        end
    end

    local tbl1 = {
        isServer = isServer,
        allowEditableInstances = allowEditableInstances,
        bypassFlags = bypassFlags,
        validateMeshPartAccessories = false,
        lastTickSeconds = tick(),
        shouldYield = shouldYield
    }

    if not arg2 then
        tbl1.editableMeshes = var1.editableMeshes
        tbl1.editableImages = var1.editableImages
    end

    local scaleToValidateBoundsAsync = ValidationHints.calculateScaleToValidateBoundsAsync(arg1, tbl1, arg2)

    if not arg2 then
        destroyEditableInstances(tbl1.editableMeshes, tbl1.editableImages)
    end

    if scaleToValidateBoundsAsync.ok then
        Analytics.recordScriptTime("calculateScaleToValidateBoundsAsync", now, tbl1)
        Analytics.reportScriptTimes(tbl1)
    end

    return scaleToValidateBoundsAsync
end

module.GUIDAttributeName = Constants.GUIDAttributeName

return module
