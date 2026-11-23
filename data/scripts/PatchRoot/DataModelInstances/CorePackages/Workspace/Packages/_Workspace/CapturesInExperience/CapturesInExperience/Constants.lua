-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T23:50:35Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local tbl1 = {
    AnalyticsSource = "Captures",
    CapturesContext = "Captures",
    CarouselDirection = { Left = "Left", Right = "Right" },
    CapturesActiveLocalStorageKey = "ScreenshotsFeatureActiveUserIds",
    DeleteWarningModalOptOutStorageKey = "CapturesDeleteModalOptOutUserIds",
    LastFlashOccurrenceTsLocalStorageKey = "LastFlashOccurrenceTimestampMs",
    CaptureControlsPositionStorageKey = "CaptureControlsPosition",
    CarouselDisplayOrder = 7,
    CreationFlowDisplayOrder = 8,
    HotkeyTooltipDisplayOrder = 6,
    LoggerKey = "Captures",
    OverlayName = "CaptureOverlay",
    OverlayDisplayOrder = 5,
    ReactName = "CapturesApp",
    RoduxKey = "CapturesInExperience",
    StatusCodes = { OK = 200, FORBIDDEN = 403 },
    FlashTimeout = 1,
    ToastDuration = 2,
    ZIndex = { Entrypoint = 1, Toasts = 5 },
    AssetTypeIdToAccessoryTypeEnum = 0,
    AssetTypeIdStringToHumanoidDescriptionProp = 0
}

local AssetTypeIdToAccessoryTypeEnum = {}
local HatValue = Enum.AssetType.Hat.Value
AssetTypeIdToAccessoryTypeEnum[tostring(HatValue)] = Enum.AccessoryType.Hat
local HairAccessoryValue = Enum.AssetType.HairAccessory.Value
AssetTypeIdToAccessoryTypeEnum[tostring(HairAccessoryValue)] = Enum.AccessoryType.Hair
local FaceAccessoryValue = Enum.AssetType.FaceAccessory.Value
AssetTypeIdToAccessoryTypeEnum[tostring(FaceAccessoryValue)] = Enum.AccessoryType.Face
local NeckAccessoryValue = Enum.AssetType.NeckAccessory.Value
AssetTypeIdToAccessoryTypeEnum[tostring(NeckAccessoryValue)] = Enum.AccessoryType.Neck
local ShoulderAccessoryValue = Enum.AssetType.ShoulderAccessory.Value
AssetTypeIdToAccessoryTypeEnum[tostring(ShoulderAccessoryValue)] = Enum.AccessoryType.Shoulder
local FrontAccessoryValue = Enum.AssetType.FrontAccessory.Value
AssetTypeIdToAccessoryTypeEnum[tostring(FrontAccessoryValue)] = Enum.AccessoryType.Front
local BackAccessoryValue = Enum.AssetType.BackAccessory.Value
AssetTypeIdToAccessoryTypeEnum[tostring(BackAccessoryValue)] = Enum.AccessoryType.Back
local WaistAccessoryValue = Enum.AssetType.WaistAccessory.Value
AssetTypeIdToAccessoryTypeEnum[tostring(WaistAccessoryValue)] = Enum.AccessoryType.Waist
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

local AssetTypeIdStringToHumanoidDescriptionProp = {}
local TShirtValue = Enum.AssetType.TShirt.Value
AssetTypeIdStringToHumanoidDescriptionProp[tostring(TShirtValue)] = "GraphicTShirt"
local HatValue2 = Enum.AssetType.Hat.Value
AssetTypeIdStringToHumanoidDescriptionProp[tostring(HatValue2)] = "HatAccessory"
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
local HairAccessoryValue2 = Enum.AssetType.HairAccessory.Value
AssetTypeIdStringToHumanoidDescriptionProp[tostring(HairAccessoryValue2)] = "HairAccessory"
local FaceAccessoryValue2 = Enum.AssetType.FaceAccessory.Value
AssetTypeIdStringToHumanoidDescriptionProp[tostring(FaceAccessoryValue2)] = "FaceAccessory"
local NeckAccessoryValue2 = Enum.AssetType.NeckAccessory.Value
AssetTypeIdStringToHumanoidDescriptionProp[tostring(NeckAccessoryValue2)] = "NeckAccessory"
local ShoulderAccessoryValue2 = Enum.AssetType.ShoulderAccessory.Value
AssetTypeIdStringToHumanoidDescriptionProp[tostring(ShoulderAccessoryValue2)] = "ShouldersAccessory"
local FrontAccessoryValue2 = Enum.AssetType.FrontAccessory.Value
AssetTypeIdStringToHumanoidDescriptionProp[tostring(FrontAccessoryValue2)] = "FrontAccessory"
local BackAccessoryValue2 = Enum.AssetType.BackAccessory.Value
AssetTypeIdStringToHumanoidDescriptionProp[tostring(BackAccessoryValue2)] = "BackAccessory"
local WaistAccessoryValue2 = Enum.AssetType.WaistAccessory.Value
AssetTypeIdStringToHumanoidDescriptionProp[tostring(WaistAccessoryValue2)] = "WaistAccessory"
local DynamicHeadValue = Enum.AssetType.DynamicHead.Value
AssetTypeIdStringToHumanoidDescriptionProp[tostring(DynamicHeadValue)] = "Head"
tbl1.AssetTypeIdStringToHumanoidDescriptionProp = AssetTypeIdStringToHumanoidDescriptionProp

return tbl1
