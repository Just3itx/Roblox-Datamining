-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T02:21:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local tbl1 = {}
local TorsoValue = Enum.AssetType.Torso.Value
tbl1[tostring(TorsoValue)] = true
local RightArmValue = Enum.AssetType.RightArm.Value
tbl1[tostring(RightArmValue)] = true
local LeftArmValue = Enum.AssetType.LeftArm.Value
tbl1[tostring(LeftArmValue)] = true
local LeftLegValue = Enum.AssetType.LeftLeg.Value
tbl1[tostring(LeftLegValue)] = true
local RightLegValue = Enum.AssetType.RightLeg.Value
tbl1[tostring(RightLegValue)] = true
local HeadValue = Enum.AssetType.Head.Value
tbl1[tostring(HeadValue)] = true
local MoodAnimationValue = Enum.AssetType.MoodAnimation.Value
tbl1[tostring(MoodAnimationValue)] = true
local DynamicHeadValue = Enum.AssetType.DynamicHead.Value
tbl1[tostring(DynamicHeadValue)] = true

local function getDoesBundleHaveClothingOrAccessories(tbl2)
    if tbl2 then
        if tbl2.itemType ~= Enum.AvatarItemType.Bundle.Name then
            return false
        end

        if tbl2.bundleType and tostring(tbl2.bundleType) ~= tostring(Enum.BundleType.BodyParts.Value) then
            return false
        end
        for _, item in tbl2.items do
            if item.type == Enum.AvatarItemType.Asset.Name
                and item.type == Enum.AvatarItemType.Asset.Name
                and item.assetType
                and not tbl1[item.assetType]
            then
                return true
            end
        end
    end
    return false
end

return getDoesBundleHaveClothingOrAccessories
