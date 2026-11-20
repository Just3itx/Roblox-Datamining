-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T17:41:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local Analytics = require(scriptParentParent.Analytics)

local _Types = require(scriptParentParent.util.Types)

local function validateLayeredClothingAccessoryMeshPartAssetFormatMatch(arg1, arg2, arg3)
    local handle = arg1:FindFirstChild("Handle")
    assert(handle and handle:IsA("MeshPart"))

    local handle2 = arg2:FindFirstChild("Handle")
    assert(handle2 and handle2:IsA("MeshPart"))

    if handle.MeshId ~= handle2.MeshId then
        Analytics.reportFailure(
            Analytics.ErrorType.validateLayeredClothingAccessoryMeshPartAssetFormatMatch_MeshIdMismatch,
            nil,
            arg3
        )

        return false, { string.format(
                "Model meshId mismatch between MeshPart.MeshId and SpecialMesh.MeshId for %s. You need to match the meshIds and try again.",
                arg1.Name
            ) }
    end

    if handle.TextureID == handle2.TextureID then
        return true
    end

    Analytics.reportFailure(
        Analytics.ErrorType.validateLayeredClothingAccessoryMeshPartAssetFormatMatch_TextureIdMismatch,
        nil,
        arg3
    )

    return false, { string.format(
            "Model textureId mismatch between MeshPart.TextureID and SpecialMesh.TextureId for %s. You need to match the textureIds and try again.",
            arg1.Name
        ) }
end

return validateLayeredClothingAccessoryMeshPartAssetFormatMatch
