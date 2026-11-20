-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T17:20:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local module = {}

local AssetService = game:GetService("AssetService")
local UGCValidationService = game:GetService("UGCValidationService")

local _Types = require(scriptParentParent.util.Types)
local destroyEditableInstances = require(scriptParentParent.util.destroyEditableInstances)

local function addEditableInstance(arg1, arg2, arg3, arg4, contentType) -- Luacid: Inlined by compiler; 1 call site recovered
    local editableMeshes = arg1.editableMeshes
    if contentType == "EditableImage" then
        editableMeshes = arg1.editableImages
    end

    if not editableMeshes[arg2] then
        editableMeshes[arg2] = {}
    end

    editableMeshes[arg2][arg3] = arg4
end

local function createEditableInstanceFromId(content, arg1, contentType)
    local success, result = pcall(function()
        if contentType == "EditableMesh" then
            return AssetService:CreateEditableMeshAsync(content)
        end
        return UGCValidationService:CreateEditableImageOriginalSizeAsync(content.Uri)
    end)

    if not success then
        return success, result
    end

    arg1[content.Uri] = result
    return true, { created = true, instance = result }
end

function module.getEditableInstanceInfo(content, arg1, contentType, arg2)
    local object = if arg2 then content.Object else nil

    if not object then
        local uri = content.Uri
        if uri and uri ~= "" then
            object = arg1[uri]
            if not object then
                return createEditableInstanceFromId(content, arg1, contentType)
            end
        end
    end
    return true, { instance = object, created = false }
end

local function addContent(tbl1, str1: string, content, contentType: string) -- Luacid: Inlined by compiler; 12 call sites recovered
    tbl1[str1] = { content = content, contentType = contentType }
end

local function getTextureContentMap(arg1, tbl1)
    if arg1:IsA("MeshPart") then
        addContent(tbl1, "TextureID", arg1.TextureContent, "EditableImage")
    elseif arg1:IsA("SpecialMesh") then
        addContent(tbl1, "TextureId", Content.fromUri(arg1.TextureId), "EditableImage")
    elseif arg1:IsA("SurfaceAppearance") or arg1:IsA("Decal") then
        addContent(tbl1, "ColorMap", arg1.ColorMapContent, "EditableImage")

        addContent(tbl1, "MetalnessMap", arg1.MetalnessMapContent, "EditableImage")

        addContent(tbl1, "NormalMap", arg1.NormalMapContent, "EditableImage")

        addContent(tbl1, "RoughnessMap", arg1.RoughnessMapContent, "EditableImage")
    end
end

local function getCageMeshContent(arg1) -- Luacid: Inlined by compiler; 2 call sites recovered
    return arg1.CageMeshContent
end

local function getMeshContentMap(arg1, tbl1)
    if arg1:IsA("MeshPart") then
        addContent(tbl1, "MeshId", arg1.MeshContent, "EditableMesh")
    elseif arg1:IsA("WrapTarget") then
        addContent(tbl1, "CageMeshId", getCageMeshContent(arg1), "EditableMesh")
    elseif arg1:IsA("WrapLayer") then
        addContent(tbl1, "CageMeshId", getCageMeshContent(arg1), "EditableMesh")

        addContent(tbl1, "ReferenceMeshId", arg1.ReferenceMeshContent, "EditableMesh")
    elseif arg1:IsA("SpecialMesh") then
        addContent(tbl1, "MeshId", Content.fromUri(arg1.MeshId), "EditableMesh")
    elseif arg1:IsA("WrapTextureTransfer") then
        addContent(tbl1, "ReferenceCageMeshContent", arg1.ReferenceCageMeshContent, "EditableMesh")
    end
end

function module.getOrCreateEditableInstances(arg1, arg2, arg3, arg4)
    local tbl1 = {}
    getMeshContentMap(arg1, tbl1)
    getTextureContentMap(arg1, tbl1)

    for value, value2 in tbl1 do
        local contentType = value2.contentType
        local var1, var2 = module.getEditableInstanceInfo(value2.content, arg2, contentType, arg4)

        if not var1 then
            return var1, var2
        end

        addEditableInstance(arg3, arg1, value, var2, contentType)
    end

    return true
end

function module.processAll(tbl1, bool1: boolean?)
    local tbl2 = {
        editableMeshes = {},
        editableImages = {}
    }

    local tbl3 = {}

    for _, value in tbl1 do
        local descendants = value:GetDescendants()
        table.insert(descendants, value)

        for _, descendant in pairs(descendants) do
            local var1, var2 = module.getOrCreateEditableInstances(descendant, tbl3, tbl2, bool1)

            if not var1 then
                destroyEditableInstances(tbl2.editableMeshes, tbl2.editableImages)

                return false, { var2 }
            end
        end
    end

    return true, tbl2
end

return module
