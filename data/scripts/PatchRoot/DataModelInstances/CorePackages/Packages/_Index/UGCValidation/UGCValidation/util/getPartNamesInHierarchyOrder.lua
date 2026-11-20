-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T17:31:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function getPartNamesInHierarchyOrder(assetType): {string}
    if Enum.AssetType.LeftArm == assetType then
        return { "LeftUpperArm", "LeftLowerArm", "LeftHand" }
    end

    if Enum.AssetType.RightArm == assetType then
        return { "RightUpperArm", "RightLowerArm", "RightHand" }
    end

    if Enum.AssetType.LeftLeg == assetType then
        return { "LeftUpperLeg", "LeftLowerLeg", "LeftFoot" }
    end

    if Enum.AssetType.RightLeg == assetType then
        return { "RightUpperLeg", "RightLowerLeg", "RightFoot" }
    end

    if Enum.AssetType.DynamicHead == assetType then
        return { "Head" }
    end

    if Enum.AssetType.Torso == assetType then
        return { "LowerTorso", "UpperTorso" }
    end
    assert(false, "Invalid asset type")
    return {}
end

return getPartNamesInHierarchyOrder
