-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T16:30:33Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent

local Cryo = require(scriptParent.Parent.Cryo)

local ValidationRulesUtil = require(scriptParent.util.ValidationRulesUtil)
local ValidationEnums = require(scriptParent.validationSystem.ValidationEnums)
local getFFlagUGCValidationEyebrowEyelashSupport = require(scriptParent.flags.getFFlagUGCValidationEyebrowEyelashSupport)
local getFFlagUGCValidateCheckHSROwner = require(scriptParent.flags.getFFlagUGCValidateCheckHSROwner)
local getFFlagUGCValidateCheckTexturePackOwner = require(scriptParent.flags.getFFlagUGCValidateCheckTexturePackOwner)
local bool1 = game:DefineFastFlag("UGCValidateMakeupDecalUVProperties", false)
local getFFlagUGCValidateMakeupCategoryParity = require(scriptParent.flags.getFFlagUGCValidateMakeupCategoryParity)
local getFFlagUGCValidateDisallowAeroMeshData = require(scriptParent.flags.getFFlagUGCValidateDisallowAeroMeshData)

local getFFlagUGCValidateWrapLayerDeformationMapsEmpty = require(scriptParent.flags.getFFlagUGCValidateWrapLayerDeformationMapsEmpty)
local engineHasWrapLayerDeformationMaps = require(scriptParent.util.engineHasWrapLayerDeformationMaps)

local function convertArrayToTable(tbl1: {Enum.Material}) -- Luacid: Inlined by compiler; 1 call site recovered
    local result = ({})
    for _, material in pairs(tbl1) do
        result[material] = true
    end
    return result
end

local tbl1 = {
    MAX_HAT_TRIANGLES = ValidationRulesUtil:getRules().MeshRules.AccessoryMaxTriangles,
    MAX_TEXTURE_SIZE = ValidationRulesUtil:getRules().TextureRules.MaxTextureSize,
    MATERIAL_WHITELIST = convertArrayToTable({ Enum.Material.Plastic }),
    BANNED_CLASS_NAMES = {
        "Script",
        "LocalScript",
        "ModuleScript",
        "ParticleEmitter",
        "Fire",
        "Smoke",
        "Sparkles"
    },
    R6_BODY_PARTS = {
        "Torso",
        "Left Leg",
        "Right Leg",
        "Left Arm",
        "Right Arm"
    },
    R15_BODY_PARTS = {
        "Head",
        "UpperTorso",
        "LowerTorso",
        "LeftUpperLeg",
        "LeftLowerLeg",
        "LeftFoot",
        "RightUpperLeg",
        "RightLowerLeg",
        "RightFoot",
        "LeftUpperArm",
        "LeftLowerArm",
        "LeftHand",
        "RightUpperArm",
        "RightLowerArm",
        "RightHand"
    },
    R15_CAGE_PARTS = {
        "Head_OuterCage",
        "UpperTorso_OuterCage",
        "LowerTorso_OuterCage",
        "LeftUpperLeg_OuterCage",
        "LeftLowerLeg_OuterCage",
        "LeftFoot_OuterCage",
        "RightUpperLeg_OuterCage",
        "RightLowerLeg_OuterCage",
        "RightFoot_OuterCage",
        "LeftUpperArm_OuterCage",
        "LeftLowerArm_OuterCage",
        "LeftHand_OuterCage",
        "RightUpperArm_OuterCage",
        "RightLowerArm_OuterCage",
        "RightHand_OuterCage"
    },
    NAMED_R15_BODY_PARTS = {}
}

for _, value in tbl1.R15_BODY_PARTS do
    tbl1.NAMED_R15_BODY_PARTS[value] = value
end
tbl1.NAMED_R15_BODY_PARTS.Head = "Head"

setmetatable(tbl1.NAMED_R15_BODY_PARTS, {
    __index = function()
        error("NAMED_R15_BODY_PARTS key does not exist")
        return nil
    end
})

tbl1.R15_STANDARD_JOINT_NAMES = {
    Root = true,
    HumanoidRootNode = true,
    DynamicHead = true,
    Head = true,
    UpperTorso = true,
    LowerTorso = true,
    LeftUpperLeg = true,
    LeftLowerLeg = true,
    LeftFoot = true,
    RightUpperLeg = true,
    RightLowerLeg = true,
    RightFoot = true,
    LeftUpperArm = true,
    LeftLowerArm = true,
    LeftHand = true,
    RightUpperArm = true,
    RightLowerArm = true,
    RightHand = true
}

tbl1.ALLOWED_SKINNING_TRANSFER_JOINT_NAMES = { RBX_Leader = true, RBX_Follower = true }

for _, value in tbl1.R15_BODY_PARTS do
    tbl1.R15_STANDARD_JOINT_NAMES[value] = true
end

tbl1.UGC_BODY_PARTS = {
    "Head",
    "UpperTorso",
    "LowerTorso",
    "LeftUpperLeg",
    "LeftLowerLeg",
    "LeftHand",
    "RightUpperArm",
    "RightLowerArm",
    "RightHand",
    "LeftUpperArm",
    "LeftLowerArm",
    "LeftFoot",
    "RightUpperLeg",
    "RightLowerLeg",
    "RightFoot",
    "EyebrowAccessory",
    "EyelashAccessory",
    "HairAccessory"
}

tbl1.UGC_BODY_PART_NAMES_TO_ASSET_TYPE = {
    Head = Enum.AssetType.DynamicHead,
    UpperTorso = Enum.AssetType.Torso,
    LowerTorso = Enum.AssetType.Torso,
    LeftUpperArm = Enum.AssetType.LeftArm,
    LeftLowerArm = Enum.AssetType.LeftArm,
    LeftHand = Enum.AssetType.LeftArm,
    RightUpperArm = Enum.AssetType.RightArm,
    RightLowerArm = Enum.AssetType.RightArm,
    RightHand = Enum.AssetType.RightArm,
    LeftUpperLeg = Enum.AssetType.LeftLeg,
    LeftLowerLeg = Enum.AssetType.LeftLeg,
    LeftFoot = Enum.AssetType.LeftLeg,
    RightUpperLeg = Enum.AssetType.RightLeg,
    RightLowerLeg = Enum.AssetType.RightLeg,
    RightFoot = Enum.AssetType.RightLeg,
    EyebrowAccessory = Enum.AssetType.EyebrowAccessory,
    EyelashAccessory = Enum.AssetType.EyelashAccessory,
    HairAccessory = Enum.AssetType.HairAccessory
}

tbl1.UGC_SHOE_NAMES_TO_ASSET_TYPE = {
    LeftShoeAccessory = Enum.AssetType.LeftShoeAccessory,
    RightShoeAccessory = Enum.AssetType.RightShoeAccessory
}

tbl1.BUNDLE_TO_ASSET_MAPPING = {
    [Enum.BundleType.BodyParts] = tbl1.UGC_BODY_PART_NAMES_TO_ASSET_TYPE,
    [Enum.BundleType.BodyParts] = tbl1.UGC_SHOE_NAMES_TO_ASSET_TYPE
}

tbl1.ASSET_TYPES_THAT_SKIP_FOLDER = {
    Enum.AssetType.DynamicHead,
    Enum.AssetType.EyebrowAccessory,
    Enum.AssetType.EyelashAccessory,
    Enum.AssetType.HairAccessory
}

tbl1.FOLDER_NAMES = { R6 = "R6", R15ArtistIntent = "R15ArtistIntent", R15Fixed = "R15Fixed" }

tbl1.EXTRA_BANNED_NAMES = { "Head", "HumanoidRootPart", "Humanoid" }

for _, value in ipairs({ "Body Colors", "Shirt Graphic", "Shirt", "Pants", "Health", "Animate" }) do
    table.insert(tbl1.EXTRA_BANNED_NAMES, value)
end

tbl1.BANNED_NAMES = {}
for _, value in { tbl1.R6_BODY_PARTS, tbl1.R15_BODY_PARTS, tbl1.EXTRA_BANNED_NAMES } do
    for _, value2 in value do
        tbl1.BANNED_NAMES[value2] = true
    end
end

tbl1.ASSET_STATUS = {
    UNKNOWN = "Unknown",
    REVIEW_PENDING = "ReviewPending",
    MODERATED = "Moderated"
}

tbl1.MAKEUP_INFO = ValidationRulesUtil:getMakeupRules()

tbl1.ASSET_TYPE_INFO = {}
ValidationRulesUtil:getAccessoryRules(tbl1.ASSET_TYPE_INFO)

tbl1.FULL_BODY_BOUNDS = ValidationRulesUtil:getFullBodyRulesBounds()

tbl1.AvatarPartScaleTypes = { Classic = true, ProportionsSlender = true, ProportionsNormal = true }

ValidationRulesUtil:getBodyPartRules(tbl1.ASSET_TYPE_INFO)

tbl1.BODYPART_TO_PARENT = {
    Head = nil,
    LowerTorso = nil,
    UpperTorso = "LowerTorso",
    LeftUpperArm = nil,
    LeftLowerArm = "LeftUpperArm",
    LeftHand = "LeftLowerArm",
    LeftUpperLeg = nil,
    LeftLowerLeg = "LeftUpperLeg",
    RightUpperArm = nil,
    RightLowerArm = "RightUpperArm",
    RightHand = "RightLowerArm",
    RightUpperLeg = nil,
    RightLowerLeg = "RightUpperLeg"
}
tbl1.BODYPART_TO_PARENT.RightFoot = "RightLowerLeg"
tbl1.BODYPART_TO_PARENT.LeftFoot = "LeftLowerLeg"

tbl1.RenderVsWrapMeshMaxDiff = ValidationRulesUtil:getRules().MeshRules.CageMeshMaxDistanceFromRenderMesh

tbl1.COMPARISON_METHODS = {
    SMALLER = "<",
    SMALLER_EQ = "<=",
    FUZZY_EQ = "=",
    EXACT_EQ = "==",
    GREATER_EQ = ">=",
    GREATER = ">",
    FOUND_IN = "one of the following:"
}

setmetatable(tbl1.COMPARISON_METHODS, {
    __index = function(_, arg1)
        return error("Invalid COMPARISON_METHOD " .. tostring(arg1))
    end
})

tbl1.INCLUSION_METHODS = {
    RUN_ON_ALL = "RUN_ON_ALL",
    INCLUSION_LIST = "INCLUSION_LIST",
    EXCLUSION_LIST = "EXCLUSION_LIST"
}

setmetatable(tbl1.INCLUSION_METHODS, {
    __index = function(_, arg1)
        return error("Invalid INCLUSION_METHOD " .. tostring(arg1))
    end
})

local var1 = getFFlagUGCValidateWrapLayerDeformationMapsEmpty() and engineHasWrapLayerDeformationMaps()

local PROPERTIES = {
    Instance = { Archivable = true },
    Attachment = { Visible = false },
    Decal = {
        Color3 = Color3.new(1, 1, 1),
        Transparency = 0,
        UVOffset = if bool1 then Vector2.new(0, 0) else nil,
        UVScale = if bool1 then Vector2.new(1, 1) else nil
    },
    SpecialMesh = {
        MeshType = Enum.MeshType.FileMesh,
        Offset = Vector3.new(0, 0, 0),
        VertexColor = Vector3.new(1, 1, 1)
    },
    BasePart = {
        Anchored = false,
        CollisionGroupId = 0,
        CustomPhysicalProperties = Cryo.None,
        Elasticity = 0.5,
        Friction = 0.3,
        LocalTransparencyModifier = 0,
        Massless = false,
        Reflectance = 0,
        RootPriority = 0,
        RotVelocity = Vector3.new(0, 0, 0),
        Velocity = Vector3.new(0, 0, 0),
        BackParamA = -0.5,
        BackParamB = 0.5,
        BackSurfaceInput = Enum.InputType.NoInput,
        BottomParamA = -0.5,
        BottomParamB = 0.5,
        BottomSurfaceInput = Enum.InputType.NoInput,
        FrontParamA = -0.5,
        FrontParamB = 0.5,
        FrontSurfaceInput = Enum.InputType.NoInput,
        LeftParamA = -0.5,
        LeftParamB = 0.5,
        LeftSurfaceInput = Enum.InputType.NoInput,
        RightParamA = -0.5,
        RightParamB = 0.5,
        RightSurfaceInput = Enum.InputType.NoInput,
        TopParamA = -0.5,
        TopParamB = 0.5,
        TopSurfaceInput = Enum.InputType.NoInput,
        BackSurface = Enum.SurfaceType.Smooth,
        BottomSurface = {
            [tbl1.COMPARISON_METHODS.FOUND_IN] = { Enum.SurfaceType.Smooth, Enum.SurfaceType.Inlet }
        },
        FrontSurface = Enum.SurfaceType.Smooth,
        LeftSurface = Enum.SurfaceType.Smooth,
        RightSurface = Enum.SurfaceType.Smooth,
        TopSurface = {
            [tbl1.COMPARISON_METHODS.FOUND_IN] = { Enum.SurfaceType.Smooth, Enum.SurfaceType.Studs }
        },
        Transparency = {
            [tbl1.COMPARISON_METHODS.EXACT_EQ] = 0
        },
        Color = {
            [tbl1.COMPARISON_METHODS.FUZZY_EQ] = BrickColor.new("Medium stone grey").Color,
            [tbl1.INCLUSION_METHODS.EXCLUSION_LIST] = {
                Enum.AssetType.DynamicHead,
                Enum.AssetType.Torso,
                Enum.AssetType.LeftArm,
                Enum.AssetType.RightArm,
                Enum.AssetType.LeftLeg,
                Enum.AssetType.RightLeg
            }
        }
    },
    Part = {
        Shape = Enum.PartType.Block
    },
    MeshPart = {
        FluidFidelity = if getFFlagUGCValidateDisallowAeroMeshData() then Enum.FluidFidelity.Automatic else nil
    },
    SurfaceAppearance = 0,
    WrapLayer = 0,
    WrapTarget = 0
}
local SurfaceAppearance = { AlphaMode = 0, EmissiveStrength = 0 }
local Overlay

if getFFlagUGCValidationEyebrowEyelashSupport() then
    Overlay = {
        {
            [tbl1.COMPARISON_METHODS.FOUND_IN] = { Enum.AlphaMode.Overlay, Enum.AlphaMode.Transparency },
            [tbl1.INCLUSION_METHODS.INCLUSION_LIST] = { Enum.AssetType.EyelashAccessory, Enum.AssetType.EyebrowAccessory }
        },
        {
            [tbl1.COMPARISON_METHODS.EXACT_EQ] = Enum.AlphaMode.Overlay,
            [tbl1.INCLUSION_METHODS.EXCLUSION_LIST] = { Enum.AssetType.EyelashAccessory, Enum.AssetType.EyebrowAccessory }
        }
    }
else
    Overlay = Enum.AlphaMode.Overlay
end

SurfaceAppearance.AlphaMode = Overlay

SurfaceAppearance.EmissiveStrength = {
    [tbl1.COMPARISON_METHODS.GREATER_EQ] = 0,
    [tbl1.COMPARISON_METHODS.SMALLER_EQ] = 40
}
PROPERTIES.SurfaceAppearance = SurfaceAppearance

PROPERTIES.WrapLayer = {
    Enabled = true,
    CageOrigin = {
        PositionMagnitude = {
            [tbl1.COMPARISON_METHODS.SMALLER_EQ] = 10
        },
        Orientation = {
            [tbl1.COMPARISON_METHODS.EXACT_EQ] = Vector3.new(0, 0, 0)
        }
    },
    ReferenceOrigin = {
        PositionMagnitude = {
            [tbl1.COMPARISON_METHODS.SMALLER_EQ] = 10
        },
        Orientation = {
            [tbl1.COMPARISON_METHODS.EXACT_EQ] = Vector3.new(0, 0, 0)
        }
    },
    ImportOrigin = {
        PositionMagnitude = {
            [tbl1.COMPARISON_METHODS.SMALLER_EQ] = 8
        }
    },
    BindOffset = {
        Position = {
            [tbl1.COMPARISON_METHODS.EXACT_EQ] = Vector3.new(0, 0, 0)
        },
        Orientation = {
            [tbl1.COMPARISON_METHODS.EXACT_EQ] = Vector3.new(0, 0, 0)
        }
    },
    RotateScaleDeformationMap = if var1 then Content.none else nil,
    ScaleOnlyDeformationMap = if var1 then Content.none else nil
}

PROPERTIES.WrapTarget = {
    CageOrigin = {
        PositionMagnitude = {
            [tbl1.COMPARISON_METHODS.SMALLER_EQ] = 10
        },
        Orientation = {
            [tbl1.COMPARISON_METHODS.EXACT_EQ] = Vector3.new(0, 0, 0)
        }
    },
    ImportOrigin = {
        PositionMagnitude = {
            [tbl1.COMPARISON_METHODS.SMALLER_EQ] = 8
        }
    }
}
tbl1.PROPERTIES = PROPERTIES

tbl1.CONTENT_ID_FIELDS = {
    SpecialMesh = { "MeshId", "TextureId" },
    MeshPart = { "MeshId", "TextureID" },
    SurfaceAppearance = {
        "ColorMap",
        "MetalnessMap",
        "NormalMap",
        "RoughnessMap"
    },
    Decal = {
        "ColorMap",
        "MetalnessMap",
        "NormalMap",
        "RoughnessMap"
    },
    WrapLayer = { "CageMeshId", "ReferenceMeshId" },
    WrapTarget = { "CageMeshId" },
    Animation = { "AnimationId" }
}

tbl1.CONTENT_FIELDS_WITHOUT_CONTENTID = {
    SurfaceAppearance = { "EmissiveMaskContent" }
}

if getFFlagUGCValidateCheckTexturePackOwner() then
    table.insert(tbl1.CONTENT_ID_FIELDS.SurfaceAppearance, "TexturePack")
end

if getFFlagUGCValidateCheckHSROwner() then
    table.insert(tbl1.CONTENT_ID_FIELDS.WrapLayer, "HSRAssetId")
end

tbl1.CONTENT_ID_REQUIRED_FIELDS = {
    SpecialMesh = { MeshId = true, TextureId = true },
    MeshPart = { MeshId = true },
    WrapTarget = { CageMeshId = true },
    Animation = { AnimationId = true }
}

tbl1.CONTENT_ID_EDITABLE_PROPERTY = {
    MeshPart = { MeshId = "MeshContent", TextureID = "TextureContent" },
    WrapTarget = { CageMeshId = "CageMeshContent" },
    WrapLayer = { CageMeshId = "CageMeshContent", ReferenceMeshId = "ReferenceMeshContent" },
    SurfaceAppearance = {
        ColorMap = "ColorMapContent",
        MetalnessMap = "MetalnessMapContent",
        NormalMap = "NormalMapContent",
        RoughnessMap = "RoughnessMapContent"
    }
}

tbl1.CONTENT_TYPED_PROPERTIES_BY_CLASS = {
    MeshPart = { "MeshContent", "TextureContent" },
    WrapTarget = { "CageMeshContent" },
    WrapLayer = { "CageMeshContent", "ReferenceMeshContent" },
    SurfaceAppearance = {
        "ColorMapContent",
        "MetalnessMapContent",
        "NormalMapContent",
        "RoughnessMapContent",
        "EmissiveMaskContent"
    },
    Decal = {
        "ColorMapContent",
        "MetalnessMapContent",
        "NormalMapContent",
        "RoughnessMapContent"
    },
    WrapTextureTransfer = { "ReferenceCageMeshContent" }
}

tbl1.MESH_CONTENT_ID_FIELDS = {
    SpecialMesh = { "MeshId" },
    MeshPart = { "MeshId" },
    WrapTarget = { "CageMeshId" },
    WrapLayer = { "CageMeshId", "ReferenceMeshId" }
}

tbl1.TEXTURE_CONTENT_ID_FIELDS = {
    SpecialMesh = { "TextureId" },
    MeshPart = { "TextureID" },
    SurfaceAppearance = {
        "ColorMap",
        "MetalnessMap",
        "NormalMap",
        "RoughnessMap"
    },
    Decal = {
        "ColorMap",
        "MetalnessMap",
        "NormalMap",
        "RoughnessMap"
    }
}
tbl1.ASSET_RENDER_MESH_MAX_TRIANGLES = {
    DynamicHead = ValidationRulesUtil:getBodyPartMaxTrianglesRule(Enum.AssetType.DynamicHead),
    LeftArm = ValidationRulesUtil:getBodyPartMaxTrianglesRule(Enum.AssetType.LeftArm),
    RightArm = ValidationRulesUtil:getBodyPartMaxTrianglesRule(Enum.AssetType.RightArm),
    Torso = ValidationRulesUtil:getBodyPartMaxTrianglesRule(Enum.AssetType.Torso),
    LeftLeg = ValidationRulesUtil:getBodyPartMaxTrianglesRule(Enum.AssetType.LeftLeg),
    RightLeg = ValidationRulesUtil:getBodyPartMaxTrianglesRule(Enum.AssetType.RightLeg)
}

tbl1.WRAP_TARGET_CAGE_MESH_UV_COUNTS = {
    Head = 343,
    LeftUpperArm = 77,
    LeftLowerArm = 77,
    LeftHand = 86,
    RightUpperArm = 77,
    RightLowerArm = 77,
    RightHand = 86,
    UpperTorso = 257,
    LowerTorso = 105,
    LeftUpperLeg = 88,
    LeftLowerLeg = 88,
    LeftFoot = 86,
    RightUpperLeg = 88,
    RightLowerLeg = 88,
    RightFoot = 86
}

tbl1.PACKAGE_CONTENT_ID_FIELDS = Cryo.Dictionary.join(tbl1.CONTENT_ID_FIELDS, {
    Sound = { "SoundId" },
    Decal = { "Texture" },
    VideoFrame = { "Video" },
    PackageLink = { "PackageId" },
    CharacterMesh = { "baseTextureAssetId", "overlayTextureAssetId", "meshAssetId" },
    Tool = { "TextureId" },
    Sky = {
        "SkyUp",
        "SkyLf",
        "SkyRt",
        "SkyBk",
        "SkyFt",
        "SkyDn",
        "Sun",
        "Moon"
    },
    Trail = { "texture" },
    Beam = { "texture" },
    ShirtGraphic = { "Graphic" },
    Shirt = { "ShirtTemplate" },
    Pants = { "PantsTemplate" },
    AdGui = { "FallbackImage" }
})

tbl1.ExperienceAuthHeaderKey = "RBX-ExperienceAuthorization"
tbl1.ContentType = "Content-Type"
tbl1.ApplicationJson = "application/json"

tbl1.GUIDAttributeName = "RBXGUID"
tbl1.GUIDAttributeMaxLength = 100

tbl1.EmoteIsUGCAttributeName = "RBXisUGCEmote"
tbl1.EmoteMaxPartTranslationAttributeName = "RBXmaxPartTranslation"

tbl1.AlternateMeshIdAttributeName = "RBX_ALT_MESH_ID"
tbl1.MESH_CONTENT_TYPE = {
    RENDER_MESH = "RenderMesh",
    OUTER_CAGE = "OuterCage",
    INNER_CAGE = "InnerCage"
}

tbl1.MESH_CONTENT_TYPE_TO_FIELD_NAME = {
    [tbl1.MESH_CONTENT_TYPE.RENDER_MESH] = "MeshId",
    [tbl1.MESH_CONTENT_TYPE.OUTER_CAGE] = "CageMeshId",
    [tbl1.MESH_CONTENT_TYPE.INNER_CAGE] = "ReferenceMeshId"
}

tbl1.ANIMATION_ASSET_INFO = {
    [Enum.AssetType.ClimbAnimation] = {
        modelName = "ClimbAnimation",
        stringValueNames = { "climb" }
    },
    [Enum.AssetType.FallAnimation] = {
        modelName = "FallAnimation",
        stringValueNames = { "fall" }
    },
    [Enum.AssetType.IdleAnimation] = {
        modelName = "IdleAnimation",
        stringValueNames = { "idle" }
    },
    [Enum.AssetType.JumpAnimation] = {
        modelName = "JumpAnimation",
        stringValueNames = { "jump" }
    },
    [Enum.AssetType.RunAnimation] = {
        modelName = "RunAnimation",
        stringValueNames = { "run" }
    },
    [Enum.AssetType.SwimAnimation] = {
        modelName = "SwimAnimation",
        stringValueNames = { "swim", "swimidle" }
    },
    [Enum.AssetType.WalkAnimation] = {
        modelName = "WalkAnimation",
        stringValueNames = { "walk" }
    }
}
tbl1.AllAssetUploadCategories = {
    ValidationEnums.UploadCategory.TORSO_AND_LIMBS,
    ValidationEnums.UploadCategory.DYNAMIC_HEAD,
    ValidationEnums.UploadCategory.LAYERED_CLOTHING,
    ValidationEnums.UploadCategory.EYEBROW_EYELASH,
    ValidationEnums.UploadCategory.RIGID_ACCESSORY,
    ValidationEnums.UploadCategory.EMOTE_ANIMATION
}

table.insert(tbl1.AllAssetUploadCategories, ValidationEnums.UploadCategory.ANIMATION)

tbl1.AllAssetUploadCategoriesIncludingMakeup = {}
for _, value in tbl1.AllAssetUploadCategories do
    table.insert(tbl1.AllAssetUploadCategoriesIncludingMakeup, value)
end
table.insert(tbl1.AllAssetUploadCategoriesIncludingMakeup, ValidationEnums.UploadCategory.MAKEUP)

if getFFlagUGCValidateMakeupCategoryParity() then
    table.insert(tbl1.AllAssetUploadCategories, ValidationEnums.UploadCategory.MAKEUP)
end

tbl1.AllBundleUploadCategories = { ValidationEnums.UploadCategory.FULL_BODY, ValidationEnums.UploadCategory.BOTH_SHOES }

table.insert(tbl1.AllBundleUploadCategories, ValidationEnums.UploadCategory.ANIMATION_PACK)

tbl1.AllUploadCategories = {}
for _, value in ValidationEnums.UploadCategory do
    table.insert(tbl1.AllUploadCategories, value)
end

tbl1.AssetUploadsWithFolderStructure = {
    [Enum.AssetType.Torso] = true,
    [Enum.AssetType.LeftArm] = true,
    [Enum.AssetType.RightArm] = true,
    [Enum.AssetType.LeftLeg] = true,
    [Enum.AssetType.RightLeg] = true
}

tbl1.SkinningTransferRequiredTypes = {
    [Enum.AssetType.EyebrowAccessory] = true,
    [Enum.AssetType.EyelashAccessory] = true
}

return tbl1
