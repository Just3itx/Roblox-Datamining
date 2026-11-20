-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T17:20:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local _Types = require(scriptParentParent.util.Types)
local Constants = require(scriptParentParent.Constants)
local createIndividualBodyPartSchema = require(scriptParentParent.util.createIndividualBodyPartSchema)
local createLayeredClothingSchema = require(scriptParentParent.util.createLayeredClothingSchema)
local createEyebrowEyelashSchema = require(scriptParentParent.util.createEyebrowEyelashSchema)
local createMeshPartAccessorySchema = require(scriptParentParent.util.createMeshPartAccessorySchema)
local createMakeupSchema = require(scriptParentParent.util.createMakeupSchema)
local createDynamicHeadMeshPartSchema = require(scriptParentParent.util.createDynamicHeadMeshPartSchema)
local createAccessorySchema = require(scriptParentParent.util.createAccessorySchema)
local createEmoteSchema = require(scriptParentParent.util.createEmoteSchema)
local createAnimationSchema = require(scriptParentParent.util.createAnimationSchema)
local getUploadCategory = require(scriptParentParent.util.getUploadCategory)
local getFFlagUGCValidationEyebrowEyelashCategory = require(scriptParentParent.flags.getFFlagUGCValidationEyebrowEyelashCategory)

local module = {}

local function getRootInstance(allSelectedInstances) -- Luacid: Inlined by compiler; 1 call site recovered
    for _, value in allSelectedInstances do
        if value.Name == Constants.FOLDER_NAMES.R15ArtistIntent then
            return value
        end
    end

    return allSelectedInstances[1]
end

function module.generateBundleSchema(arg1)
    local tbl1 = {
        ClassName = "Folder",
        _children = {}
    }

    for _, value in arg1 do
        local rootInstance = getRootInstance(value.allSelectedInstances)
        local uploadCategory = getUploadCategory(rootInstance, value.assetTypeEnum, nil)

        local var1 = module.generateAssetSchema(uploadCategory, value.assetTypeEnum, rootInstance)

        if var1.ClassName == "Folder" then
            for _, _child in var1._children do
                table.insert(tbl1._children, _child)
            end
        else
            table.insert(tbl1._children, var1)
        end
    end

    return tbl1
end

local function createBodyPartSchema(arg1)
    local var1 = Constants.ASSET_TYPE_INFO[arg1]

    local tbl1 = {
        ClassName = "Folder",
        _children = {}
    }

    for k in pairs(var1.subParts) do
        local individualBodyPartSchema = createIndividualBodyPartSchema(arg1, k)
        table.insert(tbl1._children, individualBodyPartSchema)
    end
    return tbl1
end

local tbl1 = {
    EMOTE_ANIMATION = function(_, _)
        return createEmoteSchema()
    end,
    DYNAMIC_HEAD = function(_, _)
        return createDynamicHeadMeshPartSchema()
    end,
    TORSO_AND_LIMBS = function(arg1, _)
        return (createBodyPartSchema(arg1))
    end,
    LAYERED_CLOTHING = function(assetType, _)
        if not getFFlagUGCValidationEyebrowEyelashCategory()
            and (assetType == Enum.AssetType.EyebrowAccessory or assetType == Enum.AssetType.EyelashAccessory)
        then
            return createEyebrowEyelashSchema(Constants.ASSET_TYPE_INFO[assetType].attachmentNames)
        end
        return createLayeredClothingSchema(Constants.ASSET_TYPE_INFO[assetType].attachmentNames)
    end,
    EYEBROW_EYELASH = function(arg1, _)
        return createEyebrowEyelashSchema(Constants.ASSET_TYPE_INFO[arg1].attachmentNames)
    end,
    RIGID_ACCESSORY = function(arg1, arg2)
        local var1 = Constants.ASSET_TYPE_INFO[arg1]

        if arg2:FindFirstChildOfClass("MeshPart") then
            return createMeshPartAccessorySchema(var1.attachmentNames)
        end
        return createAccessorySchema(var1.attachmentNames)
    end,
    MAKEUP = function(_, _)
        return createMakeupSchema()
    end
}

function tbl1.ANIMATION(arg1, _)
    return createAnimationSchema(arg1)
end

function module.generateAssetSchema(str1: string, assetTypeEnum, arg1)
    return tbl1[str1](assetTypeEnum, arg1)
end

function module.generateAnimationPackBundleSchema()
    local tbl2 = {
        ClassName = "Model",
        _children = {}
    }

    for _ in Constants.ANIMATION_ASSET_INFO do
        table.insert(tbl2._children, { ClassName = "Folder", Name = "R15Anim", _ignoreDescendants = true })
    end

    return tbl2
end

return module
