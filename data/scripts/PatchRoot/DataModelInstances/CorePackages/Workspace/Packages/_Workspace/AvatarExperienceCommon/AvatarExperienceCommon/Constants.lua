-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T13:21:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local AvatarExperienceCommonParent = script:FindFirstAncestor("AvatarExperienceCommon").Parent
local LabelAbuseTypeMapping = require(script.Parent.LabelAbuseTypeMapping)
local _CategoryTypes = require(script.Parent.Types.CategoryTypes.CategoryTypes)
local AvatarExperienceFlags = require(AvatarExperienceCommonParent.AvatarExperienceFlags)
local AvatarExperienceModel = require(AvatarExperienceCommonParent.AvatarExperienceModel)
local OutfitTypes = require(script.Parent.Enums.OutfitTypes)
local InventoryOutfitType = AvatarExperienceModel.Enums.InventoryOutfitType
local FFlagAXCatalogMakeupSupport = AvatarExperienceFlags.FFlagAXCatalogMakeupSupport

local DEFAULT_AVATAR_SCALES = table.freeze({ height = 1, width = 1, depth = 1, head = 1, bodyType = 0, proportion = 0 })

local BUNDLE_TYPE_ID_STRING_TO_NAME_FOR_BACKEND = {
    ["1"] = "Body",
    ["2"] = "AvatarAnimations",
    ["3"] = "Shoes",
    ["4"] = "DynamicHead"
}

local ASSET_TYPE_NAME_TO_ID_STRING = ({})
local ASSET_TYPE_ID_STRING_TO_NAME = {}
for _, enumItem in (Enum.AvatarAssetType:GetEnumItems()) do
    local enumItemName = enumItem.Name
    ASSET_TYPE_NAME_TO_ID_STRING[enumItemName] = tostring(enumItem.Value)
    local enumItemValue = enumItem.Value
    ASSET_TYPE_ID_STRING_TO_NAME[tostring(enumItemValue)] = enumItem.Name
end

local ASSET_TYPE_TO_ACCESSORY_TYPE = {}
local HatValue = Enum.AssetType.Hat.Value
ASSET_TYPE_TO_ACCESSORY_TYPE[tostring(HatValue)] = Enum.AccessoryType.Hat
local HairAccessoryValue = Enum.AssetType.HairAccessory.Value
ASSET_TYPE_TO_ACCESSORY_TYPE[tostring(HairAccessoryValue)] = Enum.AccessoryType.Hair
local FaceAccessoryValue = Enum.AssetType.FaceAccessory.Value
ASSET_TYPE_TO_ACCESSORY_TYPE[tostring(FaceAccessoryValue)] = Enum.AccessoryType.Face
local NeckAccessoryValue = Enum.AssetType.NeckAccessory.Value
ASSET_TYPE_TO_ACCESSORY_TYPE[tostring(NeckAccessoryValue)] = Enum.AccessoryType.Neck
local ShoulderAccessoryValue = Enum.AssetType.ShoulderAccessory.Value
ASSET_TYPE_TO_ACCESSORY_TYPE[tostring(ShoulderAccessoryValue)] = Enum.AccessoryType.Shoulder
local FrontAccessoryValue = Enum.AssetType.FrontAccessory.Value
ASSET_TYPE_TO_ACCESSORY_TYPE[tostring(FrontAccessoryValue)] = Enum.AccessoryType.Front
local BackAccessoryValue = Enum.AssetType.BackAccessory.Value
ASSET_TYPE_TO_ACCESSORY_TYPE[tostring(BackAccessoryValue)] = Enum.AccessoryType.Back
local WaistAccessoryValue = Enum.AssetType.WaistAccessory.Value
ASSET_TYPE_TO_ACCESSORY_TYPE[tostring(WaistAccessoryValue)] = Enum.AccessoryType.Waist
local TShirtAccessoryValue = Enum.AssetType.TShirtAccessory.Value
ASSET_TYPE_TO_ACCESSORY_TYPE[tostring(TShirtAccessoryValue)] = Enum.AccessoryType.TShirt
local ShirtAccessoryValue = Enum.AssetType.ShirtAccessory.Value
ASSET_TYPE_TO_ACCESSORY_TYPE[tostring(ShirtAccessoryValue)] = Enum.AccessoryType.Shirt
local PantsAccessoryValue = Enum.AssetType.PantsAccessory.Value
ASSET_TYPE_TO_ACCESSORY_TYPE[tostring(PantsAccessoryValue)] = Enum.AccessoryType.Pants
local JacketAccessoryValue = Enum.AssetType.JacketAccessory.Value
ASSET_TYPE_TO_ACCESSORY_TYPE[tostring(JacketAccessoryValue)] = Enum.AccessoryType.Jacket
local SweaterAccessoryValue = Enum.AssetType.SweaterAccessory.Value
ASSET_TYPE_TO_ACCESSORY_TYPE[tostring(SweaterAccessoryValue)] = Enum.AccessoryType.Sweater
local ShortsAccessoryValue = Enum.AssetType.ShortsAccessory.Value
ASSET_TYPE_TO_ACCESSORY_TYPE[tostring(ShortsAccessoryValue)] = Enum.AccessoryType.Shorts
local LeftShoeAccessoryValue = Enum.AssetType.LeftShoeAccessory.Value
ASSET_TYPE_TO_ACCESSORY_TYPE[tostring(LeftShoeAccessoryValue)] = Enum.AccessoryType.LeftShoe
local RightShoeAccessoryValue = Enum.AssetType.RightShoeAccessory.Value
ASSET_TYPE_TO_ACCESSORY_TYPE[tostring(RightShoeAccessoryValue)] = Enum.AccessoryType.RightShoe
local DressSkirtAccessoryValue = Enum.AssetType.DressSkirtAccessory.Value
ASSET_TYPE_TO_ACCESSORY_TYPE[tostring(DressSkirtAccessoryValue)] = Enum.AccessoryType.DressSkirt
local EyebrowAccessoryValue = Enum.AssetType.EyebrowAccessory.Value
ASSET_TYPE_TO_ACCESSORY_TYPE[tostring(EyebrowAccessoryValue)] = Enum.AccessoryType.Eyebrow
local EyelashAccessoryValue = Enum.AssetType.EyelashAccessory.Value
ASSET_TYPE_TO_ACCESSORY_TYPE[tostring(EyelashAccessoryValue)] = Enum.AccessoryType.Eyelash

local ACCESSORY_TYPE_TO_ASSET_TYPE = ({})
for value, value2 in ASSET_TYPE_TO_ACCESSORY_TYPE do
    ACCESSORY_TYPE_TO_ASSET_TYPE[value2] = value
end

local ASSET_TYPE_ID_STRING_TO_HUMANOID_DESCRIPTION_PROP = {}
local TShirtValue = Enum.AssetType.TShirt.Value
ASSET_TYPE_ID_STRING_TO_HUMANOID_DESCRIPTION_PROP[tostring(TShirtValue)] = "GraphicTShirt"
local HatValue2 = Enum.AssetType.Hat.Value
ASSET_TYPE_ID_STRING_TO_HUMANOID_DESCRIPTION_PROP[tostring(HatValue2)] = "HatAccessory"
local ShirtValue = Enum.AssetType.Shirt.Value
ASSET_TYPE_ID_STRING_TO_HUMANOID_DESCRIPTION_PROP[tostring(ShirtValue)] = "Shirt"
local PantsValue = Enum.AssetType.Pants.Value
ASSET_TYPE_ID_STRING_TO_HUMANOID_DESCRIPTION_PROP[tostring(PantsValue)] = "Pants"
local HeadValue = Enum.AssetType.Head.Value
ASSET_TYPE_ID_STRING_TO_HUMANOID_DESCRIPTION_PROP[tostring(HeadValue)] = "Head"
local FaceValue = Enum.AssetType.Face.Value
ASSET_TYPE_ID_STRING_TO_HUMANOID_DESCRIPTION_PROP[tostring(FaceValue)] = "Face"
local TorsoValue = Enum.AssetType.Torso.Value
ASSET_TYPE_ID_STRING_TO_HUMANOID_DESCRIPTION_PROP[tostring(TorsoValue)] = "Torso"
local RightArmValue = Enum.AssetType.RightArm.Value
ASSET_TYPE_ID_STRING_TO_HUMANOID_DESCRIPTION_PROP[tostring(RightArmValue)] = "RightArm"
local LeftArmValue = Enum.AssetType.LeftArm.Value
ASSET_TYPE_ID_STRING_TO_HUMANOID_DESCRIPTION_PROP[tostring(LeftArmValue)] = "LeftArm"
local LeftLegValue = Enum.AssetType.LeftLeg.Value
ASSET_TYPE_ID_STRING_TO_HUMANOID_DESCRIPTION_PROP[tostring(LeftLegValue)] = "LeftLeg"
local RightLegValue = Enum.AssetType.RightLeg.Value
ASSET_TYPE_ID_STRING_TO_HUMANOID_DESCRIPTION_PROP[tostring(RightLegValue)] = "RightLeg"
local HairAccessoryValue2 = Enum.AssetType.HairAccessory.Value
ASSET_TYPE_ID_STRING_TO_HUMANOID_DESCRIPTION_PROP[tostring(HairAccessoryValue2)] = "HairAccessory"
local FaceAccessoryValue2 = Enum.AssetType.FaceAccessory.Value
ASSET_TYPE_ID_STRING_TO_HUMANOID_DESCRIPTION_PROP[tostring(FaceAccessoryValue2)] = "FaceAccessory"
local NeckAccessoryValue2 = Enum.AssetType.NeckAccessory.Value
ASSET_TYPE_ID_STRING_TO_HUMANOID_DESCRIPTION_PROP[tostring(NeckAccessoryValue2)] = "NeckAccessory"
local ShoulderAccessoryValue2 = Enum.AssetType.ShoulderAccessory.Value
ASSET_TYPE_ID_STRING_TO_HUMANOID_DESCRIPTION_PROP[tostring(ShoulderAccessoryValue2)] = "ShouldersAccessory"
local FrontAccessoryValue2 = Enum.AssetType.FrontAccessory.Value
ASSET_TYPE_ID_STRING_TO_HUMANOID_DESCRIPTION_PROP[tostring(FrontAccessoryValue2)] = "FrontAccessory"
local BackAccessoryValue2 = Enum.AssetType.BackAccessory.Value
ASSET_TYPE_ID_STRING_TO_HUMANOID_DESCRIPTION_PROP[tostring(BackAccessoryValue2)] = "BackAccessory"
local WaistAccessoryValue2 = Enum.AssetType.WaistAccessory.Value
ASSET_TYPE_ID_STRING_TO_HUMANOID_DESCRIPTION_PROP[tostring(WaistAccessoryValue2)] = "WaistAccessory"
local ClimbAnimationValue = Enum.AssetType.ClimbAnimation.Value
ASSET_TYPE_ID_STRING_TO_HUMANOID_DESCRIPTION_PROP[tostring(ClimbAnimationValue)] = "ClimbAnimation"
local FallAnimationValue = Enum.AssetType.FallAnimation.Value
ASSET_TYPE_ID_STRING_TO_HUMANOID_DESCRIPTION_PROP[tostring(FallAnimationValue)] = "FallAnimation"
local IdleAnimationValue = Enum.AssetType.IdleAnimation.Value
ASSET_TYPE_ID_STRING_TO_HUMANOID_DESCRIPTION_PROP[tostring(IdleAnimationValue)] = "IdleAnimation"
local JumpAnimationValue = Enum.AssetType.JumpAnimation.Value
ASSET_TYPE_ID_STRING_TO_HUMANOID_DESCRIPTION_PROP[tostring(JumpAnimationValue)] = "JumpAnimation"
local RunAnimationValue = Enum.AssetType.RunAnimation.Value
ASSET_TYPE_ID_STRING_TO_HUMANOID_DESCRIPTION_PROP[tostring(RunAnimationValue)] = "RunAnimation"
local SwimAnimationValue = Enum.AssetType.SwimAnimation.Value
ASSET_TYPE_ID_STRING_TO_HUMANOID_DESCRIPTION_PROP[tostring(SwimAnimationValue)] = "SwimAnimation"
local WalkAnimationValue = Enum.AssetType.WalkAnimation.Value
ASSET_TYPE_ID_STRING_TO_HUMANOID_DESCRIPTION_PROP[tostring(WalkAnimationValue)] = "WalkAnimation"
local MoodAnimationValue = Enum.AssetType.MoodAnimation.Value
ASSET_TYPE_ID_STRING_TO_HUMANOID_DESCRIPTION_PROP[tostring(MoodAnimationValue)] = "MoodAnimation"

local DynamicHeadValue = Enum.AssetType.DynamicHead.Value
ASSET_TYPE_ID_STRING_TO_HUMANOID_DESCRIPTION_PROP[tostring(DynamicHeadValue)] = "Head"

local LAYERED_CLOTHING_ORDER = {
    [ASSET_TYPE_NAME_TO_ID_STRING.EyebrowAccessory] = 0,
    [ASSET_TYPE_NAME_TO_ID_STRING.EyelashAccessory] = 1,
    [ASSET_TYPE_NAME_TO_ID_STRING.Pants] = 2,
    [ASSET_TYPE_NAME_TO_ID_STRING.Shirt] = 3,
    [ASSET_TYPE_NAME_TO_ID_STRING.TShirt] = 4,
    [ASSET_TYPE_NAME_TO_ID_STRING.LeftShoeAccessory] = 5,
    [ASSET_TYPE_NAME_TO_ID_STRING.RightShoeAccessory] = 5,
    [ASSET_TYPE_NAME_TO_ID_STRING.PantsAccessory] = 6,
    [ASSET_TYPE_NAME_TO_ID_STRING.ShortsAccessory] = 7,
    [ASSET_TYPE_NAME_TO_ID_STRING.DressSkirtAccessory] = 8,
    [ASSET_TYPE_NAME_TO_ID_STRING.TShirtAccessory] = 9,
    [ASSET_TYPE_NAME_TO_ID_STRING.ShirtAccessory] = 10,
    [ASSET_TYPE_NAME_TO_ID_STRING.SweaterAccessory] = 11,
    [ASSET_TYPE_NAME_TO_ID_STRING.JacketAccessory] = 12,
    [ASSET_TYPE_NAME_TO_ID_STRING.HairAccessory] = 13
}

local LAYERED_ASSET_TYPES = {}
local TShirtAccessoryValue2 = Enum.AssetType.TShirtAccessory.Value
LAYERED_ASSET_TYPES[tostring(TShirtAccessoryValue2)] = Enum.AccessoryType.TShirt
local ShirtAccessoryValue2 = Enum.AssetType.ShirtAccessory.Value
LAYERED_ASSET_TYPES[tostring(ShirtAccessoryValue2)] = Enum.AccessoryType.Shirt
local PantsAccessoryValue2 = Enum.AssetType.PantsAccessory.Value
LAYERED_ASSET_TYPES[tostring(PantsAccessoryValue2)] = Enum.AccessoryType.Pants
local JacketAccessoryValue2 = Enum.AssetType.JacketAccessory.Value
LAYERED_ASSET_TYPES[tostring(JacketAccessoryValue2)] = Enum.AccessoryType.Jacket
local SweaterAccessoryValue2 = Enum.AssetType.SweaterAccessory.Value
LAYERED_ASSET_TYPES[tostring(SweaterAccessoryValue2)] = Enum.AccessoryType.Sweater
local ShortsAccessoryValue2 = Enum.AssetType.ShortsAccessory.Value
LAYERED_ASSET_TYPES[tostring(ShortsAccessoryValue2)] = Enum.AccessoryType.Shorts
local LeftShoeAccessoryValue2 = Enum.AssetType.LeftShoeAccessory.Value
LAYERED_ASSET_TYPES[tostring(LeftShoeAccessoryValue2)] = Enum.AccessoryType.LeftShoe
local RightShoeAccessoryValue2 = Enum.AssetType.RightShoeAccessory.Value
LAYERED_ASSET_TYPES[tostring(RightShoeAccessoryValue2)] = Enum.AccessoryType.RightShoe
local DressSkirtAccessoryValue2 = Enum.AssetType.DressSkirtAccessory.Value
LAYERED_ASSET_TYPES[tostring(DressSkirtAccessoryValue2)] = Enum.AccessoryType.DressSkirt
local HairAccessoryValue3 = Enum.AssetType.HairAccessory.Value
LAYERED_ASSET_TYPES[tostring(HairAccessoryValue3)] = Enum.AccessoryType.Hair
local EyebrowAccessoryValue2 = Enum.AssetType.EyebrowAccessory.Value
LAYERED_ASSET_TYPES[tostring(EyebrowAccessoryValue2)] = Enum.AccessoryType.Eyebrow
local EyelashAccessoryValue2 = Enum.AssetType.EyelashAccessory.Value
LAYERED_ASSET_TYPES[tostring(EyelashAccessoryValue2)] = Enum.AccessoryType.Eyelash

local MAKEUP_LOOK_ASSET_TYPES = {
    [ASSET_TYPE_NAME_TO_ID_STRING.EyeMakeup] = true,
    [ASSET_TYPE_NAME_TO_ID_STRING.FaceMakeup] = true,
    [ASSET_TYPE_NAME_TO_ID_STRING.LipMakeup] = true,
    [ASSET_TYPE_NAME_TO_ID_STRING.EyebrowAccessory] = true,
    [ASSET_TYPE_NAME_TO_ID_STRING.EyelashAccessory] = true
}

local ASSET_TYPE_ID_STRING_TO_MAKEUP_TYPE = {
    [ASSET_TYPE_NAME_TO_ID_STRING.EyeMakeup] = Enum.MakeupType.Eye,
    [ASSET_TYPE_NAME_TO_ID_STRING.FaceMakeup] = Enum.MakeupType.Face,
    [ASSET_TYPE_NAME_TO_ID_STRING.LipMakeup] = Enum.MakeupType.Lip
}

local MAKEUP_TYPE_TO_ASSET_TYPE_ID = {
    [Enum.MakeupType.Eye] = ASSET_TYPE_NAME_TO_ID_STRING.EyeMakeup,
    [Enum.MakeupType.Face] = ASSET_TYPE_NAME_TO_ID_STRING.FaceMakeup,
    [Enum.MakeupType.Lip] = ASSET_TYPE_NAME_TO_ID_STRING.LipMakeup
}

local LAYERED_MAKEUP_ORDER = {
    [ASSET_TYPE_NAME_TO_ID_STRING.FaceMakeup] = 0,
    [ASSET_TYPE_NAME_TO_ID_STRING.LipMakeup] = 1,
    [ASSET_TYPE_NAME_TO_ID_STRING.EyeMakeup] = 2
}

local BODY_PART_NAME_TO_ENUM = {
    Head = Enum.BodyPart.Head,
    LeftArm = Enum.BodyPart.LeftArm,
    LeftLeg = Enum.BodyPart.LeftLeg,
    RightArm = Enum.BodyPart.RightArm,
    RightLeg = Enum.BodyPart.RightLeg,
    Torso = Enum.BodyPart.Torso
}

local INVENTORY_OUTFIT_TYPE_TO_OUTFIT_TYPE = {
    [InventoryOutfitType.Body] = OutfitTypes.Avatar,
    [InventoryOutfitType.Avatar] = OutfitTypes.Avatar,
    [InventoryOutfitType.DynamicHead] = OutfitTypes.DynamicHead,
    [InventoryOutfitType.Shoes] = OutfitTypes.Shoes,
    [InventoryOutfitType.Animations] = OutfitTypes.Animations,
    [InventoryOutfitType.PurchasedMakeup] = OutfitTypes.Makeup,
    [InventoryOutfitType.CreatedMakeup] = OutfitTypes.Makeup
}
return {
    BODY_BUNDLE_TYPE_ID = "1",
    SPAWN_EFFECT_ASSET_TYPE_ID_STRING = "97",
    AVATAR_ANIMATIONS_BUNDLE_TYPE_ID = "2",
    SHOES_BUNDLE_TYPE_ID = "3",
    DYNAMIC_HEAD_BUNDLE_TYPE_ID = "4",
    DEFAULT_AVATAR_SCALES = DEFAULT_AVATAR_SCALES,
    BUNDLE_TYPE_ID_STRING_TO_NAME_FOR_BACKEND = BUNDLE_TYPE_ID_STRING_TO_NAME_FOR_BACKEND,
    ASSET_TYPE_TO_ACCESSORY_TYPE = ASSET_TYPE_TO_ACCESSORY_TYPE,
    ACCESSORY_TYPE_TO_ASSET_TYPE = ACCESSORY_TYPE_TO_ASSET_TYPE,
    ASSET_TYPE_ID_STRING_TO_HUMANOID_DESCRIPTION_PROP = ASSET_TYPE_ID_STRING_TO_HUMANOID_DESCRIPTION_PROP,
    HUMANOID_DESCRIPTION_SCALE_TO_NAME = {
        bodyType = "BodyTypeScale",
        head = "HeadScale",
        height = "HeightScale",
        proportion = "ProportionScale",
        depth = "DepthScale",
        width = "WidthScale"
    },
    BODY_PART_FOR_SKIN_COLORING_ID_TO_HUMANOID_DESCRIPTION = {
        headColor3 = "HeadColor",
        leftArmColor3 = "LeftArmColor",
        leftLegColor3 = "LeftLegColor",
        rightArmColor3 = "RightArmColor",
        rightLegColor3 = "RightLegColor",
        torsoColor3 = "TorsoColor"
    },
    ASSET_TYPE_NAME_TO_ID_STRING = ASSET_TYPE_NAME_TO_ID_STRING,
    ASSET_TYPE_ID_STRING_TO_NAME = ASSET_TYPE_ID_STRING_TO_NAME,
    NAVIGATION_DIRECTION = { IS_LEFT = "IS_LEFT", IS_RIGHT = "IS_RIGHT" },
    LANDSCAPE_UI_WIDTH_PERCENTAGE = 0.6,
    LANDSCAPE_SCENE_WIDTH_PERCENTAGE = 0.4,
    AVATAR_BLOCKY_DEFAULT_BUNDLE_ID = "356",
    AX_TOOLTIP_STORAGE_KEY = "AXTooltipStorageKey",
    AX_TOOLTIP_COUNTERS = {
        Seen = "AXTooltipSeen",
        TimeDismiss = "AXTooltipTimeDismiss",
        ClickDismiss = "AXTooltipClickDismiss",
        CallbackDismiss = "AXTooltipCallbackDismiss"
    },
    AVATAR_EDITOR_CONSTANTS = {
        CreateOutfitKey = "avatar.createOutfit",
        CreateMakeupLookKey = if FFlagAXCatalogMakeupSupport then "avatar.createMakeupLook" else nil
    },
    LAYERED_CLOTHING_ORDER = LAYERED_CLOTHING_ORDER,
    LAYERED_ASSET_TYPES = LAYERED_ASSET_TYPES,
    ASSET_TYPE_ID_STRING_TO_MAKEUP_TYPE = ASSET_TYPE_ID_STRING_TO_MAKEUP_TYPE,
    MAKEUP_TYPE_TO_ASSET_TYPE_ID = MAKEUP_TYPE_TO_ASSET_TYPE_ID,
    LAYERED_MAKEUP_ORDER = LAYERED_MAKEUP_ORDER,
    MAKEUP_LOOK_ASSET_TYPES = MAKEUP_LOOK_ASSET_TYPES,
    MAX_MAKEUP_LAYERS = 6,
    LOOK_TYPE = {
        Avatar = "Avatar",
        Makeup = "Makeup",
        Outfit = "Outfit",
        AvatarMoment = "AvatarMoment"
    },
    MIN_MAKEUP_ITEMS_FOR_LAYERING_BUTTON = 2,
    LabelAbuseTypeMapping = LabelAbuseTypeMapping,
    BODY_PART_NAME_TO_ENUM = BODY_PART_NAME_TO_ENUM,
    STATIC_FACIAL_ANIMATION = "StaticFacialAnimation",
    NON_EDITABLE_MAKEUP_GRANT_KEY = "NonEditableMakeup",
    INVENTORY_OUTFIT_TYPE_TO_OUTFIT_TYPE = INVENTORY_OUTFIT_TYPE_TO_OUTFIT_TYPE,
    INVENTORY_TYPE_ID_TO_INVENTORY_OUTFIT_TYPE = AvatarExperienceModel.Constants.InventoryTypeIdToInventoryOutfitType,
    INVENTORY_OUTFIT_TYPE_TO_INVENTORY_TYPE_ID = AvatarExperienceModel.Constants.InventoryOutfitTypeToInventoryTypeId,
    IXP_WIDGET_LAYER_EXPOSURE = { AttributeKey = "IXP_LAYER", TagName = "WIDGET" }
}
