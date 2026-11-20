-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T16:30:35Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent

local Constants = require(scriptParent.Constants)
local ValidationRulesUtil = require(scriptParent.util.ValidationRulesUtil)

local flags = scriptParent.flags
local getEngineUGCValidateAssetTextureLimits = require(flags.getEngineUGCValidateAssetTextureLimits)
local module = {}

function module.isBodyPart(arg1)
    return Constants.ASSET_TYPE_INFO[arg1] and Constants.ASSET_TYPE_INFO[arg1].isBodyPart
end

function module.isMakeupAsset(assetType): boolean
    return assetType == Enum.AssetType.LipMakeup
        or assetType == Enum.AssetType.EyeMakeup
        or assetType == Enum.AssetType.FaceMakeup
end

function module.getBodyPartAssets()
    local bodyPartAssets = {}
    for value, value2 in Constants.ASSET_TYPE_INFO do
        if value2.isBodyPart then
            table.insert(bodyPartAssets, value)
        end
    end

    return bodyPartAssets
end

function module.getRigAttachmentToParent(arg1, str1: string)
    arg1 = arg1 or Constants.UGC_BODY_PART_NAMES_TO_ASSET_TYPE[str1]

    if not arg1 then
        return ""
    end

    local var1 = Constants.ASSET_TYPE_INFO[arg1]

    if var1.isBodyPart then
        return var1.subParts[str1].rigAttachmentToParent.name
    end

    return ""
end

function module.getAttachments(arg1, str1: string)
    arg1 = arg1 or Constants.UGC_BODY_PART_NAMES_TO_ASSET_TYPE[str1]
    local subPart

    if arg1 then
        local var1 = Constants.ASSET_TYPE_INFO[arg1]
        if not var1.isBodyPart then
            return {}
        end
        subPart = var1.subParts[str1]
    else
        subPart = nil
    end
    local attachments = {}
    if subPart then
        table.insert(attachments, subPart.rigAttachmentToParent.name)

        for k in subPart.otherAttachments do
            table.insert(attachments, k)
        end
    end
    return attachments
end

function module.getTextureLimit(arg1, arg2, str1: string)
    if not getEngineUGCValidateAssetTextureLimits() then
        return Constants.MAX_TEXTURE_SIZE
    end

    if not arg1 then
        return Constants.MAX_TEXTURE_SIZE
    end

    local assetTextureLimit = ValidationRulesUtil:getRules().TextureRules.AssetTextureLimits[arg1]
    if not assetTextureLimit then
        return Constants.MAX_TEXTURE_SIZE
    end

    if arg2:IsA("SpecialMesh") and str1 == "TextureId" then
        return assetTextureLimit.ColorMapSize
    end

    if arg2:IsA("MeshPart") and str1 == "TextureID" then
        return assetTextureLimit.ColorMapSize
    end

    local isDecal = arg2:IsA("Decal")
    if arg2:IsA("SurfaceAppearance") or isDecal then
        if str1 == "ColorMap" then
            return assetTextureLimit.ColorMapSize
        elseif str1 == "MetalnessMap" then
            return assetTextureLimit.MetalnessMapSize
        elseif str1 == "NormalMap" then
            return assetTextureLimit.NormalMapSize
        elseif str1 == "RoughnessMap" then
            return assetTextureLimit.RoughnessMapSize
        end
    end

    return Constants.MAX_TEXTURE_SIZE
end

return module
