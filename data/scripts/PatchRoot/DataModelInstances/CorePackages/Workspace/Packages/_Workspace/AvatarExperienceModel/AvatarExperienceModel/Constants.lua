-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T16:50:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local AvatarExperienceModel = script:FindFirstAncestor("AvatarExperienceModel")
local AvatarExperienceModelParent = AvatarExperienceModel.Parent

local _CommonTypes = require(AvatarExperienceModel.Types.CommonTypes)
local InventoryOutfitType = require(AvatarExperienceModel.Enums.InventoryOutfitType)

local FFlagAXInventoryDurablesSupport = require(AvatarExperienceModelParent.AvatarExperienceFlags).FFlagAXInventoryDurablesSupport

local BundleTypeIdStrings = ({})
local BundleTypeIdStringToName = ({})
local enumItems = Enum.BundleType:GetEnumItems()
for _, enumItem in enumItems do
    local enumItemName = enumItem.Name
    BundleTypeIdStrings[enumItemName] = tostring(enumItem.Value)
    local enumItemValue = enumItem.Value
    BundleTypeIdStringToName[tostring(enumItemValue)] = enumItem.Name
end

if FFlagAXInventoryDurablesSupport then
    local avatars = tostring(#enumItems + 1)
    BundleTypeIdStrings.Avatars = avatars
    BundleTypeIdStringToName[avatars] = "Avatars"
end

local CameraZoomRadius = {
    BodyCategories = { Heads = 8.5, Hair = 8.5, ClassicHeads = 6.5, ClassicFaces = 7 },
    DynamicBodyCategories = {
        Style = 6.5,
        Hair = 8.5,
        ClassicHeads = 6.5,
        ClassicFaces = 7,
        Torsos = 9,
        Arms = 13,
        Legs = 13.5
    },
    CatalogAccessories = {
        Hats = 11,
        Face = 4.5,
        Neck = 9,
        Shoulder = 11,
        Front = 9.5,
        Back = 21,
        Waist = 17
    },
    AvatarEditorAccessories = {
        Hats = 11,
        Face = 7,
        Neck = 9,
        Shoulder = 11,
        Front = 9.5,
        Back = 21,
        Waist = 17
    },
    AccessoryAdjustment = {
        Hat = 11,
        Face = 7,
        Neck = 9,
        Shoulder = 11,
        Front = 21,
        Back = 21,
        Waist = 17
    },
    Clothing = {
        Shirts = 12,
        TShirts = 12,
        Sweaters = 12,
        Jackets = 12,
        Pants = 12,
        Shorts = 12,
        Shoes = 12,
        ClassicShirts = 12,
        ClassicTShirts = 12,
        ClassicPants = 12,
        Tops = 12,
        Outerwear = 12,
        Bottoms = 12,
        Bodysuits = 12
    },
    Makeup = {
        Makeup = game:DefineFastInt("AXMakeupZoomRadius", 7),
        MakeupLooks = game:DefineFastInt("AXMakeupLooksZoomRadius", 7),
        Eyelashes = game:DefineFastInt("AXEyelashesZoomRadius", 7),
        Eyebrows = game:DefineFastInt("AXEyebrowsZoomRadius", 7),
        FaceMakeup = game:DefineFastInt("AXFaceMakeupZoomRadius", 7),
        LipMakeup = game:DefineFastInt("AXLipMakeupZoomRadius", 7),
        EyeMakeup = game:DefineFastInt("AXEyeMakeupZoomRadius", 7)
    },
    Special = {
        HeadRefinement = 7,
        PhotoboothMoments = game:DefineFastInt("AXPhotoboothMomentsZoomRadius", 17)
    }
}

local InventoryTypeIdToInventoryOutfitType = {
    ["1"] = InventoryOutfitType.Body,
    ["2"] = InventoryOutfitType.DynamicHead,
    ["3"] = InventoryOutfitType.Avatar,
    ["4"] = InventoryOutfitType.Shoes,
    ["5"] = InventoryOutfitType.Animations,
    ["6"] = InventoryOutfitType.PurchasedMakeup,
    ["7"] = InventoryOutfitType.CreatedMakeup
}

local InventoryOutfitTypeToInventoryTypeId = ({})
for value, value2 in InventoryTypeIdToInventoryOutfitType do
    InventoryOutfitTypeToInventoryTypeId[value2] = tonumber(value)
end

return {
    AnimationCategoryCameraZoomRadius = 5,
    BundleTypeIdStrings = BundleTypeIdStrings,
    BundleTypeIdStringToName = BundleTypeIdStringToName,
    CameraZoomRadius = CameraZoomRadius,
    InventoryOutfitTypeToInventoryTypeId = InventoryOutfitTypeToInventoryTypeId,
    InventoryTypeIdToInventoryOutfitType = InventoryTypeIdToInventoryOutfitType
}
