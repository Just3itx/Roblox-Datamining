-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T17:41:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local _Types = require(scriptParentParent.util.Types)
local Analytics = require(scriptParentParent.Analytics)
local Constants = require(scriptParentParent.Constants)

local validateLCCageQuality = require(scriptParentParent.validation.validateLCCageQuality)
local validateInstanceTree = require(scriptParentParent.validation.validateInstanceTree)
local validateTags = require(scriptParentParent.validation.validateTags)
local validateSingleInstance = require(scriptParentParent.validation.validateSingleInstance)
local ValidateMeshSizeProperty = require(scriptParentParent.validation.ValidateMeshSizeProperty)
local ValidatePropertiesSensible = require(scriptParentParent.validation.ValidatePropertiesSensible)
local validateDependencies = require(scriptParentParent.validation.validateDependencies)
local validateSkinningTransfer = require(scriptParentParent.validation.validateSkinningTransfer)

local RigidOrLayeredAllowed = require(scriptParentParent.util.RigidOrLayeredAllowed)
local createLayeredClothingSchema = require(scriptParentParent.util.createLayeredClothingSchema)
local createEyebrowEyelashSchema = require(scriptParentParent.util.createEyebrowEyelashSchema)
local getMeshSize = require(scriptParentParent.util.getMeshSize)
local getEditableMeshFromContext = require(scriptParentParent.util.getEditableMeshFromContext)
local getEditableImageFromContext = require(scriptParentParent.util.getEditableImageFromContext)
local getExpectedPartSize = require(scriptParentParent.util.getExpectedPartSize)
local pcallDeferred = require(scriptParentParent.util.pcallDeferred)

local getFIntUGCValidationLCHandleScaleOffsetMaximum = require(scriptParentParent.flags.getFIntUGCValidationLCHandleScaleOffsetMaximum)

local getEngineFeatureEngineUGCValidatePropertiesSensible = require(scriptParentParent.flags.getEngineFeatureEngineUGCValidatePropertiesSensible)

local getFFlagUGCValidateEyebrowEyelashThumbnailSchema = require(scriptParentParent.flags.getFFlagUGCValidateEyebrowEyelashThumbnailSchema)

local ValidateMeshPartOnlySkinnedToR15 = require(scriptParentParent.validation.ValidateMeshPartOnlySkinnedToR15)

local getEngineFeatureEngineUGCValidationConsolidateAccessorySkinning = require(scriptParentParent.flags.getEngineFeatureEngineUGCValidationConsolidateAccessorySkinning)

local function validateLayeredClothingAccessory(arg1)
    local instances = arg1.instances
    local assetTypeEnum = arg1.assetTypeEnum
    if not RigidOrLayeredAllowed.isLayeredClothingAllowed(assetTypeEnum) then
        Analytics.reportFailure(
            Analytics.ErrorType.validateLayeredClothingAccessory_AssetTypeNotAllowedAsLayeredClothing,
            nil,
            arg1
        )

        return false, { string.format(
                "Asset type '%s' is not a layered clothing category. It can only be used with rigid accessories.",
                assetTypeEnum.Name
            ) }
    end

    local var1 = Constants.ASSET_TYPE_INFO[assetTypeEnum]

    local var2, var3 = validateSingleInstance(instances, arg1)
    if not var2 then
        return false, var3
    end

    local var4 = instances[1]
    local var5 = if if getFFlagUGCValidateEyebrowEyelashThumbnailSchema() then assetTypeEnum == Enum.AssetType.EyebrowAccessory or assetTypeEnum == Enum.AssetType.EyelashAccessory else false then createEyebrowEyelashSchema(var1.attachmentNames) else createLayeredClothingSchema(var1.attachmentNames)
    local var6, var7 = validateInstanceTree(var5, var4, arg1)
    if not var6 then
        return false, var7
    end

    if getEngineFeatureEngineUGCValidatePropertiesSensible() then
        local var8, var9 = ValidatePropertiesSensible.validate(var4, arg1)
        if not var8 then
            return false, var9
        end
    end

    local var8, var9 = validateDependencies(var4, arg1, { skipExistenceCheck = true, skipOwnershipCheck = true })
    if not var8 then
        return false, var9
    end

    local bool1 = true
    local tbl1 = {}

    local handle = var4:FindFirstChild("Handle")
    local tbl2 = {
        fullName = handle:GetFullName(),
        fieldName = "MeshId",
        contentId = handle.MeshId,
        context = var4.Name
    }

    if tbl2.contentId ~= nil and tbl2.contentId == "" then
    end

    local var10, editableMesh = getEditableMeshFromContext(handle, "MeshId", arg1)
    if not var10 then
        if tbl2.contentId then
            Analytics.reportFailure(Analytics.ErrorType.validateLayeredClothingAccessory_FailedToLoadMesh, nil, arg1)

            return false, { string.format(
                    "Failed to load mesh for layered clothing accessory '%s'. Make sure mesh exists and try again.",
                    var4.Name
                ) }
        end

        Analytics.reportFailure(Analytics.ErrorType.validateLayeredClothingAccessory_NoMeshId, nil, arg1)

        table.insert(tbl1, { string.format(
                "Missing meshId on layered clothing accessory '%s'. Make sure you are using a valid meshId and try again.\n",
                var4.Name
            ) })
        bool1 = false
    end

    tbl2.editableMesh = editableMesh
    local bool2 = true

    local textureId = handle.TextureID
    local tbl3 = {
        fullName = handle:GetFullName(),
        fieldName = "TextureID",
        contentId = textureId
    }

    if textureId ~= "" then
        local var12, editableImage = getEditableImageFromContext(handle, "TextureID", arg1)
        if not var12 then
            return false, { string.format(
                    "Failed to load texture for layered clothing accessory '%s'. Make sure texture exists and try again.",
                    var4.Name
                ) }
        end

        tbl3.editableImage = editableImage
    end

    local var12, var13 = pcallDeferred(function()
        return getMeshSize(tbl2)
    end, arg1)

    if not var12 then
        Analytics.reportFailure(Analytics.ErrorType.validateLayeredClothingAccessory_FailedToLoadMesh, nil, arg1)

        return false, { string.format(
                "Failed to load mesh for layered clothing accessory '%s'. Make sure mesh exists and try again.",
                var4.Name
            ) }
    end

    if not (getExpectedPartSize(handle, arg1) / var13):FuzzyEq(
        Vector3.new(1, 1, 1),
        getFIntUGCValidationLCHandleScaleOffsetMaximum() / 1000
    ) then
        Analytics.reportFailure(Analytics.ErrorType.validateLayeredClothingAccessory_HandleIsScaled, nil, arg1)

        table.insert(
            tbl1,
            string.format(
                "%s has been scaled, but mesh parts with wrap layers do not support scaling. You need to change the Size property to match the MeshSize property.",
                handle.Name
            )
        )
        bool1 = false
    end

    local var14, var15 = validateTags(var4, arg1)
    if not var14 then
        table.insert(tbl1, table.concat(var15, "\n"))
        bool1 = false
    end

    if handle:FindFirstChildOfClass("WrapLayer") == nil then
        Analytics.reportFailure(Analytics.ErrorType.validateLayeredClothingAccessory_NoWrapLayer, nil, arg1)

        table.insert(
            tbl1,
            string.format(
                "Missing WrapLayer on layered clothing accessory %s. You need to create a child WrapLayer and try again.",
                var4.Name
            )
        )
        bool1 = false
    end

    if bool2 then
        local var16, var17 = ValidateMeshSizeProperty.validateSingleMeshPart(handle, arg1)
        if not var16 then
            table.insert(tbl1, table.concat(var17, "\n"))
            bool1 = false
        end
    end

    local var16, var17 = validateLCCageQuality(var4, tbl2, arg1)
    if not var16 then
        for _, value in var17 do
            table.insert(tbl1, value)
        end

        bool1 = false
    end

    if not getEngineFeatureEngineUGCValidationConsolidateAccessorySkinning() then
        local var18, var19 = validateSkinningTransfer(handle, arg1)
        if not var18 then
            table.insert(tbl1, table.concat(var19, "\n"))
            bool1 = false
        end

        if not Constants.SkinningTransferRequiredTypes[assetTypeEnum] then
            local var20, var21 = ValidateMeshPartOnlySkinnedToR15.validateMeshPart(handle, arg1)
            if not var20 then
                table.insert(tbl1, table.concat(var21, "\n"))
                bool1 = false
            end
        end
    end

    return bool1, tbl1
end

return validateLayeredClothingAccessory
