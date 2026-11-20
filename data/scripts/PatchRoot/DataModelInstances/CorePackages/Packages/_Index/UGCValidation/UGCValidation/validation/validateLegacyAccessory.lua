-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T17:41:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local _Types = require(scriptParentParent.util.Types)
local Analytics = require(scriptParentParent.Analytics)
local Constants = require(scriptParentParent.Constants)

local validateInstanceTree = require(scriptParentParent.validation.validateInstanceTree)
local validateTags = require(scriptParentParent.validation.validateTags)
local validateSingleInstance = require(scriptParentParent.validation.validateSingleInstance)
local validateThumbnailConfiguration = require(scriptParentParent.validation.validateThumbnailConfiguration)
local validateScaleType = require(scriptParentParent.validation.validateScaleType)
local validateDependencies = require(scriptParentParent.validation.validateDependencies)
local ValidatePropertiesSensible = require(scriptParentParent.validation.ValidatePropertiesSensible)

local RigidOrLayeredAllowed = require(scriptParentParent.util.RigidOrLayeredAllowed)
local createAccessorySchema = require(scriptParentParent.util.createAccessorySchema)
local getAttachment = require(scriptParentParent.util.getAttachment)
local getEditableMeshFromContext = require(scriptParentParent.util.getEditableMeshFromContext)
local getEditableImageFromContext = require(scriptParentParent.util.getEditableImageFromContext)

local getEngineFeatureEngineUGCValidatePropertiesSensible = require(scriptParentParent.flags.getEngineFeatureEngineUGCValidatePropertiesSensible)

local function validateLegacyAccessory(arg1)
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

    local accessorySchema = createAccessorySchema(var1.attachmentNames)

    local var5, var6 = validateInstanceTree(accessorySchema, var4, arg1)
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
    local specialMesh = handle:FindFirstChildOfClass("SpecialMesh")
    local tbl1 = {
        fullName = specialMesh:GetFullName(),
        fieldName = "MeshId",
        contentId = specialMesh.MeshId,
        context = var4.Name
    }

    local scale = specialMesh.Scale
    local attachment = getAttachment(handle, var1.attachmentNames)

    assert(var1.bounds[attachment.Name], "Could not find bounds for " .. attachment.Name)

    local tbl2 = {}

    local var9, editableMesh = getEditableMeshFromContext(specialMesh, "MeshId", arg1)
    local bool1

    if var9 then
        bool1 = true
    else
        if tbl1.contentId then
            return false, { string.format("Failed to load mesh for legacy accessory '%s'. Make sure mesh exists and try again.", var4.Name) }
        end

        table.insert(tbl2, { string.format(
                "Missing meshId on legacy accessory '%s'. Make sure you are using a valid meshId and try again.\n",
                var4.Name
            ) })
        bool1 = false
    end

    tbl1.editableMesh = editableMesh

    local tbl3 = {
        fullName = specialMesh:GetFullName(),
        fieldName = "TextureId",
        contentId = specialMesh.TextureId
    }

    local var11, editableImage = getEditableImageFromContext(specialMesh, "TextureId", arg1)
    if not var11 then
        return false, { string.format("Failed to load texture for legacy accessory '%s'. Make sure texture exists and try again.", var4.Name) }
    end

    tbl3.editableImage = editableImage

    local var13, var14 = validateTags(var4, arg1)
    if not var13 then
        table.insert(tbl2, table.concat(var14, "\n"))
        bool1 = false
    end

    local avatarPartScaleType = handle:FindFirstChild("AvatarPartScaleType")
    if avatarPartScaleType and avatarPartScaleType:IsA("StringValue") then
        local var15, var16 = validateScaleType(avatarPartScaleType, arg1)
        if not var15 then
            table.insert(tbl2, table.concat(var16, "\n"))
            bool1 = false
        end
    end

    local var15, var16 = validateThumbnailConfiguration(var4, handle, tbl1, scale, arg1)
    if not var15 then
        table.insert(tbl2, table.concat(var16, "\n"))
        bool1 = false
    end

    return bool1, tbl2
end

return validateLegacyAccessory
