-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T16:20:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent

local _Types = require(scriptParent.util.Types)

local RunService = game:GetService("RunService")
local UGCValidationService = game:GetService("UGCValidationService")
local StudioService = if RunService:IsStudio() then game:GetService("StudioService") else nil
local RbxAnalyticsService = game:GetService("RbxAnalyticsService")

local getEngineFeatureEngineUGCValidationReportScriptTime = require(scriptParent.flags.getEngineFeatureEngineUGCValidationReportScriptTime)

local getEngineFeatureEngineUGCValidationIECTelemetry = require(scriptParent.flags.getEngineFeatureEngineUGCValidationIECTelemetry)

local getEngineFeatureEngineUGCValidateFACSJointTransformsWithinBounds = require(scriptParent.flags.getEngineFeatureEngineUGCValidateFACSJointTransformsWithinBounds)

local getEngineFeatureEngineUGCValidatePropertiesSensible = require(scriptParent.flags.getEngineFeatureEngineUGCValidatePropertiesSensible)

local getFFlagUGCValidationEyebrowEyelashSupport = require(scriptParent.flags.getFFlagUGCValidationEyebrowEyelashSupport)

local function joinTables(...)
    local result = ({})
    local select2 = select

    for i = 1, select2("#", ...) do
        for value, value2 in select(i, ...) do
            result[value] = value2
        end
    end
    return result
end

local module = {
    ErrorType = {
        resetPhysicsData_FailedToLoadMesh = "resetPhysicsData_FailedToLoadMesh",
        validateAccurateBoundingBox = "validateAccurateBoundingBox",
        validateScaleType_InvalidAvatarPartScaleType = "validateScaleType_InvalidAvatarPartScaleType",
        validateAssetCreator_DependencyNotOwnedByCreator = "validateAssetCreator_DependencyNotOwnedByCreator",
        validateAssetCreator_FailedToLoad = "validateAssetCreator_FailedToLoad",
        validateAssetCreator_TooManyDependencies = "validateAssetCreator_TooManyDependencies",
        validateAssetTransparency_AssetTransparencyThresholds = "validateAssetTransparency_AssetTransparencyThresholds",
        validateBodyPartCollisionFidelity = "validateBodyPartCollisionFidelity",
        validateCanLoad = "validateCanLoad",
        validateDependencies_IsNotApproved = "validateDependencies_IsNotApproved",
        validateDependencies_IsRestrictedUserId = "validateDependencies_IsRestrictedUserId",
        validateDependencies_IsReviewing = "validateDependencies_IsReviewing",
        validateDependencies_ParseFailure = "validateDependencies_ParseFailure",
        validateDescendantMeshMetrics_FailedToLoadMesh = "validateDescendantMeshMetrics_FailedToLoadMesh",
        validateDescendantMeshMetrics_HasSkinnedMeshMismatch = "validateDescendantMeshMetrics_HasSkinnedMeshMismatch",
        validateDescendantMeshMetrics_NoSkinningInfo = "validateDescendantMeshMetrics_NoSkinningInfo",
        validateDescendantMeshMetrics_TooFarFromOrigin = "validateDescendantMeshMetrics_TooFarFromOrigin",
        validateDynamicHeadMeshPartFormat_FailedToLoadMesh = "validateDynamicHeadMeshPartFormat_FailedToLoadMesh",
        validateDynamicHeadMeshPartFormat_ValidateDynamicHeadMesh = "validateDynamicHeadMeshPartFormat_ValidateDynamicHeadMesh",
        validateFullBody_IncorrectAssetTypeSet = "validateFullBody_IncorrectAssetTypeSet",
        validateFullBody_InstancesMissing = "validateFullBody_InstancesMissing",
        validateFullBody_MeshIdsMissing = "validateFullBody_MeshIdsMissing",
        validateHSR_NoWrapLayer = "validateHSR_NoWrapLayer",
        validateInstanceTree = "validateInstanceTree",
        validateInstanceTree_InvalidDescendants = "validateInstanceTree_InvalidDescendants",
        validateLayeredClothingAccessory_AssetTypeNotAllowedAsLayeredClothing = "validateLayeredClothingAccessory_AssetTypeNotAllowedAsLayeredClothing",
        validateLayeredClothingAccessory_FailedToLoadMesh = "validateLayeredClothingAccessory_FailedToLoadMesh",
        validateLayeredClothingAccessory_NoInnerCageId = "validateLayeredClothingAccessory_NoInnerCageId",
        validateLayeredClothingAccessory_NoMeshId = "validateLayeredClothingAccessory_NoMeshId",
        validateLayeredClothingAccessory_NoOuterCageId = "validateLayeredClothingAccessory_NoOuterCageId",
        validateLayeredClothingAccessory_NoWrapLayer = "validateLayeredClothingAccessory_NoWrapLayer",
        validateLayeredClothingAccessoryMeshPartAssetFormatMatch_MeshIdMismatch = "validateLayeredClothingAccessoryMeshPartAssetFormatMatch_MeshIdMismatch",
        validateLayeredClothingAccessoryMeshPartAssetFormatMatch_TextureIdMismatch = "validateLayeredClothingAccessoryMeshPartAssetFormatMatch_TextureIdMismatch",
        validateLegacyAccessory_AssetTypeNotAllowedAsRigidAccessory = "validateLegacyAccessory_AssetTypeNotAllowedAsRigidAccessory",
        validateLegacyAccessoryMeshPartAssetFormatMatch_MeshIdMismatch = "validateLegacyAccessoryMeshPartAssetFormatMatch_MeshIdMismatch",
        validateLegacyAccessoryMeshPartAssetFormatMatch_TextureIdMismatch = "validateLegacyAccessoryMeshPartAssetFormatMatch_TextureIdMismatch",
        validateLimbsAndTorso_FolderInfoMismatch = "validateLimbsAndTorso_FolderInfoMismatch",
        validateLimbsAndTorso_R6FolderHasChildren = "validateLimbsAndTorso_R6FolderHasChildren",
        validateLimbsAndTorso_TopLevelFolders = "validateLimbsAndTorso_TopLevelFolders",
        validateMeshPartAccessory_DoubleSided = "validateMeshPartAccessory_DoubleSided",
        validateMeshPartAccessory_FailedToLoadMesh = "validateMeshPartAccessory_FailedToLoadMesh",
        validateMeshPartAccessory_NoMeshId = "validateMeshPartAccessory_NoMeshId",
        validateMeshPartBodyPart_ValidateWithSchema = "validateMeshPartBodyPart_ValidateWithSchema",
        validatePackage_FailedToParse = "validatePackage_FailedToParse",
        validateSingleInstance_MultipleInstances = "validateSingleInstance_MultipleInstances",
        validateSingleInstance_ZeroInstances = "validateSingleInstance_ZeroInstances",
        validateSurfaceAppearances_InvalidAlphaMode = "validateSurfaceAppearances_InvalidAlphaMode",
        validateTags = "validateTags",
        validateThumbnailConfiguration_InvalidTarget = "validateThumbnailConfiguration_InvalidTarget",
        validateThumbnailConfiguration_OutsideView = "validateThumbnailConfiguration_OutsideView",
        validateDynamicHeadMeshPartFormat_ValidateDynamicHeadMeshControls = "validateDynamicHeadMeshPartFormat_ValidateDynamicHeadMeshControls",
        validateRenderMeshInsideOuterCageMesh_FailedToExecute = "validateRenderMeshInsideOuterCageMesh_FailedToExecute",
        validateRenderMeshInsideOuterCageMesh_MaxOutsideCageMeshExceeded = "validateRenderMeshInsideOuterCageMesh_MaxOutsideCageMeshExceeded",
        validateLayeredClothingAccessory_CageOriginOutOfBounds = "validateLayeredClothingAccessory_CageOriginOutOfBounds",
        validateBodyPart_CageOriginOutOfBounds = "validateBodyPart_CageOriginOutOfBounds",
        validateExcludedModifiedCageUVs_FailedToExecute = "validateExcludedModifiedCageUVs_FailedToExecute",
        validateExcludedModifiedCageUVs_UnexpectedUVValue = "validateExcludedModifiedCageUVs_UnexpectedUVValue",
        validateMainModifiedCageUVs_FailedToExecute = "validateMainModifiedCageUVs_FailedToExecute",
        validateMainModifiedCageUVs_TooFewModifiedUVsFound = "validateMainModifiedCageUVs_TooFewModifiedUVsFound",
        validateRenderMeshInsideModifiedOuterCageArea_FailedToExecute = "validateRenderMeshInsideModifiedOuterCageArea_FailedToExecute",
        validateRenderMeshInsideModifiedOuterCageArea_RenderMeshNotPositionedCorrectly = "validateRenderMeshInsideModifiedOuterCageArea_RenderMeshNotPositionedCorrectly",
        validateCagingRelevancy_FailedToExecute = "validateCagingRelevancy_FailedToExecute",
        validateCagingRelevancy_IrrelevantCaging = "validateCagingRelevancy_IrrelevantCaging",
        validateCageMeshDistance_FailedToExecute = "validateCageMeshDistance_FailedToExecute",
        validateCageMeshDistance_OuterCageToMeshDistance = "validateCageMeshDistance_OuterCageToMeshDistance",
        validatePartSizeWithinRenderSizeLimits_SizeExceeded = "validatePartSizeWithinRenderSizeLimits_SizeExceeded",
        validateLayeredClothingAccessory_HandleIsScaled = "validateLayeredClothingAccessory_HandleIsScaled",
        resetPhysicsData_LargeMass = "resetPhysicsData_LargeMass",
        validateBodyAttPosRelativeToParent_PartAboveParent = "validateBodyAttPosRelativeToParent_PartAboveParent",
        validateBodyAttPosRelativeToParent_ParentBelowPart = "validateBodyAttPosRelativeToParent_ParentBelowPart",
        validateBodyBlockingTests_ZeroMeshSize = "validateBodyBlockingTests_ZeroMeshSize",
        validateFullBody_ZeroMeshSize = "validateFullBody_ZeroMeshSize",
        validateDeformedLayeredClothingInRenderBounds_FailedToExecute = "validateDeformedLayeredClothingInRenderBounds_FailedToExecute",
        validateDeformedLayeredClothingInRenderBounds_ClothingOutOfBounds = "validateDeformedLayeredClothingInRenderBounds_ClothingOutOfBounds"
    }
}
module.ErrorType.validateMeshSizeProperty_FailedToLoadMesh = "validateMeshSizeProperty_FailedToLoadMesh"
module.ErrorType.validateMeshSizeProperty_Mismatch = "validateMeshSizeProperty_Mismatch"

module.ErrorType.validateBodyPartVertsSkinnedToR15_FailedToFetchSkinning = "validateBodyPartVertsSkinnedToR15_FailedToFetchSkinning"
module.ErrorType.validateBodyPartVertsSkinnedToR15_BodyIsSkinnedToFakeJoints = "validateBodyPartVertsSkinnedToR15_BodyIsSkinnedToFakeJoints"

module.ErrorType.validateSkinningTransfer_FailedToExecute = "validateSkinningTransfer_FailedToExecute"
module.ErrorType.validateSkinningTransfer_BodyPartsWithSpecialJoints = "validateSkinningTransfer_BodyPartsWithSpecialJoints"
module.ErrorType.validateSkinningTransfer_SkinningTransferOverride = "validateSkinningTransfer_SkinningTransferOverride"
module.ErrorType.validateSkinningTransfer_Weights = "validateSkinningTransfer_Weights"

if getFFlagUGCValidationEyebrowEyelashSupport() then
    module.ErrorType.validateSkinningTransfer_RequiredAssetTypes = "validateSkinningTransfer_RequiredAssetTypes"
end

if getEngineFeatureEngineUGCValidatePropertiesSensible() then
    module.ErrorType.validatePropertiesSensible_IncorrectPropertiesFound = "validatePropertiesSensible_IncorrectPropertiesFound"
end

module.ErrorType.validateHSR_FileDataInvalid = "validateHSR_FileDataInvalid"

module.ErrorType.validataHSR_HSRMeshIdsMismatch = "validataHSR_HSRMeshIdsMismatch"

if getEngineFeatureEngineUGCValidateFACSJointTransformsWithinBounds() then
    module.ErrorType.validateFACSJointTransformsWithinBounds_Error = "validateFACSJointTransformsWithinBounds_Error"
    module.ErrorType.validateFACSJointTransformsWithinBounds_OOB = "validateFACSJointTransformsWithinBounds_OOB"
end

setmetatable(module.ErrorType, {
    __index = function(_, arg1): string
        return `UNREGISTERED_{arg1}`
    end
})

module.metadata = {}

function module.setMetadata(tbl1)
    local metadata = ({})
    for value, value2 in tbl1 do
        metadata[value] = tostring(value2)
    end
    module.metadata = metadata
end

function module.shouldReportIECTelemetry(arg1): boolean
    return if getEngineFeatureEngineUGCValidationIECTelemetry() then if arg1 then not not (not RunService:IsStudio() and arg1.allowEditableInstances and arg1.isServer) else false else false
end

function module.reportCounter(success: boolean, validationType: string, arg1)
    if module.shouldReportIECTelemetry(arg1) then
        UGCValidationService:ReportUGCValidationCounter(success, validationType)
    end
end

function module.reportFailure(errorType: string, tbl1, arg1)
    local target = if RunService:IsStudio() then "studio" else "rcc"
    local additionalArgs = joinTables(module.metadata, tbl1 or {}, {
        errorType = errorType,
        studioSid = RbxAnalyticsService:GetSessionId(),
        clientId = RbxAnalyticsService:GetClientId(),
        placeId = game.PlaceId,
        userId = if StudioService then StudioService:GetUserId() else 0
    })
    RbxAnalyticsService:SendEventDeferred(target, "ugcValidation", "failure", additionalArgs)

    if module.shouldReportIECTelemetry(arg1) then
        UGCValidationService:ReportUGCValidationFailureTelemetry(errorType)
    end
end

function module.reportThumbnailing(time: number, tbl1)
    local target = if RunService:IsStudio() then "studio" else "rcc"
    local additionalArgs = joinTables(module.metadata, tbl1 or {}, {
        time = time,
        studioSid = RbxAnalyticsService:GetSessionId(),
        clientId = RbxAnalyticsService:GetClientId(),
        placeId = game.PlaceId,
        userId = if StudioService then StudioService:GetUserId() else 0
    })
    RbxAnalyticsService:SendEventDeferred(target, "ugcValidation", "thumbnailing", additionalArgs)
end

function module.recordScriptTime(str1: string, num1: number, arg1)
    if not getEngineFeatureEngineUGCValidationReportScriptTime() then
        return
    end

    if not arg1.scriptTimes then
        arg1.scriptTimes = {}
    end

    local scriptTimes = arg1.scriptTimes
    if not scriptTimes[str1] then
        scriptTimes[str1] = 0
    end

    local var1 = tick() - num1
    scriptTimes[str1] += var1
end

function module.reportScriptTimes(arg1)
    if not getEngineFeatureEngineUGCValidationReportScriptTime() then
        return
    end

    if not arg1.isServer or RunService:IsStudio() or not arg1.scriptTimes then
        return
    end

    assert(module.metadata, "Metadata is never nil")
    local entrypoint = module.metadata.entrypoint

    local assetType = "FullBody"
    if arg1.assetTypeEnum then
        assetType = arg1.assetTypeEnum.Name
    elseif entrypoint and type(entrypoint) == "string" and #entrypoint > 0 then
        assetType = entrypoint
    end

    UGCValidationService:ReportUGCValidationTelemetry(assetType, arg1.scriptTimes)
end

return module
