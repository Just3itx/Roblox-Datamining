-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T04:50:36Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local AvatarExperienceSlotBasedEditor = script:FindFirstAncestor("AvatarExperienceSlotBasedEditor")
local AvatarExperienceSlotBasedEditorParent = AvatarExperienceSlotBasedEditor.Parent
local AXCommon = require(AvatarExperienceSlotBasedEditorParent.AXCommon)
local AvatarExperienceModel = require(AvatarExperienceSlotBasedEditorParent.AvatarExperienceModel)
local ASSET_TYPE_ID_STRING_TO_NAME = AXCommon.Constants.ASSET_TYPE_ID_STRING_TO_NAME
local ASSET_TYPE_NAME_TO_ID_STRING = AXCommon.Constants.ASSET_TYPE_NAME_TO_ID_STRING
local InventoryOutfitTypeToInventoryTypeId = AvatarExperienceModel.Constants.InventoryOutfitTypeToInventoryTypeId
local InventoryOutfitType = AvatarExperienceModel.Enums.InventoryOutfitType
local InventorySearchItemType = require(AvatarExperienceSlotBasedEditor.Enums.InventorySearchItemType)
local _Types = require(AvatarExperienceSlotBasedEditor.Types)

local tbl1 = {
    [ASSET_TYPE_NAME_TO_ID_STRING.Head] = true,
    [ASSET_TYPE_NAME_TO_ID_STRING.Face] = true
}

local AssetSubtypes = {}
for value, value2 in ASSET_TYPE_ID_STRING_TO_NAME do
    if not tbl1[value] then
        AssetSubtypes[tonumber(value)] = value2
    end
end

local OutfitSubtypes = ({})
for value, value2 in InventoryOutfitTypeToInventoryTypeId do
    OutfitSubtypes[value2] = value
end

local tbl4 = {
    Enum.AvatarAssetType.DynamicHead,
    Enum.AvatarAssetType.MoodAnimation,
    Enum.AvatarAssetType.EyebrowAccessory,
    Enum.AvatarAssetType.EyelashAccessory,
    Enum.AvatarAssetType.Torso,
    Enum.AvatarAssetType.LeftArm,
    Enum.AvatarAssetType.RightArm,
    Enum.AvatarAssetType.LeftLeg,
    Enum.AvatarAssetType.RightLeg,
    Enum.AvatarAssetType.ClimbAnimation,
    Enum.AvatarAssetType.FallAnimation,
    Enum.AvatarAssetType.IdleAnimation,
    Enum.AvatarAssetType.JumpAnimation,
    Enum.AvatarAssetType.RunAnimation,
    Enum.AvatarAssetType.SwimAnimation,
    Enum.AvatarAssetType.WalkAnimation,
    Enum.AvatarAssetType.LeftShoeAccessory,
    Enum.AvatarAssetType.RightShoeAccessory,
    Enum.AvatarAssetType.EmoteAnimation
}

local tbl5 = {
    [InventoryOutfitType.Body] = true,
    [InventoryOutfitType.DynamicHead] = true,
    [InventoryOutfitType.Shoes] = true,
    [InventoryOutfitType.Animations] = true
}

local tbl6 = {}
for _, avatarAssetType in tbl4 do
    tbl6[avatarAssetType.Value] = true
end

local tbl7 = {}
for value in AssetSubtypes do
    if not tbl6[value] then
        table.insert(tbl7, value)
    end
end
table.sort(tbl7)

local tbl8 = {}
for value, value2 in InventoryOutfitTypeToInventoryTypeId do
    if tbl5[value] then
        table.insert(tbl8, value2)
    end
end
table.sort(tbl8)

local AllTabItemCategories = {}
for _, itemSubType in tbl7 do
    table.insert(AllTabItemCategories, { itemType = InventorySearchItemType.Asset, itemSubType = itemSubType })
end
for _, itemSubType in tbl8 do
    table.insert(AllTabItemCategories, { itemType = InventorySearchItemType.Outfit, itemSubType = itemSubType })
end

return {
    KeyPrefix = "InventorySearch:",
    MaxPageLimit = 500,
    AssetSubtypes = AssetSubtypes,
    OutfitSubtypes = OutfitSubtypes,
    SearchableSubtypesByItemType = {
        [InventorySearchItemType.Asset] = AssetSubtypes,
        [InventorySearchItemType.Outfit] = OutfitSubtypes
    },
    AllTabItemCategories = AllTabItemCategories
}
