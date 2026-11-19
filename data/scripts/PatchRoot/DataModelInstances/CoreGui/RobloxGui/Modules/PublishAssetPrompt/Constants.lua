-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T23:11:30Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local tbl1 = {
    PromptSidePadding = 24,
    ViewportLightColor = Color3.fromRGB(240, 240, 240),
    ViewportLightAmbient = Color3.fromRGB(160, 160, 160),
    ViewportLightDirection = Vector3.new(9.5, -12, 7.5),
    ItemCardWidthLandscape = 150,
    ItemCardWidthPortrait = 100
}

tbl1.AvatarAssetTypeDefaultName = {
    [Enum.AvatarAssetType.Hat] = "Hat",
    [Enum.AvatarAssetType.FaceAccessory] = "Face Accessory",
    [Enum.AvatarAssetType.NeckAccessory] = "Neck Accessory",
    [Enum.AvatarAssetType.ShoulderAccessory] = "Shoulder Accessory",
    [Enum.AvatarAssetType.FrontAccessory] = "Front Accessory",
    [Enum.AvatarAssetType.BackAccessory] = "Back Accessory",
    [Enum.AvatarAssetType.WaistAccessory] = "Waist Accessory",
    [Enum.AvatarAssetType.TShirtAccessory] = "T-Shirt",
    [Enum.AvatarAssetType.ShirtAccessory] = "Shirt",
    [Enum.AvatarAssetType.PantsAccessory] = "Pants",
    [Enum.AvatarAssetType.JacketAccessory] = "Jacket",
    [Enum.AvatarAssetType.SweaterAccessory] = "Sweater",
    [Enum.AvatarAssetType.ShortsAccessory] = "Shorts",
    [Enum.AvatarAssetType.DressSkirtAccessory] = "Dress/Skirt",
    [Enum.AvatarAssetType.HairAccessory] = "Hair",
    [Enum.AvatarAssetType.EyeMakeup] = "Eye Makeup",
    [Enum.AvatarAssetType.FaceMakeup] = "Face Makeup",
    [Enum.AvatarAssetType.LipMakeup] = "Lip Makeup",
    [Enum.AvatarAssetType.EyebrowAccessory] = "Eyebrow",
    [Enum.AvatarAssetType.EyelashAccessory] = "Eyelash"
}

tbl1.AvatarAssetTypeLocalized = {
    [Enum.AvatarAssetType.Hat] = "Feature.Avatar.Label.Hat",
    [Enum.AvatarAssetType.FaceAccessory] = "Feature.Avatar.Label.Face",
    [Enum.AvatarAssetType.NeckAccessory] = "Feature.Avatar.Label.Neck",
    [Enum.AvatarAssetType.ShoulderAccessory] = "Feature.Avatar.Label.Shoulder",
    [Enum.AvatarAssetType.FrontAccessory] = "Feature.Avatar.Label.Front",
    [Enum.AvatarAssetType.BackAccessory] = "Feature.Avatar.Label.Back",
    [Enum.AvatarAssetType.WaistAccessory] = "Feature.Avatar.Label.Waist",
    [Enum.AvatarAssetType.TShirtAccessory] = "Feature.Avatar.Label.TShirt",
    [Enum.AvatarAssetType.ShirtAccessory] = "Feature.Avatar.Label.Shirt",
    [Enum.AvatarAssetType.PantsAccessory] = "Feature.Avatar.Label.Pants",
    [Enum.AvatarAssetType.JacketAccessory] = "Feature.Avatar.Label.Jacket",
    [Enum.AvatarAssetType.SweaterAccessory] = "Feature.Avatar.Label.Sweater",
    [Enum.AvatarAssetType.ShortsAccessory] = "Feature.Avatar.Label.Shorts",
    [Enum.AvatarAssetType.DressSkirtAccessory] = "Feature.Avatar.Label.DressesAndSkirts",
    [Enum.AvatarAssetType.HairAccessory] = "Feature.Avatar.Label.Hair",
    [Enum.AvatarAssetType.EyeMakeup] = "Feature.Avatar.Label.EyeMakeup",
    [Enum.AvatarAssetType.FaceMakeup] = "Feature.Avatar.Label.FaceMakeup",
    [Enum.AvatarAssetType.LipMakeup] = "Feature.Avatar.Label.LipMakeup",
    [Enum.AvatarAssetType.EyebrowAccessory] = "Feature.Avatar.Label.Eyebrows",
    [Enum.AvatarAssetType.EyelashAccessory] = "Feature.Avatar.Label.Eyelashes"
}

tbl1.MakeupAssetTypes = {
    [Enum.AvatarAssetType.FaceMakeup] = true,
    [Enum.AvatarAssetType.LipMakeup] = true,
    [Enum.AvatarAssetType.EyeMakeup] = true,
    [Enum.AvatarAssetType.EyebrowAccessory] = true,
    [Enum.AvatarAssetType.EyelashAccessory] = true
}

return tbl1
