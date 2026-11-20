-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T17:31:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UGCValidationService = game:GetService("UGCValidationService")
local tbl1 = { MeshId = true, CageMeshId = true, ReferenceMeshId = true }

local tbl2 = {
    TextureId = true,
    ColorMap = true,
    MetalnessMap = true,
    NormalMap = true,
    RoughnessMap = true,
    EmissiveMask = true
}

local function preloadEditablesFromRootInstance(arg1)
    local tbl3 = {}
    local tbl4 = {}
    local descendants = arg1:GetDescendants()
    table.insert(descendants, arg1)

    for _, descendant in descendants do
        if descendant:IsA("BinaryStringValue") and tbl1[descendant.Name] then
            tbl3[descendant.Parent[descendant.Name]] = UGCValidationService:CreateEditableMeshFromBinaryStringRobloxOnly(descendant)
        elseif descendant:IsA("BinaryStringValue") and tbl2[descendant.Name] then
            tbl4[descendant.Parent[descendant.Name]] = UGCValidationService:CreateEditableImageFromBinaryStringRobloxOnly(descendant)
        end
    end

    return tbl3, tbl4
end

return preloadEditablesFromRootInstance
