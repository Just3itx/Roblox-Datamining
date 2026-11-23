-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T16:31:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local AvatarExperienceInspectAndBuy = script:FindFirstAncestor("AvatarExperienceInspectAndBuy")
local AvatarExperienceInspectAndBuyParent = AvatarExperienceInspectAndBuy.Parent
local AvatarExperienceFlags = require(AvatarExperienceInspectAndBuyParent.AvatarExperienceFlags)
local FFlagAXInspectAndBuyMakeupSupport = AvatarExperienceFlags.FFlagAXInspectAndBuyMakeupSupport
local FFlagAXCatalogBackgroundsSupport = AvatarExperienceFlags.FFlagAXCatalogBackgroundsSupport

local tbl1 = {}
local PriceStatus = require(AvatarExperienceInspectAndBuy.Enums.PriceStatus)

local AssetLocalizationKeys = {}
local HatValue = Enum.AssetType.Hat.Value
AssetLocalizationKeys[tostring(HatValue)] = "Feature.Avatar.Label.Hat"
local HairAccessoryValue = Enum.AssetType.HairAccessory.Value
AssetLocalizationKeys[tostring(HairAccessoryValue)] = "Feature.Avatar.Label.Hair"
local FaceAccessoryValue = Enum.AssetType.FaceAccessory.Value
AssetLocalizationKeys[tostring(FaceAccessoryValue)] = "Feature.Avatar.Label.Face"
local NeckAccessoryValue = Enum.AssetType.NeckAccessory.Value
AssetLocalizationKeys[tostring(NeckAccessoryValue)] = "Feature.Avatar.Label.Neck"
local ShoulderAccessoryValue = Enum.AssetType.ShoulderAccessory.Value
AssetLocalizationKeys[tostring(ShoulderAccessoryValue)] = "Feature.Avatar.Label.Shoulder"
local FrontAccessoryValue = Enum.AssetType.FrontAccessory.Value
AssetLocalizationKeys[tostring(FrontAccessoryValue)] = "Feature.Avatar.Label.Front"
local BackAccessoryValue = Enum.AssetType.BackAccessory.Value
AssetLocalizationKeys[tostring(BackAccessoryValue)] = "Feature.Avatar.Label.Back"
local WaistAccessoryValue = Enum.AssetType.WaistAccessory.Value
AssetLocalizationKeys[tostring(WaistAccessoryValue)] = "Feature.Avatar.Label.Waist"
local TShirtAccessoryValue = Enum.AssetType.TShirtAccessory.Value
AssetLocalizationKeys[tostring(TShirtAccessoryValue)] = "Feature.Avatar.Label.TShirt"
local ShirtAccessoryValue = Enum.AssetType.ShirtAccessory.Value
AssetLocalizationKeys[tostring(ShirtAccessoryValue)] = "Feature.Avatar.Label.Shirt"
local ShirtValue = Enum.AssetType.Shirt.Value
AssetLocalizationKeys[tostring(ShirtValue)] = "Feature.Catalog.Feature.Catalog.Label.ClassicShirt"
local TShirtValue = Enum.AssetType.TShirt.Value
AssetLocalizationKeys[tostring(TShirtValue)] = "Feature.Catalog.Feature.Catalog.Label.ClassicTShirt"
local PantsAccessoryValue = Enum.AssetType.PantsAccessory.Value
AssetLocalizationKeys[tostring(PantsAccessoryValue)] = "Feature.Avatar.Label.Pants"
local PantsValue = Enum.AssetType.Pants.Value
AssetLocalizationKeys[tostring(PantsValue)] = "Feature.Avatar.Label.ClassicPants"
local JacketAccessoryValue = Enum.AssetType.JacketAccessory.Value
AssetLocalizationKeys[tostring(JacketAccessoryValue)] = "Feature.Avatar.Label.Jacket"
local SweaterAccessoryValue = Enum.AssetType.SweaterAccessory.Value
AssetLocalizationKeys[tostring(SweaterAccessoryValue)] = "Feature.Avatar.Label.Sweater"
local ShortsAccessoryValue = Enum.AssetType.ShortsAccessory.Value
AssetLocalizationKeys[tostring(ShortsAccessoryValue)] = "Feature.Avatar.Label.Shorts"
local DressSkirtAccessoryValue = Enum.AssetType.DressSkirtAccessory.Value
AssetLocalizationKeys[tostring(DressSkirtAccessoryValue)] = "Feature.Avatar.Label.DressesAndSkirts"
local EmoteAnimationValue = Enum.AssetType.EmoteAnimation.Value
AssetLocalizationKeys[tostring(EmoteAnimationValue)] = "Feature.Avatar.Label.Emote"
local FaceValue = Enum.AssetType.Face.Value
AssetLocalizationKeys[tostring(FaceValue)] = "Feature.Avatar.Label.ClassicFaces"
local HeadValue = Enum.AssetType.Head.Value
AssetLocalizationKeys[tostring(HeadValue)] = "Feature.Avatar.Label.ClassicHeads"
tbl1.AssetLocalizationKeys = AssetLocalizationKeys

if FFlagAXInspectAndBuyMakeupSupport then
    local assetLocalizationKeys = tbl1.AssetLocalizationKeys
    local eyeMakeupValue = Enum.AssetType.EyeMakeup.Value
    assetLocalizationKeys[tostring(eyeMakeupValue)] = "Feature.Catalog.Label.EyeMakeup"
    local assetLocalizationKeys2 = tbl1.AssetLocalizationKeys
    local faceMakeupValue = Enum.AssetType.FaceMakeup.Value
    assetLocalizationKeys2[tostring(faceMakeupValue)] = "Feature.Catalog.Label.FaceMakeup"
    local assetLocalizationKeys3 = tbl1.AssetLocalizationKeys
    local lipMakeupValue = Enum.AssetType.LipMakeup.Value
    assetLocalizationKeys3[tostring(lipMakeupValue)] = "Feature.Catalog.Label.LipMakeup"
end

if FFlagAXCatalogBackgroundsSupport then
    local assetLocalizationKeys = tbl1.AssetLocalizationKeys
    local avatarBackgroundValue = Enum.AssetType.AvatarBackground.Value
    assetLocalizationKeys[tostring(avatarBackgroundValue)] = "Feature.Avatar.Label.Backgrounds"
end

local BundleLocalizationKeys = {}
local BodyPartsValue = Enum.BundleType.BodyParts.Value
BundleLocalizationKeys[tostring(BodyPartsValue)] = "Feature.Catalog.Label.Body"
local AnimationsValue = Enum.BundleType.Animations.Value
BundleLocalizationKeys[tostring(AnimationsValue)] = "Feature.Catalog.Label.Animation"
local ShoesValue = Enum.BundleType.Shoes.Value
BundleLocalizationKeys[tostring(ShoesValue)] = "Feature.Avatar.Label.Shoes"
local DynamicHeadValue = Enum.BundleType.DynamicHead.Value
BundleLocalizationKeys[tostring(DynamicHeadValue)] = "Feature.Avatar.Label.DynamicHead"
tbl1.BundleLocalizationKeys = BundleLocalizationKeys

tbl1.PriceStatusLocalizationKeys = {
    [PriceStatus.Owned] = "Feature.Catalog.Label.Owned",
    [PriceStatus.Free] = "Feature.Catalog.LabelFree",
    [PriceStatus.QuantityLimitReached] = "InGame.InspectMenu.Action.LimitReached",
    [PriceStatus.SoldOut] = "InGame.InspectMenu.Action.SoldOut",
    [PriceStatus.OffSale] = "Feature.Catalog.LabelOffSale",
    [PriceStatus.Unavailable] = "Feature.Catalog.Label.Checkout.Unavailable",
    [PriceStatus.InExperienceOnly] = "Feature.Catalog.Label.InSingleExperience",
    [PriceStatus.PurchaseFromRoblox] = "Feature.Catalog.Heading.BuyItem",
    [PriceStatus.PurchaseFromResale] = "Feature.Catalog.Heading.BuyItem"
}
tbl1.ItemDetailsLocalizationKeys = {
    category = "Feature.Catalog.Label.Category",
    quantitySold = "Feature.Catalog.Label.QuantitySold",
    originalPrice = "Feature.Catalog.Label.OriginalPrice",
    tryOn = "InGame.InspectMenu.Action.TryOn",
    tradeable = "Feature.Catalog.Label.Tradable",
    yes = "Feature.Catalog.Label.Yes",
    no = "Feature.Catalog.Label.No",
    ownedItems = "InGame.InspectMenu.Label.OwnedItems",
    na = "Feature.Catalog.Label.NA",
    includedParts = "Feature.Catalog.Label.IncludedParts",
    madein = "Feature.Catalog.Label.Attribution"
}
tbl1.BatchItemDetailsPerformFetchKey = "BatchItemDetailsV2"

tbl1.ShowPlayableAttributionMapper = {
    UnplayableOtherReason = true,
    Playable = true,
    GuestProhibited = true,
    GameUnapproved = false,
    IncorrectConfiguration = false,
    UniverseRootPlaceIsPrivate = false,
    InsufficientPermissionFriendsOnly = true,
    InsufficientPermissionGroupOnly = true,
    DeviceRestricted = true,
    UnderReview = true,
    PurchaseRequired = true,
    AccountRestricted = true,
    TemporarilyUnavailable = true,
    ComplianceBlocked = true,
    ContextualPlayabilityAgeRecommendationParentalControls = true,
    ContextualPlayabilityRegionalAvailability = true,
    ContextualPlayabilityRegionalCompliance = true,
    ContextualPlayabilityUnverifiedSeventeenPlusUser = true
}

return tbl1
