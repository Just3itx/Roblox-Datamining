-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T04:41:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local _Types = require(script.Parent.Types)
local InventoryFilters = require(script.Parent.Enums.InventoryFilters)
local SlotType = require(script.Parent.Enums.SlotType)
local tbl1 = {}
local Categories = require(script.Parent.Enums.Categories)

local AvatarExperienceSlotBasedEditorParent = script:FindFirstAncestor("AvatarExperienceSlotBasedEditor").Parent
local AvatarEditorSubcategories = require(AvatarExperienceSlotBasedEditorParent.AvatarExperienceModel).Enums.AvatarEditorSubcategories
local AvatarExperienceFlags = require(AvatarExperienceSlotBasedEditorParent.AvatarExperienceFlags)
local FFlagRemoveClassicHeadsAndFaces = AvatarExperienceFlags.FFlagRemoveClassicHeadsAndFaces
local FFlagAXMigrateBuilderIcons = AvatarExperienceFlags.FFlagAXMigrateBuilderIcons
local FFlagAXSlotsDesktopRedesign = AvatarExperienceFlags.FFlagAXSlotsDesktopRedesign
local FFlagAXInventoryDurablesExpiredFilter = AvatarExperienceFlags.FFlagAXInventoryDurablesExpiredFilter
local FFlagAXCustomizeBackgrounds = AvatarExperienceFlags.FFlagAXCustomizeBackgrounds
local FFlagAXDownrankMakeupCustomize = AvatarExperienceFlags.FFlagAXDownrankMakeupCustomize
local FFlagAXSpawnEffects = AvatarExperienceFlags.FFlagAXSpawnEffects

local IconName = require(AvatarExperienceSlotBasedEditorParent.Foundation).Enums.IconName
local IconVariant = require(AvatarExperienceSlotBasedEditorParent.Foundation).Enums.IconVariant

local Icons = {
    FullBody = FFlagAXMigrateBuilderIcons and {
        name = IconName.PersonStanding,
        variant = IconVariant.Filled
    }
        or "icons/menu/clothing/body_on",
    ClassicHead = FFlagAXMigrateBuilderIcons and {
        name = IconName.HeadBlank,
        variant = IconVariant.Filled
    }
        or "icons/menu/clothing/classicHead_on",
    Hair = FFlagAXMigrateBuilderIcons and {
        name = IconName.HeadFemale,
        variant = IconVariant.Filled
    }
        or "icons/menu/clothing/hair_on",
    Faces = FFlagAXMigrateBuilderIcons and {
        name = IconName.FaceWinking,
        variant = IconVariant.Filled
    }
        or "icons/menu/clothing/faces_on",
    Clothing = FFlagAXMigrateBuilderIcons and {
        name = IconName.ClothesHanger,
        variant = IconVariant.Filled
    }
        or "icons/menu/clothing/clothing_on",
    Jackets = FFlagAXMigrateBuilderIcons and {
        name = IconName.Jacket,
        variant = IconVariant.Filled
    }
        or "icons/menu/clothing/jackets_on",
    Shirts = FFlagAXMigrateBuilderIcons and {
        name = IconName.Shirt,
        variant = IconVariant.Filled
    }
        or "icons/menu/clothing/shirts_on",
    Pants = FFlagAXMigrateBuilderIcons and {
        name = IconName.Pants,
        variant = IconVariant.Filled
    }
        or "icons/menu/clothing/pants_on",
    Shoes = FFlagAXMigrateBuilderIcons and {
        name = IconName.Shoe,
        variant = IconVariant.Filled
    } or "icons/menu/clothing/shoes_on",
    ClassicTShirts = FFlagAXMigrateBuilderIcons and {
        name = IconName.Tshirt_2dText,
        variant = IconVariant.Filled
    }
        or "icons/menu/clothing/classicTshirts_on",
    ClassicShirts = FFlagAXMigrateBuilderIcons and {
        name = IconName.Shirt_2dText,
        variant = IconVariant.Filled
    }
        or "icons/menu/clothing/classicShirts_on",
    ClassicPants = FFlagAXMigrateBuilderIcons and {
        name = IconName.Pants_2dText,
        variant = IconVariant.Filled
    }
        or "icons/menu/clothing/classicPants_on",
    Accessories = FFlagAXMigrateBuilderIcons and {
        name = IconName.BowTie,
        variant = IconVariant.Filled
    }
        or "icons/menu/clothing/accessories_off",
    Head = FFlagAXMigrateBuilderIcons and {
        name = IconName.HatFedora,
        variant = IconVariant.Filled
    }
        or "icons/menu/clothing/hats_on",
    Face = FFlagAXMigrateBuilderIcons and {
        name = IconName.Glasses,
        variant = IconVariant.Filled
    }
        or "icons/menu/clothing/eyes_on",
    Neck = FFlagAXMigrateBuilderIcons and {
        name = IconName.Necklace,
        variant = IconVariant.Filled
    }
        or "icons/menu/clothing/neck_off",
    Shoulder = FFlagAXMigrateBuilderIcons and {
        name = IconName.Parrot,
        variant = IconVariant.Filled
    }
        or "icons/menu/clothing/shoulder_on",
    Front = FFlagAXMigrateBuilderIcons and {
        name = IconName.Purse,
        variant = IconVariant.Filled
    }
        or "icons/menu/clothing/front_on",
    Back = FFlagAXMigrateBuilderIcons and {
        name = IconName.ButterflyWings,
        variant = IconVariant.Filled
    }
        or "icons/menu/clothing/back_on",
    Waist = FFlagAXMigrateBuilderIcons and {
        name = IconName.Belt,
        variant = IconVariant.Filled
    } or "icons/menu/clothing/waist_on",
    Gear = FFlagAXMigrateBuilderIcons and {
        name = IconName.Sword,
        variant = IconVariant.Filled
    } or "icons/menu/clothing/gear_on",
    Animation = FFlagAXMigrateBuilderIcons and {
        name = IconName.PersonTeleport,
        variant = IconVariant.Filled
    }
        or "icons/menu/clothing/animation_off",
    Idle = FFlagAXMigrateBuilderIcons and {
        name = IconName.PersonStanding,
        variant = IconVariant.Filled
    }
        or "icons/menu/clothing/idle_on",
    Walk = FFlagAXMigrateBuilderIcons and {
        name = IconName.PersonWalking,
        variant = IconVariant.Filled
    }
        or "icons/menu/clothing/walk_off",
    Jump = FFlagAXMigrateBuilderIcons and {
        name = IconName.PersonJumping,
        variant = IconVariant.Filled
    }
        or "icons/menu/clothing/jump_off",
    Fall = FFlagAXMigrateBuilderIcons and {
        name = IconName.PersonFalling,
        variant = IconVariant.Filled
    }
        or "icons/menu/clothing/fall_off",
    Climb = FFlagAXMigrateBuilderIcons and {
        name = IconName.PersonClimbing,
        variant = IconVariant.Filled
    }
        or "icons/menu/clothing/climb_off",
    Swim = FFlagAXMigrateBuilderIcons and {
        name = IconName.PersonSwimming,
        variant = IconVariant.Filled
    }
        or "icons/menu/clothing/swim_off",
    Emote = FFlagAXMigrateBuilderIcons and {
        name = IconName.SquareFaceWavingHand,
        variant = IconVariant.Filled
    }
        or "icons/controls/emoteOn",
    Reset = FFlagAXMigrateBuilderIcons and {
        name = IconName.ArrowSpinClockwise,
        variant = IconVariant.Regular
    }
        or "icons/actions/reset",
    Undo = FFlagAXMigrateBuilderIcons and {
        name = IconName.ArrowCurlToLeft,
        variant = IconVariant.Regular
    }
        or "icons/actions/edit/undo",
    Redo = FFlagAXMigrateBuilderIcons and {
        name = IconName.ArrowCurlToRight,
        variant = IconVariant.Regular
    }
        or "icons/actions/edit/redo",
    Torso = FFlagAXMigrateBuilderIcons and {
        name = IconName.Torso,
        variant = IconVariant.Filled
    }
        or "icons/menu/clothing/torsos_on",
    Arm = FFlagAXMigrateBuilderIcons and {
        name = IconName.Arm,
        variant = IconVariant.Filled
    } or "icons/menu/clothing/arms_on",
    Leg = FFlagAXMigrateBuilderIcons and {
        name = IconName.Leg,
        variant = IconVariant.Filled
    } or "icons/menu/clothing/legs_on",
    Inventory = FFlagAXMigrateBuilderIcons and {
        name = IconName.Backpack,
        variant = IconVariant.Regular
    } or "icons/menu/inventoryOff",
    Adjust = FFlagAXMigrateBuilderIcons and {
        name = IconName.ThreeSlidersHorizontal,
        variant = IconVariant.Regular
    }
        or "icons/actions/adjust",
    Success = FFlagAXMigrateBuilderIcons and {
        name = IconName.CheckLarge,
        variant = IconVariant.Filled
    }
        or "icons/status/success_small",
    Add = FFlagAXMigrateBuilderIcons and {
        name = IconName.CirclePlus,
        variant = IconVariant.Regular
    }
        or "icons/actions/edit/add",
    Build = FFlagAXMigrateBuilderIcons and {
        name = IconName.PersonStandingDualArrowsVertical,
        variant = IconVariant.Filled
    }
        or "icons/menu/clothing/build_on",
    Eyelashes = FFlagAXMigrateBuilderIcons and {
        name = IconName.Eyelashes,
        variant = IconVariant.Regular
    } or IconName.Eyelashes,
    Eyebrows = FFlagAXMigrateBuilderIcons and {
        name = IconName.Eyebrows,
        variant = IconVariant.Regular
    } or IconName.Eyebrows,
    Backgrounds = {
        name = IconName.Image,
        variant = IconVariant.Filled
    },
    SpawnEffects = {
        name = IconName.CursorStars,
        variant = IconVariant.Filled
    }
}

local BodyAssetTypes = {
    Enum.AssetType.LeftLeg,
    Enum.AssetType.RightLeg,
    Enum.AssetType.LeftArm,
    Enum.AssetType.RightArm,
    Enum.AssetType.Torso,
    Enum.AssetType.Head,
    Enum.AssetType.DynamicHead
}

local tbl4 = { Categories.All, Categories.Avatars, Categories.Body }
if not FFlagAXDownrankMakeupCustomize then
    table.insert(tbl4, Categories.Makeup)
end
table.insert(tbl4, Categories.Clothing)
table.insert(tbl4, Categories.Accessories)
if FFlagAXCustomizeBackgrounds then
    table.insert(tbl4, Categories.Backgrounds)
end
table.insert(tbl4, Categories.Animations)
table.insert(tbl4, Categories.Emotes)
if FFlagAXDownrankMakeupCustomize then
    table.insert(tbl4, Categories.Makeup)
end

local tbl5 = ({})
for value, value2 in tbl4 do
    tbl5[value2] = value - 1
end

local SlotEditorCategories = {
    [Categories.All] = {
        name = "All",
        nameTranslationKey = if FFlagAXSlotsDesktopRedesign then "Feature.Avatar.Heading.All" else "Feature.Catalog.Label.Avatars",
        index = tbl5[Categories.All],
        slots = {},
        hide = true
    },
    [Categories.Avatars] = {
        name = "Avatars",
        nameTranslationKey = "Feature.Catalog.Label.Avatars",
        index = tbl5[Categories.Avatars],
        slots = {}
    },
    [Categories.Body] = {
        name = "Body",
        nameTranslationKey = "Feature.Catalog.Label.Body",
        index = tbl5[Categories.Body],
        slots = FFlagRemoveClassicHeadsAndFaces
            and {
                {
                    name = "Body",
                    nameTranslationKey = "Feature.Catalog.Label.FullBody",
                    editorSubcategory = AvatarEditorSubcategories.PurchasedCharacters,
                    assetTypes = {}
                },
                {
                    nameTranslationKey = "Feature.Avatar.Label.Hair",
                    icon = Icons.Hair,
                    editorSubcategory = AvatarEditorSubcategories.Hair,
                    assetTypes = { Enum.AvatarAssetType.HairAccessory }
                },
                {
                    nameTranslationKey = "Feature.Avatar.Label.Head",
                    icon = Icons.ClassicHead,
                    editorSubcategory = AvatarEditorSubcategories.Heads,
                    assetTypes = { Enum.AvatarAssetType.DynamicHead }
                },
                {
                    name = "Build",
                    nameTranslationKey = "Feature.Avatar.Label.Build",
                    assetTypes = {},
                    icon = Icons.Build,
                    editorSubcategory = AvatarEditorSubcategories.Build
                },
                {
                    name = "Skin",
                    nameTranslationKey = "Feature.Avatar.Label.Skin",
                    editorSubcategory = AvatarEditorSubcategories.Skin,
                    assetTypes = {}
                }
            }
            or {
                {
                    name = "Body",
                    nameTranslationKey = "Feature.Catalog.Label.FullBody",
                    editorSubcategory = AvatarEditorSubcategories.PurchasedCharacters,
                    assetTypes = {}
                },
                {
                    nameTranslationKey = "Feature.Avatar.Label.Hair",
                    icon = Icons.Hair,
                    editorSubcategory = AvatarEditorSubcategories.Hair,
                    assetTypes = { Enum.AvatarAssetType.HairAccessory }
                },
                {
                    nameTranslationKey = "Feature.Avatar.Label.Head",
                    icon = Icons.ClassicHead,
                    editorSubcategory = AvatarEditorSubcategories.Heads,
                    assetTypes = { Enum.AvatarAssetType.DynamicHead, Enum.AvatarAssetType.Head }
                },
                {
                    name = "Classic Face",
                    nameTranslationKey = "Feature.Avatar.Label.Face",
                    icon = Icons.Faces,
                    editorSubcategory = AvatarEditorSubcategories.ClassicFaces,
                    assetTypes = { Enum.AvatarAssetType.Face }
                },
                {
                    name = "Build",
                    nameTranslationKey = "Feature.Avatar.Label.Build",
                    assetTypes = {},
                    icon = Icons.Build,
                    editorSubcategory = AvatarEditorSubcategories.Build
                },
                {
                    name = "Skin",
                    nameTranslationKey = "Feature.Avatar.Label.Skin",
                    editorSubcategory = AvatarEditorSubcategories.Skin,
                    assetTypes = {}
                }
            }
    },
    [Categories.Makeup] = {
        name = "Makeup",
        nameTranslationKey = "Feature.Avatar.Label.Makeup",
        index = tbl5[Categories.Makeup],
        resetSlotOnClearAll = true,
        slots = {
            {
                nameTranslationKey = "Feature.Avatar.Label.Eyelashes",
                icon = Icons.Eyelashes,
                editorSubcategory = AvatarEditorSubcategories.MakeupLooks,
                eligibleSubcategories = {
                    AvatarEditorSubcategories.MakeupLooks,
                    AvatarEditorSubcategories.EyeMakeup,
                    AvatarEditorSubcategories.FaceMakeup,
                    AvatarEditorSubcategories.LipMakeup
                },
                assetTypes = {},
                hide = true
            },
            {
                slotType = SlotType.LayeredSlot,
                layerLimit = 6,
                name = "Makeup",
                nameTranslationKey = "Feature.Avatar.Label.MakeupLayer",
                eligibleSubcategories = { AvatarEditorSubcategories.EyeMakeup, AvatarEditorSubcategories.FaceMakeup, AvatarEditorSubcategories.LipMakeup },
                editorSubcategory = AvatarEditorSubcategories.EyeMakeup,
                assetTypes = { Enum.AvatarAssetType.EyeMakeup, Enum.AvatarAssetType.FaceMakeup, Enum.AvatarAssetType.LipMakeup },
                deselectable = true
            },
            {
                nameTranslationKey = "Feature.Avatar.Label.Eyelashes",
                icon = Icons.Eyelashes,
                editorSubcategory = AvatarEditorSubcategories.Eyelashes,
                assetTypes = { Enum.AvatarAssetType.EyelashAccessory },
                deselectable = true
            },
            {
                nameTranslationKey = "Feature.Avatar.Label.Eyebrows",
                icon = Icons.Eyebrows,
                editorSubcategory = AvatarEditorSubcategories.Eyebrows,
                assetTypes = { Enum.AvatarAssetType.EyebrowAccessory },
                deselectable = true
            }
        }
    },
    [Categories.Clothing] = {
        name = "Clothing",
        nameTranslationKey = "Feature.Catalog.Label.Clothing",
        index = tbl5[Categories.Clothing],
        slots = {
            {
                nameTranslationKey = "Feature.Avatar.Label.Top",
                icon = Icons.Shirts,
                editorSubcategory = AvatarEditorSubcategories.Tops,
                assetTypes = { Enum.AvatarAssetType.ShirtAccessory, Enum.AvatarAssetType.TShirtAccessory, Enum.AvatarAssetType.SweaterAccessory }
            },
            {
                nameTranslationKey = "Feature.Avatar.Label.Outerwear",
                icon = Icons.Jackets,
                editorSubcategory = AvatarEditorSubcategories.Outerwear,
                assetTypes = { Enum.AvatarAssetType.JacketAccessory }
            },
            {
                nameTranslationKey = "Feature.Avatar.Label.Bottom",
                icon = Icons.Pants,
                editorSubcategory = AvatarEditorSubcategories.Bottoms,
                assetTypes = { Enum.AvatarAssetType.PantsAccessory, Enum.AvatarAssetType.ShortsAccessory, Enum.AvatarAssetType.DressSkirtAccessory }
            },
            {
                nameTranslationKey = "Feature.Avatar.Label.Shoes",
                icon = Icons.Shoes,
                editorSubcategory = AvatarEditorSubcategories.Shoes,
                assetTypes = { Enum.AvatarAssetType.RightShoeAccessory }
            },
            {
                nameTranslationKey = "Feature.Avatar.Label.ShirtClassic",
                icon = Icons.ClassicShirts,
                editorSubcategory = AvatarEditorSubcategories.ClassicShirts,
                assetTypes = { Enum.AvatarAssetType.Shirt }
            },
            {
                nameTranslationKey = "Feature.Avatar.Label.PantsClassic",
                icon = Icons.ClassicPants,
                editorSubcategory = AvatarEditorSubcategories.ClassicPants,
                assetTypes = { Enum.AvatarAssetType.Pants }
            },
            {
                nameTranslationKey = "Feature.Avatar.Label.TShirtClassic",
                icon = Icons.ClassicTShirts,
                editorSubcategory = AvatarEditorSubcategories.ClassicTShirts,
                assetTypes = { Enum.AvatarAssetType.TShirt }
            }
        }
    },
    [Categories.Accessories] = {
        name = "Accessories",
        nameTranslationKey = "Feature.Catalog.LabelAccessories",
        index = tbl5[Categories.Accessories],
        slots = {
            {
                name = "Head",
                nameTranslationKey = "Feature.Avatar.Label.Head",
                icon = Icons.Head,
                editorSubcategory = AvatarEditorSubcategories.Hats,
                assetTypes = { Enum.AvatarAssetType.Hat }
            },
            {
                nameTranslationKey = "Feature.Avatar.Label.Face",
                icon = Icons.Face,
                editorSubcategory = AvatarEditorSubcategories.Face,
                assetTypes = { Enum.AvatarAssetType.FaceAccessory }
            },
            {
                nameTranslationKey = "Feature.Avatar.Label.Neck",
                icon = Icons.Neck,
                editorSubcategory = AvatarEditorSubcategories.Neck,
                assetTypes = { Enum.AvatarAssetType.NeckAccessory }
            },
            {
                nameTranslationKey = "Feature.Avatar.Label.Back",
                icon = Icons.Back,
                editorSubcategory = AvatarEditorSubcategories.Back,
                assetTypes = { Enum.AvatarAssetType.BackAccessory }
            },
            {
                nameTranslationKey = "Feature.Avatar.Label.Waist",
                icon = Icons.Waist,
                editorSubcategory = AvatarEditorSubcategories.Waist,
                assetTypes = { Enum.AvatarAssetType.WaistAccessory }
            },
            {
                nameTranslationKey = "Feature.Avatar.Label.Shoulder",
                icon = Icons.Shoulder,
                editorSubcategory = AvatarEditorSubcategories.Shoulder,
                assetTypes = { Enum.AvatarAssetType.ShoulderAccessory }
            },
            {
                nameTranslationKey = "Feature.Avatar.Label.Front",
                icon = Icons.Front,
                editorSubcategory = AvatarEditorSubcategories.Front,
                assetTypes = { Enum.AvatarAssetType.FrontAccessory }
            },
            {
                nameTranslationKey = "Feature.Avatar.Label.Gear",
                icon = Icons.Gear,
                editorSubcategory = AvatarEditorSubcategories.Gear,
                assetTypes = { Enum.AvatarAssetType.Gear }
            }
        }
    },
    [Categories.Backgrounds] = FFlagAXCustomizeBackgrounds
        and {
            name = "Backgrounds",
            nameTranslationKey = "Feature.Catalog.Label.Backgrounds",
            index = tbl5[Categories.Backgrounds],
            slots = {}
        }
        or nil,
    [Categories.Animations] = {
        name = "Animations",
        nameTranslationKey = "Feature.Avatar.Heading.Animations",
        index = tbl5[Categories.Animations],
        slots = {
            {
                nameTranslationKey = "Feature.Avatar.Label.AnimationFullSet",
                icon = Icons.Animation,
                editorSubcategory = AvatarEditorSubcategories.AnimationFullSets,
                assetTypes = { Enum.AvatarAssetType.IdleAnimation }
            },
            {
                nameTranslationKey = "Feature.Avatar.Label.Idle",
                icon = Icons.Idle,
                editorSubcategory = AvatarEditorSubcategories.IdleAnimations,
                assetTypes = { Enum.AvatarAssetType.IdleAnimation }
            },
            {
                nameTranslationKey = "Feature.Avatar.Label.Walk",
                icon = Icons.Walk,
                editorSubcategory = AvatarEditorSubcategories.WalkAnimations,
                assetTypes = { Enum.AvatarAssetType.WalkAnimation }
            },
            {
                nameTranslationKey = "Feature.Avatar.Label.Run",
                icon = Icons.Animation,
                editorSubcategory = AvatarEditorSubcategories.RunAnimations,
                assetTypes = { Enum.AvatarAssetType.RunAnimation }
            },
            {
                nameTranslationKey = "Feature.Avatar.Label.Jump",
                icon = Icons.Jump,
                editorSubcategory = AvatarEditorSubcategories.JumpAnimations,
                assetTypes = { Enum.AvatarAssetType.JumpAnimation }
            },
            {
                nameTranslationKey = "Feature.Avatar.Label.Fall",
                icon = Icons.Fall,
                editorSubcategory = AvatarEditorSubcategories.FallAnimations,
                assetTypes = { Enum.AvatarAssetType.FallAnimation }
            },
            {
                nameTranslationKey = "Feature.Avatar.Label.Climb",
                icon = Icons.Climb,
                editorSubcategory = AvatarEditorSubcategories.ClimbAnimations,
                assetTypes = { Enum.AvatarAssetType.ClimbAnimation }
            },
            {
                nameTranslationKey = "Feature.Avatar.Label.Swim",
                icon = Icons.Swim,
                editorSubcategory = AvatarEditorSubcategories.SwimAnimations,
                assetTypes = { Enum.AvatarAssetType.SwimAnimation }
            }
        }
    },
    [Categories.Emotes] = {
        name = "Emotes",
        nameTranslationKey = "Feature.Catalog.Label.Emotes",
        index = tbl5[Categories.Emotes],
        slots = {}
    }
}

if FFlagAXSpawnEffects then
    table.insert(SlotEditorCategories[Categories.Animations].slots, 1, {
        nameTranslationKey = "Feature.Avatar.Label.Spawn",
        icon = Icons.SpawnEffects,
        editorSubcategory = AvatarEditorSubcategories.SpawnEffects,
        assetTypes = { (Enum.AvatarAssetType:FromValue(97)) }
    })
end

local tbl7 = if FFlagAXInventoryDurablesExpiredFilter then {
    [InventoryFilters.Expired] = 2
} else nil
tbl1.Categories = Categories
tbl1.SlotEditorCategories = SlotEditorCategories
tbl1.Icons = Icons
tbl1.BodyAssetTypes = BodyAssetTypes
tbl1.InventoryFilterToAvailabilityStatus = tbl7
tbl1.ActionBarHeight = 64

return tbl1
