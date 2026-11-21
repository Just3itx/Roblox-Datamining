-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T03:01:23Z
-- Luau bytecode version: 14 | Luau type version: 3
local AvatarExperienceControlBarParent = script:FindFirstAncestor("AvatarExperienceControlBar").Parent

local FFlagAXResetAvatarButton = require(AvatarExperienceControlBarParent.AvatarExperienceFlags).FFlagAXResetAvatarButton

local AssetTypesToKeep = FFlagAXResetAvatarButton
    and {
        Enum.AssetType.Head,
        Enum.AssetType.Face,
        Enum.AssetType.Torso,
        Enum.AssetType.RightArm,
        Enum.AssetType.LeftArm,
        Enum.AssetType.LeftLeg,
        Enum.AssetType.RightLeg,
        Enum.AssetType.HairAccessory,
        Enum.AssetType.ClimbAnimation,
        Enum.AssetType.FallAnimation,
        Enum.AssetType.IdleAnimation,
        Enum.AssetType.JumpAnimation,
        Enum.AssetType.RunAnimation,
        Enum.AssetType.SwimAnimation,
        Enum.AssetType.WalkAnimation,
        Enum.AssetType.EmoteAnimation,
        Enum.AssetType.EyebrowAccessory,
        Enum.AssetType.EyelashAccessory,
        Enum.AssetType.MoodAnimation,
        Enum.AssetType.DynamicHead
    }
    or nil

local AssetTypeStringsToKeep = {}

if FFlagAXResetAvatarButton then
    for _, value in AssetTypesToKeep do
        table.insert(AssetTypeStringsToKeep, tostring(value.Value))
    end
end

return { AssetTypesToKeep = AssetTypesToKeep, AssetTypeStringsToKeep = AssetTypeStringsToKeep }
