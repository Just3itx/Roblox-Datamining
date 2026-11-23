-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T13:21:27Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local AvatarExperienceCommonParent = script:FindFirstAncestor("AvatarExperienceCommon").Parent

local enumerate = require(AvatarExperienceCommonParent.enumerate)

local AvatarExperienceFlags = require(AvatarExperienceCommonParent.AvatarExperienceFlags)
local FFlagAXCatalogM41Props = AvatarExperienceFlags.FFlagAXCatalogM41Props
local FFlagAXCatalogM41FullMasks = AvatarExperienceFlags.FFlagAXCatalogM41FullMasks
local FFlagAXCatalogM41HandAndArm = AvatarExperienceFlags.FFlagAXCatalogM41HandAndArm
local FFlagAXFixHandAndArmWidgetApiContext = AvatarExperienceFlags.FFlagAXFixHandAndArmWidgetApiContext

return enumerate(script.Name, {
    Featured = "Featured",
    Limited = "Limited",
    Community = "Community",
    Premium = "Premium",
    Shirts = "Shirts",
    TShirts = "TShirts",
    Sweaters = "Sweaters",
    Jackets = "Jackets",
    Pants = "Pants",
    DressesAndSkirts = "DressSkirt",
    Shorts = "Shorts",
    Shoes = "Shoes",
    ClassicShirts = "Classic Shirts",
    ClassicTShirts = "Classic T-Shirts",
    ClassicPants = "Classic Pants",
    Bodysuits = "Bodysuits",
    Hats = "Hats",
    Face = "Face",
    FullMasks = if FFlagAXCatalogM41FullMasks then "Full Masks" else nil,
    Neck = "Neck",
    Shoulder = "Shoulder",
    HandAndArm = FFlagAXCatalogM41HandAndArm and (if FFlagAXFixHandAndArmWidgetApiContext then "Hand And Arm" else "Hand & Arm") or nil,
    Front = "Front",
    Back = "Back",
    Waist = "Waist",
    Gear = "Gear",
    FullBodies = "Full Bodies",
    Heads = "Heads",
    Hair = "Hair",
    MakeupLooks = "Makeup Looks",
    EyeMakeup = "Eye Makeup",
    FaceMakeup = "Face Makeup",
    LipMakeup = "Lip Makeup",
    Eyelashes = "Eyelashes",
    Eyebrows = "Eyebrows",
    AnimationBundles = "AnimationBundles",
    Emotes = "Emotes",
    Props = if FFlagAXCatalogM41Props then "Props" else nil
})
