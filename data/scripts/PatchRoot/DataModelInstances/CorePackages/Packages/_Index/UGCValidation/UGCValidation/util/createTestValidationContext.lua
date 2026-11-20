-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T17:21:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local UGCValidationService = game:GetService("UGCValidationService")

local _Types = require(scriptParentParent.util.Types)

return function(assetTypeEnum, tbl1)
    local tbl2 = {
        isServer = true,
        assetTypeEnum = assetTypeEnum,
        validateMeshPartAccessories = false
    }

    local editableMeshes = {}
    local editableImages = {}
    for _, value in tbl1 do
        for _, descendant in value:GetDescendants() do
            if not descendant:IsA("BinaryStringValue") then
                continue
            end

            if descendant.Name == "MeshId" or descendant.Name == "CageMeshId" or descendant.Name == "ReferenceMeshId" then
                if not editableMeshes[descendant.Parent] then
                    editableMeshes[descendant.Parent] = {}
                end
                local var1 = editableMeshes[descendant.Parent]
                local descendantName = descendant.Name
                var1[descendantName] = {
                    created = true,
                    instance = UGCValidationService:CreateEditableMeshFromBinaryStringRobloxOnly(descendant)
                }
            else
                if not editableImages[descendant.Parent] then
                    editableImages[descendant.Parent] = {}
                end
                local var1 = editableImages[descendant.Parent]
                local descendantName = descendant.Name
                var1[descendantName] = {
                    created = true,
                    instance = UGCValidationService:CreateEditableImageFromBinaryStringRobloxOnly(descendant)
                }
            end
        end
    end

    tbl2.editableMeshes = editableMeshes
    tbl2.editableImages = editableImages

    return tbl2
end
