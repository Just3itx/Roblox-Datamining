-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T22:11:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local CorePackages = game:GetService("CorePackages")
local FFlagAXInspectAndBuyMakeupSupport = require(CorePackages.Workspace.Packages.AvatarExperienceFlags).FFlagAXInspectAndBuyMakeupSupport

local tbl1 = {
    NotificationKeys = {
        MultipleBundleNoticeKey = "InGame.InspectMenu.Description.MultipleBundlesNotice",
        SingleBundleNoticeKey = "InGame.InspectMenu.Description.SingleBundleNotice",
        LimitedItemNoticeKey = "InGame.InspectMenu.Description.LimitedNotice",
        LayeredClothingOnR6Key = "InGame.InspectMenu.Description.LayeredClothingR6"
    },
    ItemType = { Asset = "Asset", Bundle = "Bundle" },
    View = { Compact = 0, Wide = 1, WideLandscape = 2 },
    AssetCategories = {
        Animation = "Animation",
        Body = "Body",
        Clothing = "Clothing",
        Accessory = "Accessory",
        Emotes = "Emotes",
        Makeup = if FFlagAXInspectAndBuyMakeupSupport then "Makeup" else nil
    },
    AssetTypeIdStringToHumanoidDescriptionProp = 0,
    AnimationAssetTypes = 0,
    AssetTypeIdToAccessoryTypeEnum = 0,
    LayeredAssetTypes = 0,
    AssetCategory = 0
}

local AssetTypeIdStringToHumanoidDescriptionProp = {}
local TShirtValue = Enum.AssetType.TShirt.Value
AssetTypeIdStringToHumanoidDescriptionProp[tostring(TShirtValue)] = "GraphicTShirt"
local HatValue = Enum.AssetType.Hat.Value
AssetTypeIdStringToHumanoidDescriptionProp[tostring(HatValue)] = "HatAccessory"
local ShirtValue = Enum.AssetType.Shirt.Value
AssetTypeIdStringToHumanoidDescriptionProp[tostring(ShirtValue)] = "Shirt"
local PantsValue = Enum.AssetType.Pants.Value
AssetTypeIdStringToHumanoidDescriptionProp[tostring(PantsValue)] = "Pants"
local HeadValue = Enum.AssetType.Head.Value
AssetTypeIdStringToHumanoidDescriptionProp[tostring(HeadValue)] = "Head"
local FaceValue = Enum.AssetType.Face.Value
AssetTypeIdStringToHumanoidDescriptionProp[tostring(FaceValue)] = "Face"
local TorsoValue = Enum.AssetType.Torso.Value
AssetTypeIdStringToHumanoidDescriptionProp[tostring(TorsoValue)] = "Torso"
local RightArmValue = Enum.AssetType.RightArm.Value
AssetTypeIdStringToHumanoidDescriptionProp[tostring(RightArmValue)] = "RightArm"
local LeftArmValue = Enum.AssetType.LeftArm.Value
AssetTypeIdStringToHumanoidDescriptionProp[tostring(LeftArmValue)] = "LeftArm"
local LeftLegValue = Enum.AssetType.LeftLeg.Value
AssetTypeIdStringToHumanoidDescriptionProp[tostring(LeftLegValue)] = "LeftLeg"
local RightLegValue = Enum.AssetType.RightLeg.Value
AssetTypeIdStringToHumanoidDescriptionProp[tostring(RightLegValue)] = "RightLeg"
local HairAccessoryValue = Enum.AssetType.HairAccessory.Value
AssetTypeIdStringToHumanoidDescriptionProp[tostring(HairAccessoryValue)] = "HairAccessory"
local FaceAccessoryValue = Enum.AssetType.FaceAccessory.Value
AssetTypeIdStringToHumanoidDescriptionProp[tostring(FaceAccessoryValue)] = "FaceAccessory"
local NeckAccessoryValue = Enum.AssetType.NeckAccessory.Value
AssetTypeIdStringToHumanoidDescriptionProp[tostring(NeckAccessoryValue)] = "NeckAccessory"
local ShoulderAccessoryValue = Enum.AssetType.ShoulderAccessory.Value
AssetTypeIdStringToHumanoidDescriptionProp[tostring(ShoulderAccessoryValue)] = "ShouldersAccessory"
local FrontAccessoryValue = Enum.AssetType.FrontAccessory.Value
AssetTypeIdStringToHumanoidDescriptionProp[tostring(FrontAccessoryValue)] = "FrontAccessory"
local BackAccessoryValue = Enum.AssetType.BackAccessory.Value
AssetTypeIdStringToHumanoidDescriptionProp[tostring(BackAccessoryValue)] = "BackAccessory"
local WaistAccessoryValue = Enum.AssetType.WaistAccessory.Value
AssetTypeIdStringToHumanoidDescriptionProp[tostring(WaistAccessoryValue)] = "WaistAccessory"
local ClimbAnimationValue = Enum.AssetType.ClimbAnimation.Value
AssetTypeIdStringToHumanoidDescriptionProp[tostring(ClimbAnimationValue)] = "ClimbAnimation"
local FallAnimationValue = Enum.AssetType.FallAnimation.Value
AssetTypeIdStringToHumanoidDescriptionProp[tostring(FallAnimationValue)] = "FallAnimation"
local IdleAnimationValue = Enum.AssetType.IdleAnimation.Value
AssetTypeIdStringToHumanoidDescriptionProp[tostring(IdleAnimationValue)] = "IdleAnimation"
local JumpAnimationValue = Enum.AssetType.JumpAnimation.Value
AssetTypeIdStringToHumanoidDescriptionProp[tostring(JumpAnimationValue)] = "JumpAnimation"
local RunAnimationValue = Enum.AssetType.RunAnimation.Value
AssetTypeIdStringToHumanoidDescriptionProp[tostring(RunAnimationValue)] = "RunAnimation"
local SwimAnimationValue = Enum.AssetType.SwimAnimation.Value
AssetTypeIdStringToHumanoidDescriptionProp[tostring(SwimAnimationValue)] = "SwimAnimation"
local WalkAnimationValue = Enum.AssetType.WalkAnimation.Value
AssetTypeIdStringToHumanoidDescriptionProp[tostring(WalkAnimationValue)] = "WalkAnimation"

local DynamicHeadValue = Enum.AssetType.DynamicHead.Value
AssetTypeIdStringToHumanoidDescriptionProp[tostring(DynamicHeadValue)] = "Head"
tbl1.AssetTypeIdStringToHumanoidDescriptionProp = AssetTypeIdStringToHumanoidDescriptionProp

tbl1.AnimationAssetTypes = {
    ["48"] = 48,
    ["50"] = 50,
    ["51"] = 51,
    ["52"] = 52,
    ["53"] = 53,
    ["54"] = 54,
    ["55"] = 55,
    ["61"] = 61,
    ["78"] = 78
}

local AssetTypeIdToAccessoryTypeEnum = {}
local HatValue2 = Enum.AssetType.Hat.Value
AssetTypeIdToAccessoryTypeEnum[tostring(HatValue2)] = Enum.AccessoryType.Hat
local HairAccessoryValue2 = Enum.AssetType.HairAccessory.Value
AssetTypeIdToAccessoryTypeEnum[tostring(HairAccessoryValue2)] = Enum.AccessoryType.Hair
local FaceAccessoryValue2 = Enum.AssetType.FaceAccessory.Value
AssetTypeIdToAccessoryTypeEnum[tostring(FaceAccessoryValue2)] = Enum.AccessoryType.Face
local NeckAccessoryValue2 = Enum.AssetType.NeckAccessory.Value
AssetTypeIdToAccessoryTypeEnum[tostring(NeckAccessoryValue2)] = Enum.AccessoryType.Neck
local ShoulderAccessoryValue2 = Enum.AssetType.ShoulderAccessory.Value
AssetTypeIdToAccessoryTypeEnum[tostring(ShoulderAccessoryValue2)] = Enum.AccessoryType.Shoulder
local FrontAccessoryValue2 = Enum.AssetType.FrontAccessory.Value
AssetTypeIdToAccessoryTypeEnum[tostring(FrontAccessoryValue2)] = Enum.AccessoryType.Front
local BackAccessoryValue2 = Enum.AssetType.BackAccessory.Value
AssetTypeIdToAccessoryTypeEnum[tostring(BackAccessoryValue2)] = Enum.AccessoryType.Back
local WaistAccessoryValue2 = Enum.AssetType.WaistAccessory.Value
AssetTypeIdToAccessoryTypeEnum[tostring(WaistAccessoryValue2)] = Enum.AccessoryType.Waist
local TShirtAccessoryValue = Enum.AssetType.TShirtAccessory.Value
AssetTypeIdToAccessoryTypeEnum[tostring(TShirtAccessoryValue)] = Enum.AccessoryType.TShirt
local ShirtAccessoryValue = Enum.AssetType.ShirtAccessory.Value
AssetTypeIdToAccessoryTypeEnum[tostring(ShirtAccessoryValue)] = Enum.AccessoryType.Shirt
local PantsAccessoryValue = Enum.AssetType.PantsAccessory.Value
AssetTypeIdToAccessoryTypeEnum[tostring(PantsAccessoryValue)] = Enum.AccessoryType.Pants
local JacketAccessoryValue = Enum.AssetType.JacketAccessory.Value
AssetTypeIdToAccessoryTypeEnum[tostring(JacketAccessoryValue)] = Enum.AccessoryType.Jacket
local SweaterAccessoryValue = Enum.AssetType.SweaterAccessory.Value
AssetTypeIdToAccessoryTypeEnum[tostring(SweaterAccessoryValue)] = Enum.AccessoryType.Sweater
local ShortsAccessoryValue = Enum.AssetType.ShortsAccessory.Value
AssetTypeIdToAccessoryTypeEnum[tostring(ShortsAccessoryValue)] = Enum.AccessoryType.Shorts
local LeftShoeAccessoryValue = Enum.AssetType.LeftShoeAccessory.Value
AssetTypeIdToAccessoryTypeEnum[tostring(LeftShoeAccessoryValue)] = Enum.AccessoryType.LeftShoe
local RightShoeAccessoryValue = Enum.AssetType.RightShoeAccessory.Value
AssetTypeIdToAccessoryTypeEnum[tostring(RightShoeAccessoryValue)] = Enum.AccessoryType.RightShoe
local DressSkirtAccessoryValue = Enum.AssetType.DressSkirtAccessory.Value
AssetTypeIdToAccessoryTypeEnum[tostring(DressSkirtAccessoryValue)] = Enum.AccessoryType.DressSkirt
local EyebrowAccessoryValue = Enum.AssetType.EyebrowAccessory.Value
AssetTypeIdToAccessoryTypeEnum[tostring(EyebrowAccessoryValue)] = Enum.AccessoryType.Eyebrow
local EyelashAccessoryValue = Enum.AssetType.EyelashAccessory.Value
AssetTypeIdToAccessoryTypeEnum[tostring(EyelashAccessoryValue)] = Enum.AccessoryType.Eyelash
tbl1.AssetTypeIdToAccessoryTypeEnum = AssetTypeIdToAccessoryTypeEnum

local LayeredAssetTypes = {}
local TShirtAccessoryValue2 = Enum.AssetType.TShirtAccessory.Value
LayeredAssetTypes[tostring(TShirtAccessoryValue2)] = Enum.AccessoryType.TShirt
local ShirtAccessoryValue2 = Enum.AssetType.ShirtAccessory.Value
LayeredAssetTypes[tostring(ShirtAccessoryValue2)] = Enum.AccessoryType.Shirt
local PantsAccessoryValue2 = Enum.AssetType.PantsAccessory.Value
LayeredAssetTypes[tostring(PantsAccessoryValue2)] = Enum.AccessoryType.Pants
local JacketAccessoryValue2 = Enum.AssetType.JacketAccessory.Value
LayeredAssetTypes[tostring(JacketAccessoryValue2)] = Enum.AccessoryType.Jacket
local SweaterAccessoryValue2 = Enum.AssetType.SweaterAccessory.Value
LayeredAssetTypes[tostring(SweaterAccessoryValue2)] = Enum.AccessoryType.Sweater
local ShortsAccessoryValue2 = Enum.AssetType.ShortsAccessory.Value
LayeredAssetTypes[tostring(ShortsAccessoryValue2)] = Enum.AccessoryType.Shorts
local LeftShoeAccessoryValue2 = Enum.AssetType.LeftShoeAccessory.Value
LayeredAssetTypes[tostring(LeftShoeAccessoryValue2)] = Enum.AccessoryType.LeftShoe
local RightShoeAccessoryValue2 = Enum.AssetType.RightShoeAccessory.Value
LayeredAssetTypes[tostring(RightShoeAccessoryValue2)] = Enum.AccessoryType.RightShoe
local DressSkirtAccessoryValue2 = Enum.AssetType.DressSkirtAccessory.Value
LayeredAssetTypes[tostring(DressSkirtAccessoryValue2)] = Enum.AccessoryType.DressSkirt
local HairAccessoryValue3 = Enum.AssetType.HairAccessory.Value
LayeredAssetTypes[tostring(HairAccessoryValue3)] = Enum.AccessoryType.Hair
local EyebrowAccessoryValue2 = Enum.AssetType.EyebrowAccessory.Value
LayeredAssetTypes[tostring(EyebrowAccessoryValue2)] = Enum.AccessoryType.Eyebrow
local EyelashAccessoryValue2 = Enum.AssetType.EyelashAccessory.Value
LayeredAssetTypes[tostring(EyelashAccessoryValue2)] = Enum.AccessoryType.Eyelash
tbl1.LayeredAssetTypes = LayeredAssetTypes

tbl1.AssetCategory = { Tops = "Tops", Bottoms = "Bottoms" }

local AssetTypeIdToCategory = {}
local TShirtValue2 = Enum.AssetType.TShirt.Value
AssetTypeIdToCategory[tostring(TShirtValue2)] = tbl1.AssetCategories.Clothing
local HatValue3 = Enum.AssetType.Hat.Value
AssetTypeIdToCategory[tostring(HatValue3)] = tbl1.AssetCategories.Accessory
local HairAccessoryValue4 = Enum.AssetType.HairAccessory.Value
AssetTypeIdToCategory[tostring(HairAccessoryValue4)] = tbl1.AssetCategories.Accessory
local FaceAccessoryValue3 = Enum.AssetType.FaceAccessory.Value
AssetTypeIdToCategory[tostring(FaceAccessoryValue3)] = tbl1.AssetCategories.Accessory
local NeckAccessoryValue3 = Enum.AssetType.NeckAccessory.Value
AssetTypeIdToCategory[tostring(NeckAccessoryValue3)] = tbl1.AssetCategories.Accessory
local ShoulderAccessoryValue3 = Enum.AssetType.ShoulderAccessory.Value
AssetTypeIdToCategory[tostring(ShoulderAccessoryValue3)] = tbl1.AssetCategories.Accessory
local FrontAccessoryValue3 = Enum.AssetType.FrontAccessory.Value
AssetTypeIdToCategory[tostring(FrontAccessoryValue3)] = tbl1.AssetCategories.Accessory
local BackAccessoryValue3 = Enum.AssetType.BackAccessory.Value
AssetTypeIdToCategory[tostring(BackAccessoryValue3)] = tbl1.AssetCategories.Accessory
local WaistAccessoryValue3 = Enum.AssetType.WaistAccessory.Value
AssetTypeIdToCategory[tostring(WaistAccessoryValue3)] = tbl1.AssetCategories.Accessory
local ShirtValue2 = Enum.AssetType.Shirt.Value
AssetTypeIdToCategory[tostring(ShirtValue2)] = tbl1.AssetCategories.Clothing
local PantsValue2 = Enum.AssetType.Pants.Value
AssetTypeIdToCategory[tostring(PantsValue2)] = tbl1.AssetCategories.Clothing
local GearValue = Enum.AssetType.Gear.Value
AssetTypeIdToCategory[tostring(GearValue)] = tbl1.AssetCategories.Accessory
local HeadValue2 = Enum.AssetType.Head.Value
AssetTypeIdToCategory[tostring(HeadValue2)] = tbl1.AssetCategories.Body
local FaceValue2 = Enum.AssetType.Face.Value
AssetTypeIdToCategory[tostring(FaceValue2)] = tbl1.AssetCategories.Body
local TorsoValue2 = Enum.AssetType.Torso.Value
AssetTypeIdToCategory[tostring(TorsoValue2)] = tbl1.AssetCategories.Body
local RightArmValue2 = Enum.AssetType.RightArm.Value
AssetTypeIdToCategory[tostring(RightArmValue2)] = tbl1.AssetCategories.Body
local LeftArmValue2 = Enum.AssetType.LeftArm.Value
AssetTypeIdToCategory[tostring(LeftArmValue2)] = tbl1.AssetCategories.Body
local LeftLegValue2 = Enum.AssetType.LeftLeg.Value
AssetTypeIdToCategory[tostring(LeftLegValue2)] = tbl1.AssetCategories.Body
local RightLegValue2 = Enum.AssetType.RightLeg.Value
AssetTypeIdToCategory[tostring(RightLegValue2)] = tbl1.AssetCategories.Body
local ClimbAnimationValue2 = Enum.AssetType.ClimbAnimation.Value
AssetTypeIdToCategory[tostring(ClimbAnimationValue2)] = tbl1.AssetCategories.Animation
local FallAnimationValue2 = Enum.AssetType.FallAnimation.Value
AssetTypeIdToCategory[tostring(FallAnimationValue2)] = tbl1.AssetCategories.Animation
local IdleAnimationValue2 = Enum.AssetType.IdleAnimation.Value
AssetTypeIdToCategory[tostring(IdleAnimationValue2)] = tbl1.AssetCategories.Animation
local JumpAnimationValue2 = Enum.AssetType.JumpAnimation.Value
AssetTypeIdToCategory[tostring(JumpAnimationValue2)] = tbl1.AssetCategories.Animation
local RunAnimationValue2 = Enum.AssetType.RunAnimation.Value
AssetTypeIdToCategory[tostring(RunAnimationValue2)] = tbl1.AssetCategories.Animation
local SwimAnimationValue2 = Enum.AssetType.SwimAnimation.Value
AssetTypeIdToCategory[tostring(SwimAnimationValue2)] = tbl1.AssetCategories.Animation
local WalkAnimationValue2 = Enum.AssetType.WalkAnimation.Value
AssetTypeIdToCategory[tostring(WalkAnimationValue2)] = tbl1.AssetCategories.Animation
local EmoteAnimationValue = Enum.AssetType.EmoteAnimation.Value
AssetTypeIdToCategory[tostring(EmoteAnimationValue)] = tbl1.AssetCategories.Animation
local TShirtAccessoryValue3 = Enum.AssetType.TShirtAccessory.Value
AssetTypeIdToCategory[tostring(TShirtAccessoryValue3)] = tbl1.AssetCategories.Accessory
local ShirtAccessoryValue3 = Enum.AssetType.ShirtAccessory.Value
AssetTypeIdToCategory[tostring(ShirtAccessoryValue3)] = tbl1.AssetCategories.Accessory
local PantsAccessoryValue3 = Enum.AssetType.PantsAccessory.Value
AssetTypeIdToCategory[tostring(PantsAccessoryValue3)] = tbl1.AssetCategories.Accessory
local JacketAccessoryValue3 = Enum.AssetType.JacketAccessory.Value
AssetTypeIdToCategory[tostring(JacketAccessoryValue3)] = tbl1.AssetCategories.Accessory
local SweaterAccessoryValue3 = Enum.AssetType.SweaterAccessory.Value
AssetTypeIdToCategory[tostring(SweaterAccessoryValue3)] = tbl1.AssetCategories.Accessory
local ShortsAccessoryValue3 = Enum.AssetType.ShortsAccessory.Value
AssetTypeIdToCategory[tostring(ShortsAccessoryValue3)] = tbl1.AssetCategories.Accessory
local LeftShoeAccessoryValue3 = Enum.AssetType.LeftShoeAccessory.Value
AssetTypeIdToCategory[tostring(LeftShoeAccessoryValue3)] = tbl1.AssetCategories.Accessory
local RightShoeAccessoryValue3 = Enum.AssetType.RightShoeAccessory.Value
AssetTypeIdToCategory[tostring(RightShoeAccessoryValue3)] = tbl1.AssetCategories.Accessory
local DressSkirtAccessoryValue3 = Enum.AssetType.DressSkirtAccessory.Value
AssetTypeIdToCategory[tostring(DressSkirtAccessoryValue3)] = tbl1.AssetCategories.Accessory
local EyelashAccessoryValue3 = Enum.AssetType.EyelashAccessory.Value
AssetTypeIdToCategory[tostring(EyelashAccessoryValue3)] = tbl1.AssetCategories.Accessory
local EyebrowAccessoryValue3 = Enum.AssetType.EyebrowAccessory.Value
AssetTypeIdToCategory[tostring(EyebrowAccessoryValue3)] = tbl1.AssetCategories.Accessory
local MoodAnimationValue = Enum.AssetType.MoodAnimation.Value
AssetTypeIdToCategory[tostring(MoodAnimationValue)] = tbl1.AssetCategories.Animation
local DynamicHeadValue2 = Enum.AssetType.DynamicHead.Value
AssetTypeIdToCategory[tostring(DynamicHeadValue2)] = tbl1.AssetCategories.Body
tbl1.AssetTypeIdToCategory = AssetTypeIdToCategory

if FFlagAXInspectAndBuyMakeupSupport then
    local assetTypeIdToCategory = tbl1.AssetTypeIdToCategory
    local eyeMakeupValue = Enum.AssetType.EyeMakeup.Value
    assetTypeIdToCategory[tostring(eyeMakeupValue)] = tbl1.AssetCategories.Makeup
    local assetTypeIdToCategory2 = tbl1.AssetTypeIdToCategory
    local faceMakeupValue = Enum.AssetType.FaceMakeup.Value
    assetTypeIdToCategory2[tostring(faceMakeupValue)] = tbl1.AssetCategories.Makeup
    local assetTypeIdToCategory3 = tbl1.AssetTypeIdToCategory
    local lipMakeupValue = Enum.AssetType.LipMakeup.Value
    assetTypeIdToCategory3[tostring(lipMakeupValue)] = tbl1.AssetCategories.Makeup
end

tbl1.AssetCategoriesLocalized = {
    [tbl1.AssetCategories.Animation] = "Feature.Catalog.Label.Animation",
    [tbl1.AssetCategories.Body] = "Feature.Catalog.Label.Body",
    [tbl1.AssetCategories.Clothing] = "Feature.Avatar.Heading.Clothing",
    [tbl1.AssetCategories.Accessory] = "Feature.Avatar.Label.Accessory",
    [tbl1.AssetCategories.Emotes] = "Feature.Catalog.Label.Emotes"
}

if FFlagAXInspectAndBuyMakeupSupport then
    tbl1.AssetCategoriesLocalized[tbl1.AssetCategories.Makeup] = "Feature.Catalog.Label.Makeup"
end

local AssetTypeIdToTypeLocalized = {}
local TShirtValue3 = Enum.AssetType.TShirt.Value
AssetTypeIdToTypeLocalized[tostring(TShirtValue3)] = "Feature.Avatar.Label.ClassicTShirts"
local HatValue4 = Enum.AssetType.Hat.Value
AssetTypeIdToTypeLocalized[tostring(HatValue4)] = "Feature.Avatar.Label.Hat"
local HairAccessoryValue5 = Enum.AssetType.HairAccessory.Value
AssetTypeIdToTypeLocalized[tostring(HairAccessoryValue5)] = "Feature.Avatar.Label.Hair"
local FaceAccessoryValue4 = Enum.AssetType.FaceAccessory.Value
AssetTypeIdToTypeLocalized[tostring(FaceAccessoryValue4)] = "Feature.Avatar.Label.Face"
local NeckAccessoryValue4 = Enum.AssetType.NeckAccessory.Value
AssetTypeIdToTypeLocalized[tostring(NeckAccessoryValue4)] = "Feature.Avatar.Label.Neck"
local ShoulderAccessoryValue4 = Enum.AssetType.ShoulderAccessory.Value
AssetTypeIdToTypeLocalized[tostring(ShoulderAccessoryValue4)] = "Feature.Avatar.Label.Shoulder"
local FrontAccessoryValue4 = Enum.AssetType.FrontAccessory.Value
AssetTypeIdToTypeLocalized[tostring(FrontAccessoryValue4)] = "Feature.Avatar.Label.Front"
local BackAccessoryValue4 = Enum.AssetType.BackAccessory.Value
AssetTypeIdToTypeLocalized[tostring(BackAccessoryValue4)] = "Feature.Avatar.Label.Back"
local WaistAccessoryValue4 = Enum.AssetType.WaistAccessory.Value
AssetTypeIdToTypeLocalized[tostring(WaistAccessoryValue4)] = "Feature.Avatar.Label.Waist"
local ShirtValue3 = Enum.AssetType.Shirt.Value
AssetTypeIdToTypeLocalized[tostring(ShirtValue3)] = "Feature.Avatar.Label.ClassicShirts"
local PantsValue3 = Enum.AssetType.Pants.Value
AssetTypeIdToTypeLocalized[tostring(PantsValue3)] = "Feature.Avatar.Label.ClassicPants"
local GearValue2 = Enum.AssetType.Gear.Value
AssetTypeIdToTypeLocalized[tostring(GearValue2)] = "Feature.Avatar.Label.Gear"
local HeadValue3 = Enum.AssetType.Head.Value
AssetTypeIdToTypeLocalized[tostring(HeadValue3)] = "Feature.Avatar.Label.Head"
local FaceValue3 = Enum.AssetType.Face.Value
AssetTypeIdToTypeLocalized[tostring(FaceValue3)] = "Feature.Avatar.Label.Face"
local TorsoValue3 = Enum.AssetType.Torso.Value
AssetTypeIdToTypeLocalized[tostring(TorsoValue3)] = "Feature.Avatar.Label.Torso"
local RightArmValue3 = Enum.AssetType.RightArm.Value
AssetTypeIdToTypeLocalized[tostring(RightArmValue3)] = "Feature.Avatar.Label.RightArms"
local LeftArmValue3 = Enum.AssetType.LeftArm.Value
AssetTypeIdToTypeLocalized[tostring(LeftArmValue3)] = "Feature.Avatar.Label.LeftArms"
local LeftLegValue3 = Enum.AssetType.LeftLeg.Value
AssetTypeIdToTypeLocalized[tostring(LeftLegValue3)] = "Feature.Avatar.Label.LeftLegs"
local RightLegValue3 = Enum.AssetType.RightLeg.Value
AssetTypeIdToTypeLocalized[tostring(RightLegValue3)] = "Feature.Avatar.Label.RightLegs"
local ClimbAnimationValue3 = Enum.AssetType.ClimbAnimation.Value
AssetTypeIdToTypeLocalized[tostring(ClimbAnimationValue3)] = "Feature.Avatar.Label.Climb"
local FallAnimationValue3 = Enum.AssetType.FallAnimation.Value
AssetTypeIdToTypeLocalized[tostring(FallAnimationValue3)] = "Feature.Avatar.Label.Fall"
local IdleAnimationValue3 = Enum.AssetType.IdleAnimation.Value
AssetTypeIdToTypeLocalized[tostring(IdleAnimationValue3)] = "Feature.Avatar.Label.Idle"
local JumpAnimationValue3 = Enum.AssetType.JumpAnimation.Value
AssetTypeIdToTypeLocalized[tostring(JumpAnimationValue3)] = "Feature.Avatar.Label.Jump"
local RunAnimationValue3 = Enum.AssetType.RunAnimation.Value
AssetTypeIdToTypeLocalized[tostring(RunAnimationValue3)] = "Feature.Avatar.Label.Run"
local SwimAnimationValue3 = Enum.AssetType.SwimAnimation.Value
AssetTypeIdToTypeLocalized[tostring(SwimAnimationValue3)] = "Feature.Avatar.Label.Swim"
local WalkAnimationValue3 = Enum.AssetType.WalkAnimation.Value
AssetTypeIdToTypeLocalized[tostring(WalkAnimationValue3)] = "Feature.Avatar.Label.Walk"
local EmoteAnimationValue2 = Enum.AssetType.EmoteAnimation.Value
AssetTypeIdToTypeLocalized[tostring(EmoteAnimationValue2)] = "Feature.Avatar.Label.Emote"
local TShirtAccessoryValue4 = Enum.AssetType.TShirtAccessory.Value
AssetTypeIdToTypeLocalized[tostring(TShirtAccessoryValue4)] = "Feature.Avatar.Label.TShirt"
local ShirtAccessoryValue4 = Enum.AssetType.ShirtAccessory.Value
AssetTypeIdToTypeLocalized[tostring(ShirtAccessoryValue4)] = "Feature.Avatar.Label.Shirt"
local PantsAccessoryValue4 = Enum.AssetType.PantsAccessory.Value
AssetTypeIdToTypeLocalized[tostring(PantsAccessoryValue4)] = "Feature.Avatar.Label.Pants"
local JacketAccessoryValue4 = Enum.AssetType.JacketAccessory.Value
AssetTypeIdToTypeLocalized[tostring(JacketAccessoryValue4)] = "Feature.Avatar.Label.Jacket"
local SweaterAccessoryValue4 = Enum.AssetType.SweaterAccessory.Value
AssetTypeIdToTypeLocalized[tostring(SweaterAccessoryValue4)] = "Feature.Avatar.Label.Sweater"
local ShortsAccessoryValue4 = Enum.AssetType.ShortsAccessory.Value
AssetTypeIdToTypeLocalized[tostring(ShortsAccessoryValue4)] = "Feature.Avatar.Label.Shorts"
local LeftShoeAccessoryValue4 = Enum.AssetType.LeftShoeAccessory.Value
AssetTypeIdToTypeLocalized[tostring(LeftShoeAccessoryValue4)] = "Feature.Avatar.Label.LeftShoe"
local RightShoeAccessoryValue4 = Enum.AssetType.RightShoeAccessory.Value
AssetTypeIdToTypeLocalized[tostring(RightShoeAccessoryValue4)] = "Feature.Avatar.Label.RightShoe"
local DressSkirtAccessoryValue4 = Enum.AssetType.DressSkirtAccessory.Value
AssetTypeIdToTypeLocalized[tostring(DressSkirtAccessoryValue4)] = "Feature.Avatar.Label.DressesAndSkirts"
local EyelashAccessoryValue4 = Enum.AssetType.EyelashAccessory.Value
AssetTypeIdToTypeLocalized[tostring(EyelashAccessoryValue4)] = "Feature.Catalog.Label.Eyelash"
local EyebrowAccessoryValue4 = Enum.AssetType.EyebrowAccessory.Value
AssetTypeIdToTypeLocalized[tostring(EyebrowAccessoryValue4)] = "Feature.Catalog.Label.Eyebrow"
local MoodAnimationValue2 = Enum.AssetType.MoodAnimation.Value
AssetTypeIdToTypeLocalized[tostring(MoodAnimationValue2)] = "Feature.Avatar.Label.Mood"
local DynamicHeadValue3 = Enum.AssetType.DynamicHead.Value
AssetTypeIdToTypeLocalized[tostring(DynamicHeadValue3)] = "Feature.Avatar.Label.DynamicHead"
tbl1.AssetTypeIdToTypeLocalized = AssetTypeIdToTypeLocalized

if FFlagAXInspectAndBuyMakeupSupport then
    local assetTypeIdToTypeLocalized = tbl1.AssetTypeIdToTypeLocalized
    local eyeMakeupValue = Enum.AssetType.EyeMakeup.Value
    assetTypeIdToTypeLocalized[tostring(eyeMakeupValue)] = "Feature.Catalog.Label.EyeMakeup"
    local assetTypeIdToTypeLocalized2 = tbl1.AssetTypeIdToTypeLocalized
    local faceMakeupValue = Enum.AssetType.FaceMakeup.Value
    assetTypeIdToTypeLocalized2[tostring(faceMakeupValue)] = "Feature.Catalog.Label.FaceMakeup"
    local assetTypeIdToTypeLocalized3 = tbl1.AssetTypeIdToTypeLocalized
    local lipMakeupValue = Enum.AssetType.LipMakeup.Value
    assetTypeIdToTypeLocalized3[tostring(lipMakeupValue)] = "Feature.Catalog.Label.LipMakeup"
end

tbl1.MoodAnimationAssetTypeId = "78"
tbl1.DynamicHeadAssetTypeId = "79"

tbl1.DetailsThumbnailFrameHeight = 250

tbl1.LimitedIconFrameSizeXOffset = 9
tbl1.LimitedIconFrameSizeYOffset = 4

local DynamicHeadAssetTypes = {}
local EyebrowAccessoryValue5 = Enum.AssetType.EyebrowAccessory.Value
DynamicHeadAssetTypes[tostring(EyebrowAccessoryValue5)] = true
local EyelashAccessoryValue5 = Enum.AssetType.EyelashAccessory.Value
DynamicHeadAssetTypes[tostring(EyelashAccessoryValue5)] = true
DynamicHeadAssetTypes[tbl1.MoodAnimationAssetTypeId] = true
DynamicHeadAssetTypes[tbl1.DynamicHeadAssetTypeId] = true
tbl1.DynamicHeadAssetTypes = DynamicHeadAssetTypes

tbl1.AccessoryTypeEnumToAssetTypeId = {}
for k, value in pairs(tbl1.AssetTypeIdToAccessoryTypeEnum) do
    tbl1.AccessoryTypeEnumToAssetTypeId[value] = k
end

local AssetCategoryToAssetType = {
    [tbl1.AssetCategory.Tops] = { tostring(Enum.AssetType.ShirtAccessory.Value), tostring(Enum.AssetType.TShirtAccessory.Value), tostring(Enum.AssetType.SweaterAccessory.Value) },
    [tbl1.AssetCategory.Bottoms] = { tostring(Enum.AssetType.PantsAccessory.Value), tostring(Enum.AssetType.ShortsAccessory.Value), tostring(Enum.AssetType.DressSkirtAccessory.Value) }
}
tbl1.AssetCategoryToAssetType = AssetCategoryToAssetType

tbl1.AssetTypeToAssetCategory = {}
for k, value in pairs(tbl1.AssetCategoryToAssetType) do
    for _, value2 in ipairs(value) do
        tbl1.AssetTypeToAssetCategory[value2] = k
    end
end

local LayeredClothingOrder = {}
local PantsValue4 = Enum.AssetType.Pants.Value
LayeredClothingOrder[tostring(PantsValue4)] = 0
local ShirtValue4 = Enum.AssetType.Shirt.Value
LayeredClothingOrder[tostring(ShirtValue4)] = 1
local TShirtValue4 = Enum.AssetType.TShirt.Value
LayeredClothingOrder[tostring(TShirtValue4)] = 2
local LeftShoeAccessoryValue5 = Enum.AssetType.LeftShoeAccessory.Value
LayeredClothingOrder[tostring(LeftShoeAccessoryValue5)] = 3
local RightShoeAccessoryValue5 = Enum.AssetType.RightShoeAccessory.Value
LayeredClothingOrder[tostring(RightShoeAccessoryValue5)] = 3
local PantsAccessoryValue5 = Enum.AssetType.PantsAccessory.Value
LayeredClothingOrder[tostring(PantsAccessoryValue5)] = 4
local ShortsAccessoryValue5 = Enum.AssetType.ShortsAccessory.Value
LayeredClothingOrder[tostring(ShortsAccessoryValue5)] = 5
local DressSkirtAccessoryValue5 = Enum.AssetType.DressSkirtAccessory.Value
LayeredClothingOrder[tostring(DressSkirtAccessoryValue5)] = 6
local TShirtAccessoryValue5 = Enum.AssetType.TShirtAccessory.Value
LayeredClothingOrder[tostring(TShirtAccessoryValue5)] = 7
local ShirtAccessoryValue5 = Enum.AssetType.ShirtAccessory.Value
LayeredClothingOrder[tostring(ShirtAccessoryValue5)] = 8
local SweaterAccessoryValue5 = Enum.AssetType.SweaterAccessory.Value
LayeredClothingOrder[tostring(SweaterAccessoryValue5)] = 9
local JacketAccessoryValue5 = Enum.AssetType.JacketAccessory.Value
LayeredClothingOrder[tostring(JacketAccessoryValue5)] = 10
local HairAccessoryValue6 = Enum.AssetType.HairAccessory.Value
LayeredClothingOrder[tostring(HairAccessoryValue6)] = 11
local EyebrowAccessoryValue6 = Enum.AssetType.EyebrowAccessory.Value
LayeredClothingOrder[tostring(EyebrowAccessoryValue6)] = 3
local EyelashAccessoryValue6 = Enum.AssetType.EyelashAccessory.Value
LayeredClothingOrder[tostring(EyelashAccessoryValue6)] = 3
tbl1.LayeredClothingOrder = LayeredClothingOrder

tbl1.ProductType = { CollectibleItem = "Collectible Item" }

tbl1.ItemRestrictions = {
    Limited = "Limited",
    LimitedUnique = "LimitedUnique",
    Collectible = "Collectible"
}

tbl1.SaleStatus = { OnSale = "OnSale" }

tbl1.SaleLocationType = {
    Invalid = 0,
    ShopOnly = 1,
    MyExperiencesOnly = 2,
    ShopAndMyExperiences = 3,
    ExperiencesById = 4,
    ShopAndAllExperiences = 5,
    ExperiencesDevApiOnly = 6,
    ShopAndExperiencesById = 7
}

tbl1.CounterSuffix = {
    RequestSucceeded = "RequestSucceeded",
    RequestRejected = "RequestRejected",
    RequestFailed = "RequestFailed"
}

tbl1.Counters = {
    CreateFavoriteForAsset = "CreateFavoriteForAsset",
    CreateFavoriteForBundle = "CreateFavoriteForBundle",
    DeleteFavoriteForAsset = "DeleteFavoriteForAsset",
    DeleteFavoriteForBundle = "DeleteFavoriteForBundle",
    GetAssetBundles = "GetAssetBundles",
    GetAssetFavoriteCount = "GetAssetFavoriteCount",
    GetBundleFavoriteCount = "GetBundleFavoriteCount",
    GetCharacterModelFromUserId = "GetCharacterModelFromUserId",
    GetCollectibleResellableInstances = "GetCollectibleResellableInstances",
    GetCollectibleResellableInstancesRequestSucceededWithoutResult = "GetCollectibleResellableInstancesRequestSucceededWithoutResult",
    GetEconomyProductInfo = "GetEconomyV1DeprecatedProductInfo",
    GetExperienceInfo = "GetExperienceInfo",
    GetExperiencePlayability = "GetExperiencePlayability",
    GetFavoriteForAsset = "GetFavoriteForAsset",
    GetFavoriteForBundle = "GetFavoriteForBundle",
    GetItemDetails = "GetItemDetails",
    GetItemDetailsRespondedWithUnknownItemType = "GetItemDetailsRespondedWithUnknownItemType",
    GetPlayerName = "GetPlayerName",
    GetProductInfo = "MarketplaceServiceGetProductInfo",
    GetVersionInfo = "GetVersionInfo",
    PromptLimitedCollectiblesPurchase = "PromptLimitedCollectiblesPurchase",
    PromptBundlePurchase = "PromptBundlePurchase",
    PromptUnlimitedCollectiblePurchase = "PromptUnlimitedCollectiblePurchase",
    PromptRobloxPurchase = "PromptRobloxPurchase",
    PromptPurchaseUnknownItemType = "PromptPurchaseUnknownItemType",
    PurchaseSucceededBundle = "PurchaseSucceededBundle",
    PurchaseSucceededAsset = "PurchaseSucceededAsset",
    PurchaseSucceededOther = "PurchaseSucceededOther",
    PurchaseFinished = "PurchaseFinished",
    ItemDetailPageOpened = "ItemDetailPageOpened",
    TryOnButtonClicked = "TryOnButtonClicked",
    GetAvatarPreview = "GetAvatarPreview",
    BatchGetAssets = "BatchGetAssets",
    BatchGetItemDetails = "BatchGetItemDetails",
    GetAvatarBackground = "GetAvatarBackground"
}
return tbl1
