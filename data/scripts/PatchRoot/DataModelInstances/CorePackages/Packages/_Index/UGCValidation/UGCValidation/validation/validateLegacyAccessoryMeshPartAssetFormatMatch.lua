-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T17:41:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local Analytics = require(scriptParentParent.Analytics)

local _Types = require(scriptParentParent.util.Types)

local function validateLegacyAccessoryMeshPartAssetFormatMatch(arg1, arg2, arg3)
    local handle = arg1:FindFirstChild("Handle")
    assert(handle and handle:IsA("MeshPart"))

    local handle2 = arg2:FindFirstChild("Handle")
    assert(handle2 and handle2:IsA("Part"))
    local specialMesh = handle2:FindFirstChildOfClass("SpecialMesh")
    assert(specialMesh)

    if handle.MeshId ~= specialMesh.MeshId then
        Analytics.reportFailure(Analytics.ErrorType.validateLegacyAccessoryMeshPartAssetFormatMatch_MeshIdMismatch, nil, arg3)

        return false, { string.format(
                "Model meshId mismatch with rigid accessory SpecialMesh.MeshId for '%s'. You need to match the meshIds and try again.",
                arg1.Name
            ) }
    end

    local textureId = handle.TextureID
    if textureId == "" then
        local surfaceAppearance = handle:FindFirstChildOfClass("SurfaceAppearance")
        if surfaceAppearance then
            textureId = surfaceAppearance.ColorMap
        end
    end

    if textureId == specialMesh.TextureId then
        return true
    end

    Analytics.reportFailure(
        Analytics.ErrorType.validateLegacyAccessoryMeshPartAssetFormatMatch_TextureIdMismatch,
        nil,
        arg3
    )

    return false, { string.format(
            "Model textureId mismatch with rigid accessory SpecialMesh.TextureId for '%s'. You need to match the textureIds and try again.",
            arg1.Name
        ) }
end

return validateLegacyAccessoryMeshPartAssetFormatMatch
