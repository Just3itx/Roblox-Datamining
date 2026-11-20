-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T17:30:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local Constants = require(scriptParentParent.Constants)

local _Types = require(scriptParentParent.util.Types)
local getEditableMeshFromContext = require(scriptParentParent.util.getEditableMeshFromContext)

local function getContent(arg1, str1: string)
    if str1 == Constants.MESH_CONTENT_TYPE.RENDER_MESH then
        assert(arg1:IsA("MeshPart"), "Only MESH_TYPE.RENDER_MESH is only supported for MeshPart")
        return arg1.MeshId
    end

    if str1 == Constants.MESH_CONTENT_TYPE.OUTER_CAGE then
        assert(arg1:IsA("BaseWrap"), "Only MESH_TYPE.OUTER_CAGE is only supported for BaseWrap")
        return arg1.CageMeshId
    end

    if str1 == Constants.MESH_CONTENT_TYPE.INNER_CAGE then
        assert(arg1:IsA("WrapLayer"), "Only MESH_TYPE.INNER_CAGE is only supported for WrapLayer")
        return arg1.ReferenceMeshId
    end

    error("No valid mesh content type was provided")
end

local function getMeshInfo(arg1, str1: string, arg2)
    local contentId = getContent(arg1, str1)
    local fullName = arg1:GetFullName()
    local fieldName = Constants.MESH_CONTENT_TYPE_TO_FIELD_NAME[str1]
    local var2, editableMesh = getEditableMeshFromContext(arg1, fieldName, arg2)
    if not var2 then
        return false, { string.format("Mesh for '%s' failed to load. Make sure the mesh exists and try again.", fullName) }
    end

    return true, nil, {
        fullName = fullName,
        fieldName = fieldName,
        contentId = contentId,
        context = arg1.ClassName,
        editableMesh = editableMesh
    }
end
return getMeshInfo
