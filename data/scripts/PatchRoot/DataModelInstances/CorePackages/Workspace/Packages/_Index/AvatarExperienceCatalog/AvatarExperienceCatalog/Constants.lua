-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T02:00:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local AvatarExperienceCatalogParent = script:FindFirstAncestor("AvatarExperienceCatalog").Parent
local FFlagAXCatalogBackgroundsSupport = require(AvatarExperienceCatalogParent.AvatarExperienceFlags).FFlagAXCatalogBackgroundsSupport
local resolveWidgetListWindowSize = require(script.Parent.Utils.resolveWidgetListWindowSize)

local num1 = game:DefineFastInt("AXLooksImageZoom", 1250)
local num2 = game:DefineFastInt("AXLooksImageOffsetMultiplierX", 500)
local num3 = game:DefineFastInt("AXLooksImageOffsetMultiplierY", 750)

local vector2 = Vector2.new(num2 / 1000, num3 / 1000)
local LOOKS_IMAGE_ZOOM = num1 / 1000

local bool1 = game:DefineFastFlag("AXUseFIntForWidgetListInitialNumToRender", false)
local bool2 = game:DefineFastFlag("AXWidgetListWindowSizeByMemoryTier", false)

local FLATLIST_CONFIGS = {
    WINDOW_SIZE = game:DefineFastInt("WidgetListWindowSize", 21),
    INITIAL_NUM_TO_RENDER = if bool1 then game:DefineFastInt("WidgetListInitialNumToRender", 8) else 8,
    MAX_TO_RENDER_PER_BATCH = 1,
    UPDATE_CELLS_BATCHING_PERIOD = 30,
    SCROLL_EVENT_THROTTLE = 0
}

if bool2 then
    FLATLIST_CONFIGS.WINDOW_SIZE = resolveWidgetListWindowSize(FLATLIST_CONFIGS.WINDOW_SIZE)
end

local ASSET_TYPE_LOCALIZED = {}
local TShirtValue = Enum.AssetType.TShirt.Value
ASSET_TYPE_LOCALIZED[tostring(TShirtValue)] = "Feature.Avatar.Label.ClassicTShirts"
local HatValue = Enum.AssetType.Hat.Value
ASSET_TYPE_LOCALIZED[tostring(HatValue)] = "Feature.Avatar.Label.Hat"
local HairAccessoryValue = Enum.AssetType.HairAccessory.Value
ASSET_TYPE_LOCALIZED[tostring(HairAccessoryValue)] = "Feature.Avatar.Label.Hair"
local FaceAccessoryValue = Enum.AssetType.FaceAccessory.Value
ASSET_TYPE_LOCALIZED[tostring(FaceAccessoryValue)] = "Feature.Avatar.Label.Face"
local NeckAccessoryValue = Enum.AssetType.NeckAccessory.Value
ASSET_TYPE_LOCALIZED[tostring(NeckAccessoryValue)] = "Feature.Avatar.Label.Neck"
local ShoulderAccessoryValue = Enum.AssetType.ShoulderAccessory.Value
ASSET_TYPE_LOCALIZED[tostring(ShoulderAccessoryValue)] = "Feature.Avatar.Label.Shoulder"
local FrontAccessoryValue = Enum.AssetType.FrontAccessory.Value
ASSET_TYPE_LOCALIZED[tostring(FrontAccessoryValue)] = "Feature.Avatar.Label.Front"
local BackAccessoryValue = Enum.AssetType.BackAccessory.Value
ASSET_TYPE_LOCALIZED[tostring(BackAccessoryValue)] = "Feature.Avatar.Label.Back"
local WaistAccessoryValue = Enum.AssetType.WaistAccessory.Value
ASSET_TYPE_LOCALIZED[tostring(WaistAccessoryValue)] = "Feature.Avatar.Label.Waist"
local ShirtValue = Enum.AssetType.Shirt.Value
ASSET_TYPE_LOCALIZED[tostring(ShirtValue)] = "Feature.Avatar.Label.ClassicShirts"
local PantsValue = Enum.AssetType.Pants.Value
ASSET_TYPE_LOCALIZED[tostring(PantsValue)] = "Feature.Avatar.Label.ClassicPants"
local GearValue = Enum.AssetType.Gear.Value
ASSET_TYPE_LOCALIZED[tostring(GearValue)] = "Feature.Avatar.Label.Gear"
local HeadValue = Enum.AssetType.Head.Value
ASSET_TYPE_LOCALIZED[tostring(HeadValue)] = "Feature.Avatar.Label.Head"
local FaceValue = Enum.AssetType.Face.Value
ASSET_TYPE_LOCALIZED[tostring(FaceValue)] = "Feature.Avatar.Label.Face"
local TorsoValue = Enum.AssetType.Torso.Value
ASSET_TYPE_LOCALIZED[tostring(TorsoValue)] = "Feature.Avatar.Label.Torso"
local RightArmValue = Enum.AssetType.RightArm.Value
ASSET_TYPE_LOCALIZED[tostring(RightArmValue)] = "Feature.Avatar.Label.RightArms"
local LeftArmValue = Enum.AssetType.LeftArm.Value
ASSET_TYPE_LOCALIZED[tostring(LeftArmValue)] = "Feature.Avatar.Label.LeftArms"
local LeftLegValue = Enum.AssetType.LeftLeg.Value
ASSET_TYPE_LOCALIZED[tostring(LeftLegValue)] = "Feature.Avatar.Label.LeftLegs"
local RightLegValue = Enum.AssetType.RightLeg.Value
ASSET_TYPE_LOCALIZED[tostring(RightLegValue)] = "Feature.Avatar.Label.RightLegs"
local ClimbAnimationValue = Enum.AssetType.ClimbAnimation.Value
ASSET_TYPE_LOCALIZED[tostring(ClimbAnimationValue)] = "Feature.Avatar.Label.Climb"
local FallAnimationValue = Enum.AssetType.FallAnimation.Value
ASSET_TYPE_LOCALIZED[tostring(FallAnimationValue)] = "Feature.Avatar.Label.Fall"
local IdleAnimationValue = Enum.AssetType.IdleAnimation.Value
ASSET_TYPE_LOCALIZED[tostring(IdleAnimationValue)] = "Feature.Avatar.Label.Idle"
local JumpAnimationValue = Enum.AssetType.JumpAnimation.Value
ASSET_TYPE_LOCALIZED[tostring(JumpAnimationValue)] = "Feature.Avatar.Label.Jump"
local RunAnimationValue = Enum.AssetType.RunAnimation.Value
ASSET_TYPE_LOCALIZED[tostring(RunAnimationValue)] = "Feature.Avatar.Label.Run"
local SwimAnimationValue = Enum.AssetType.SwimAnimation.Value
ASSET_TYPE_LOCALIZED[tostring(SwimAnimationValue)] = "Feature.Avatar.Label.Swim"
local WalkAnimationValue = Enum.AssetType.WalkAnimation.Value
ASSET_TYPE_LOCALIZED[tostring(WalkAnimationValue)] = "Feature.Avatar.Label.Walk"
local EmoteAnimationValue = Enum.AssetType.EmoteAnimation.Value
ASSET_TYPE_LOCALIZED[tostring(EmoteAnimationValue)] = "Feature.Avatar.Label.Emote"
local TShirtAccessoryValue = Enum.AssetType.TShirtAccessory.Value
ASSET_TYPE_LOCALIZED[tostring(TShirtAccessoryValue)] = "Feature.Avatar.Label.TShirt"
local ShirtAccessoryValue = Enum.AssetType.ShirtAccessory.Value
ASSET_TYPE_LOCALIZED[tostring(ShirtAccessoryValue)] = "Feature.Avatar.Label.Shirt"
local PantsAccessoryValue = Enum.AssetType.PantsAccessory.Value
ASSET_TYPE_LOCALIZED[tostring(PantsAccessoryValue)] = "Feature.Avatar.Label.Pants"
local JacketAccessoryValue = Enum.AssetType.JacketAccessory.Value
ASSET_TYPE_LOCALIZED[tostring(JacketAccessoryValue)] = "Feature.Avatar.Label.Jacket"
local SweaterAccessoryValue = Enum.AssetType.SweaterAccessory.Value
ASSET_TYPE_LOCALIZED[tostring(SweaterAccessoryValue)] = "Feature.Avatar.Label.Sweater"
local ShortsAccessoryValue = Enum.AssetType.ShortsAccessory.Value
ASSET_TYPE_LOCALIZED[tostring(ShortsAccessoryValue)] = "Feature.Avatar.Label.Shorts"
local LeftShoeAccessoryValue = Enum.AssetType.LeftShoeAccessory.Value
ASSET_TYPE_LOCALIZED[tostring(LeftShoeAccessoryValue)] = "Feature.Avatar.Label.LeftShoe"
local RightShoeAccessoryValue = Enum.AssetType.RightShoeAccessory.Value
ASSET_TYPE_LOCALIZED[tostring(RightShoeAccessoryValue)] = "Feature.Avatar.Label.RightShoe"
local DressSkirtAccessoryValue = Enum.AssetType.DressSkirtAccessory.Value
ASSET_TYPE_LOCALIZED[tostring(DressSkirtAccessoryValue)] = "Feature.Avatar.Label.DressesAndSkirts"
local EyelashAccessoryValue = Enum.AssetType.EyelashAccessory.Value
ASSET_TYPE_LOCALIZED[tostring(EyelashAccessoryValue)] = "Feature.Catalog.Label.Eyelash"
local EyebrowAccessoryValue = Enum.AssetType.EyebrowAccessory.Value
ASSET_TYPE_LOCALIZED[tostring(EyebrowAccessoryValue)] = "Feature.Catalog.Label.Eyebrow"
local EyeMakeupValue = Enum.AssetType.EyeMakeup.Value
ASSET_TYPE_LOCALIZED[tostring(EyeMakeupValue)] = "Feature.Catalog.Label.EyeMakeup"
local LipMakeupValue = Enum.AssetType.LipMakeup.Value
ASSET_TYPE_LOCALIZED[tostring(LipMakeupValue)] = "Feature.Catalog.Label.LipMakeup"
local FaceMakeupValue = Enum.AssetType.FaceMakeup.Value
ASSET_TYPE_LOCALIZED[tostring(FaceMakeupValue)] = "Feature.Catalog.Label.FaceMakeup"
local MoodAnimationValue = Enum.AssetType.MoodAnimation.Value
ASSET_TYPE_LOCALIZED[tostring(MoodAnimationValue)] = "Feature.Avatar.Label.Mood"
local DynamicHeadValue = Enum.AssetType.DynamicHead.Value
ASSET_TYPE_LOCALIZED[tostring(DynamicHeadValue)] = "Feature.Avatar.Label.DynamicHead"

if FFlagAXCatalogBackgroundsSupport then
    local avatarBackgroundValue = Enum.AssetType.AvatarBackground.Value
    ASSET_TYPE_LOCALIZED[tostring(avatarBackgroundValue)] = "Feature.Avatar.Label.Backgrounds"
end

local BUNDLE_TYPE_LOCALIZED = {}
local BodyPartsValue = Enum.BundleType.BodyParts.Value
BUNDLE_TYPE_LOCALIZED[tostring(BodyPartsValue)] = "Feature.Catalog.Label.Body"
local AnimationsValue = Enum.BundleType.Animations.Value
BUNDLE_TYPE_LOCALIZED[tostring(AnimationsValue)] = "Feature.Catalog.Label.Animation"
local ShoesValue = Enum.BundleType.Shoes.Value
BUNDLE_TYPE_LOCALIZED[tostring(ShoesValue)] = "Feature.Avatar.Label.Shoes"
local DynamicHeadValue2 = Enum.BundleType.DynamicHead.Value
BUNDLE_TYPE_LOCALIZED[tostring(DynamicHeadValue2)] = "Feature.Catalog.Label.DynamicHeads"
return {
    COUNTERS = {
        TimeoutStatusPromptShown = "TimeoutStatusPromptShown",
        ItemsUnavailablePromptShown = "ItemsUnavailablePromptShown",
        FetchFaeFeatureAccessError = "FetchFaeFeatureAccessError",
        MarketplaceBreakpointMeasured = "MarketplaceBreakpointMeasured",
        CatalogOffersBanner = {
            fetchSucceeded = "CatalogOffersBannerFetchSucceeded",
            fetchFailed = "CatalogOffersBannerFetchFailed"
        },
        LookImpressionMissingLookType = "LookImpressionMissingLookType",
        CatalogPageSecondVariantFetched = "CatalogPageSecondVariantFetched"
    },
    LOOKS_IMAGE_OFFSET_MULTIPLIERS = vector2,
    LOOKS_IMAGE_ZOOM = LOOKS_IMAGE_ZOOM,
    ASSET_TYPE_LOCALIZED = ASSET_TYPE_LOCALIZED,
    BUNDLE_TYPE_LOCALIZED = BUNDLE_TYPE_LOCALIZED,
    CATALOG_RESULTS_HORIZONTAL_MARGIN = 15,
    WIDGET_COLUMN_PADDING = 10,
    FLATLIST_CONFIGS = FLATLIST_CONFIGS,
    OFFERS_LOCALIZED = {
        OfferApplied = "Feature.Catalog.Label.OfferApplied",
        OfferAppliedTooltip = "Feature.Catalog.Text.OfferAppliedToHighestItem"
    }
}
