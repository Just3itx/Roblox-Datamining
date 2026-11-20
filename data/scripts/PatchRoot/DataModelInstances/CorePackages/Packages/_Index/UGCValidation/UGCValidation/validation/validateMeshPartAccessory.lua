-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T17:41:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local _Types = require(scriptParentParent.util.Types)
local Analytics = require(scriptParentParent.Analytics)
local Constants = require(scriptParentParent.Constants)

local validateInstanceTree = require(scriptParentParent.validation.validateInstanceTree)
local validateTags = require(scriptParentParent.validation.validateTags)
local validateSingleInstance = require(scriptParentParent.validation.validateSingleInstance)
local ValidateMeshSizeProperty = require(scriptParentParent.validation.ValidateMeshSizeProperty)
local ValidatePropertiesSensible = require(scriptParentParent.validation.ValidatePropertiesSensible)
local validateDependencies = require(scriptParentParent.validation.validateDependencies)

local createMeshPartAccessorySchema = require(scriptParentParent.util.createMeshPartAccessorySchema)
local getAttachment = require(scriptParentParent.util.getAttachment)
local getMeshSize = require(scriptParentParent.util.getMeshSize)
local FailureReasonsAccumulator = require(scriptParentParent.util.FailureReasonsAccumulator)
local getEditableMeshFromContext = require(scriptParentParent.util.getEditableMeshFromContext)
local getEditableImageFromContext = require(scriptParentParent.util.getEditableImageFromContext)
local pcallDeferred = require(scriptParentParent.util.pcallDeferred)
local RigidOrLayeredAllowed = require(scriptParentParent.util.RigidOrLayeredAllowed)

local getEngineFeatureEngineUGCValidatePropertiesSensible = require(scriptParentParent.flags.getEngineFeatureEngineUGCValidatePropertiesSensible)

local function validateMeshPartAccessory(arg1)
    assert(arg1.assetTypeEnum ~= nil, "assetTypeEnum required in validationContext for validateMeshPartAccessory")

    local instances = arg1.instances
    local assetTypeEnum = arg1.assetTypeEnum
    if not RigidOrLayeredAllowed.isRigidAccessoryAllowed(assetTypeEnum) then
        Analytics.reportFailure(Analytics.ErrorType.validateLegacyAccessory_AssetTypeNotAllowedAsRigidAccessory, nil, arg1)

        return false, { string.format(
                "Asset type '%s' is not a rigid accessory category. It can only be used with layered clothing.",
                assetTypeEnum.Name
            ) }
    end

    local var1 = Constants.ASSET_TYPE_INFO[assetTypeEnum]

    local var2, var3 = validateSingleInstance(instances, arg1)
    if not var2 then
        return false, var3
    end

    local var4 = instances[1]

    local meshPartAccessorySchema = createMeshPartAccessorySchema(var1.attachmentNames)

    local var5, var6 = validateInstanceTree(meshPartAccessorySchema, var4, arg1)
    if not var5 then
        return false, var6
    end

    if getEngineFeatureEngineUGCValidatePropertiesSensible() then
        local var7, var8 = ValidatePropertiesSensible.validate(var4, arg1)
        if not var7 then
            return false, var8
        end
    end

    local var7, var8 = validateDependencies(var4, arg1, { skipExistenceCheck = true, skipOwnershipCheck = true })
    if not var7 then
        return false, var8
    end

    local handle = var4:FindFirstChild("Handle")
    local tbl1 = {
        fullName = handle:GetFullName(),
        fieldName = "MeshId",
        contentId = handle.MeshId,
        context = var4.Name
    }

    local failureReasonsAccumulator = FailureReasonsAccumulator.new()

    if handle.DoubleSided then
        failureReasonsAccumulator:updateReasons(false, { string.format(
                "MeshPart '%s' is double-sided. Double-sided meshes are not allowed in rigid accessories.",
                handle:GetFullName()
            ) })

        Analytics.reportFailure(Analytics.ErrorType.validateMeshPartAccessory_DoubleSided, nil, arg1)
    end

    local var9, editableMesh = getEditableMeshFromContext(handle, "MeshId", arg1)
    if not var9 then
        if tbl1.contentId then
            Analytics.reportFailure(Analytics.ErrorType.validateMeshPartAccessory_FailedToLoadMesh, nil, arg1)

            return false, { string.format("Failed to load mesh for accessory '%s'. Make sure mesh exists and try again.", var4.Name) }
        end

        Analytics.reportFailure(Analytics.ErrorType.validateMeshPartAccessory_NoMeshId, nil, arg1)
        failureReasonsAccumulator:updateReasons(false, { string.format(
                "Accessory MeshPart '%s' must contain a valid meshId. Make sure the mesh referred to by the meshId exists and try again.",
                handle:GetFullName()
            ) })
    end

    tbl1.editableMesh = editableMesh

    local textureId = handle.TextureID
    local tbl2 = {
        fullName = handle:GetFullName(),
        fieldName = "TextureID",
        contentId = textureId
    }

    local _, editableImage = getEditableImageFromContext(handle, "TextureID", arg1)
    tbl2.editableImage = editableImage

    local var12, _ = pcallDeferred(function()
        return getMeshSize(tbl1)
    end, arg1)

    if not var12 then
        Analytics.reportFailure(Analytics.ErrorType.validateMeshPartAccessory_FailedToLoadMesh, nil, arg1)
        return false, { string.format("Failed to load mesh for accessory '%s'. Make sure mesh exists and try again.", var4.Name) }
    end

    local attachment = getAttachment(handle, var1.attachmentNames)
    assert(attachment)

    assert(var1.bounds[attachment.Name], "Could not find bounds for " .. attachment.Name)

    failureReasonsAccumulator:updateReasons(validateTags(var4, arg1))
    failureReasonsAccumulator:updateReasons(ValidateMeshSizeProperty.validateSingleMeshPart(handle, arg1))

    return failureReasonsAccumulator:getFinalResults()
end

return validateMeshPartAccessory
