-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T17:11:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local _Types = require(scriptParentParent.util.Types)
local tryYield = require(scriptParentParent.util.tryYield)
local getEditableMeshFromContext = require(scriptParentParent.util.getEditableMeshFromContext)

local getAssetMeshesValidationSpaceTransforms = require(scriptParentParent.util.AssetCalculator).getAssetMeshesValidationSpaceTransforms

local AssetService = game:GetService("AssetService")

local getFIntUGCValidationBodyAssetMaskHeightPixels = require(scriptParentParent.flags.getFIntUGCValidationBodyAssetMaskHeightPixels)
local getFFlagUGCValidateTinyTrianglesIntersectFix = require(scriptParentParent.flags.getFFlagUGCValidateTinyTrianglesIntersectFix)

local module = {}
module.__index = module

module.viewIds = {
    Front = "Front",
    Back = "Back",
    Left = "Left",
    Right = "Right",
    Top = "Top",
    Bottom = "Bottom"
}

if getFFlagUGCValidateTinyTrianglesIntersectFix() then
    module.opposingViewIds = {
        Front = module.viewIds.Back,
        Back = module.viewIds.Front,
        Left = module.viewIds.Right,
        Right = module.viewIds.Left,
        Top = module.viewIds.Bottom,
        Bottom = module.viewIds.Top
    }
end

module.viewDirections = {
    [module.viewIds.Front] = Vector3.new(0, 0, 1),
    [module.viewIds.Back] = Vector3.new(0, 0, -1),
    [module.viewIds.Left] = Vector3.new(-1, 0, 0),
    [module.viewIds.Right] = Vector3.new(1, 0, 0),
    [module.viewIds.Top] = Vector3.new(0, -1, 0),
    [module.viewIds.Bottom] = Vector3.new(0, 1, 0)
}

module.views = nil

function module.getViewToWorldTransforms()
    if not module.views then
        module.views = {}
        for _, viewId in module.viewIds do
            local viewDirection = module.viewDirections[viewId]
            local vec3 = Vector3.new(0, 1, 0)
            if math.abs((viewDirection:Dot(vec3))) > 0.99 then
                vec3 = module.viewDirections[module.viewIds.Front]
            end
            local cFrame = CFrame.lookAlong(Vector3.new(0, 0, 0), viewDirection, vec3)

            module.views[viewId] = cFrame
        end
    end

    return module.views
end

function module.getViewSpacePositionFromNormalized(vector2: Vector2, tbl1)
    local var1 = (vector2 - Vector2.new(0.5, 0.5)) * Vector2.new(2, -2)
    local var2 = (tbl1.max - tbl1.min) / 2
    return tbl1.min + var2 + var2 * Vector3.new(var1.X, var1.Y, 0)
end

local function populateViewsToRender(tbl1)
    local viewToWorldTransforms = module.getViewToWorldTransforms()
    local result = ({})
    if not tbl1 then
        return viewToWorldTransforms
    end

    for value, value2 in tbl1 do
        if value2 and viewToWorldTransforms[value] then
            result[value] = viewToWorldTransforms[value]
        end
    end

    return result
end

local function addTransformedTriangle(editableMesh, num1: number, tbl1, tbl2)
    local faceVertices = editableMesh:GetFaceVertices(num1)

    local tbl3 = {}
    for i = 1, 3 do
        local var1 = editableMesh:GetPosition(faceVertices[i]) * tbl1.scale
        table.insert(tbl3, tbl1.CFrame * var1)
    end

    table.insert(tbl2, tbl3)
end

local function pushTransformedMesh(editableMesh, tbl1, arg1, tbl2)
    for _, value in (editableMesh:GetFaces()) do
        addTransformedTriangle(editableMesh, value, tbl1, tbl2)
        tryYield(arg1)
    end
end

local function getViewSpaceMesh(tbl1, cFrame: CFrame)
    local cFrame2 = cFrame:Inverse()

    local tbl2 = {
        min = Vector3.new(math.huge, math.huge, math.huge),
        max = Vector3.new(-math.huge, -math.huge, -math.huge)
    }

    local tbl3 = {}
    for _, value in tbl1 do
        local tbl4 = {}
        for _, value2 in value do
            local other = cFrame2 * value2
            table.insert(tbl4, cFrame2 * value2)
            tbl2.min = tbl2.min:Min(other)
            tbl2.max = tbl2.max:Max(other)
        end
        table.insert(tbl3, tbl4)
    end

    return tbl3, tbl2
end

local function getNormalizedCoordinates(tbl1, vec1: vector, vec2: vector) -- Luacid: Inlined by compiler; 1 call site recovered
    local normalizedCoordinates = {}
    for _, value in tbl1 do
        table.insert(normalizedCoordinates, (value - vec1) / vec2)
    end

    return normalizedCoordinates
end

local function getIsNormalizedTriangleVisible(normalizedCoordinates): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return (normalizedCoordinates[2] - normalizedCoordinates[1]):Cross(normalizedCoordinates[3] - normalizedCoordinates[1]).Z > 0.001
end

local function normalizedSpaceToScreenSpace(vec1: vector, vector2: Vector2)
    return (Vector2.new(vec1.X, vec1.Y) * Vector2.new(0.5, -0.5) + Vector2.new(0.5, 0.5)) * (vector2 - Vector2.new(1, 1))
end

local function rasterMesh(viewSpaceMesh, tbl1, y: number, arg1)
    local var1 = tbl1.max - tbl1.min
    local var2 = var1 / 2
    local var3 = tbl1.min + var2

    local x = var1.X / var1.Y * y
    local vector2 = Vector2.new(x, y)

    local var4 = (vector2 * math.min(1024 / math.max(vector2.X, vector2.Y), 1) + Vector2.new(0.5)):Floor()

    local editableImage = AssetService:CreateEditableImage({ Size = var4 })

    for _, value in viewSpaceMesh do
        local normalizedCoordinates = getNormalizedCoordinates(value, var3, var2)

        if not getIsNormalizedTriangleVisible(normalizedCoordinates) then
            continue
        end

        local tbl2 = {}
        for _, value2 in normalizedCoordinates do
            table.insert(tbl2, (normalizedSpaceToScreenSpace(value2, var4)))
        end
        editableImage:DrawTriangle(tbl2[1], tbl2[2], tbl2[3], Color3.new(1, 1, 1), 0)
        tryYield(arg1)
    end

    return editableImage
end

local function createBodyAssetMasks(arg1, tbl1, arg2)
    local assetTypeEnum = arg2.assetTypeEnum

    local tbl2 = {}
    if arg1:IsA("MeshPart") and arg2.assetTypeEnum == Enum.AssetType.DynamicHead then
        table.insert(tbl2, arg1)
    else
        for _, child in arg1:GetChildren() do
            if child:IsA("MeshPart") then
                table.insert(tbl2, child)
            end
        end
    end

    local assetMeshesValidationSpaceTransforms = getAssetMeshesValidationSpaceTransforms(arg1, arg2)

    local tbl3 = {}
    for _, value in tbl2 do
        local var1, var2 = getEditableMeshFromContext(value, "MeshId", arg2)
        if not var1 then
            local str1 = string.format("Failed to load mesh for MeshPart '%s'. Make sure mesh exists and try again.", value.Name)

            if not arg2.isServer then
                return false, { str1 }
            end

            error(str1)
        end

        var2:Triangulate()

        local assetMeshesValidationSpaceTransform = assetMeshesValidationSpaceTransforms[value.Name]
        pushTransformedMesh(var2, assetMeshesValidationSpaceTransform, arg2, tbl3)
    end

    if #tbl3 == 0 then
        return false, { string.format("Mesh for %s has no triangles.", assetTypeEnum.Name) }
    end

    local tbl4 = ({})
    for viewId, view in tbl1 do
        local tbl5, viewSpaceBounds = getViewSpaceMesh(tbl3, view)
        local fIntUgcValidationBodyAssetMaskHeightPixels = getFIntUGCValidationBodyAssetMaskHeightPixels()
        tbl4[viewId] = {
            viewId = viewId,
            mask = rasterMesh(tbl5, viewSpaceBounds, fIntUgcValidationBodyAssetMaskHeightPixels, arg2),
            view = view,
            viewSpaceBounds = viewSpaceBounds
        }
    end
    return true, tbl4
end

function module.new(arg1, tbl1, arg2)
    local var1 = (setmetatable({}, module))
    local var2 = populateViewsToRender(tbl1)
    local bool1, bodyAssetMasks = createBodyAssetMasks(arg1, var2, arg2)
    if not bool1 then
        return false, bodyAssetMasks
    end
    var1.bodyAssetMasks = bodyAssetMasks
    return true, var1
end

function module:destroyBodyAssetMasks()
    for _, bodyAssetMask in self.bodyAssetMasks do
        if bodyAssetMask.mask then
            bodyAssetMask.mask:Destroy()
            bodyAssetMask.mask = nil
        end
    end
end

return module
