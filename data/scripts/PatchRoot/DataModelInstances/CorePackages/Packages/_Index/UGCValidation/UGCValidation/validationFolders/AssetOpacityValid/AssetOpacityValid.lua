-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T17:50:40Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent

local _Types = require(scriptParentParentParent.util.Types)
local ValidationEnums = require(scriptParentParentParent.validationSystem.ValidationEnums)
local ErrorSourceStrings = require(scriptParentParentParent.validationSystem.ErrorSourceStrings)

local AssetCalculator = require(scriptParentParentParent.util.AssetCalculator)
local RasterUtil = require(scriptParentParentParent.util.RasterUtil)
local TransparencyUtil = require(scriptParentParentParent.util.TransparencyUtil)
local tryYield = require(scriptParentParentParent.util.tryYield)

local ConstantsTransparencyValidation = require(scriptParentParentParent.ConstantsTransparencyValidation)

local module = {
    categories = { ValidationEnums.UploadCategory.TORSO_AND_LIMBS, ValidationEnums.UploadCategory.DYNAMIC_HEAD },
    requiredData = { ValidationEnums.SharedDataMember.renderMeshesData },
    expectedFailures = {}
}
local function getViews()
    return {
        {
            axis1 = Vector3.new(1, 0, 0),
            axis2 = Vector3.new(0, 1, 0),
            normal = Vector3.new(0, 0, 1),
            viewId = ConstantsTransparencyValidation.CAMERA_ANGLES.Front
        },
        {
            axis1 = Vector3.new(1, 0, 0),
            axis2 = Vector3.new(0, 1, 0),
            normal = Vector3.new(0, 0, -1),
            viewId = ConstantsTransparencyValidation.CAMERA_ANGLES.Back
        },
        {
            axis1 = Vector3.new(0, 0, 1),
            axis2 = Vector3.new(0, 1, 0),
            normal = Vector3.new(-1, 0, 0),
            viewId = ConstantsTransparencyValidation.CAMERA_ANGLES.Left
        },
        {
            axis1 = Vector3.new(0, 0, 1),
            axis2 = Vector3.new(0, 1, 0),
            normal = Vector3.new(1, 0, 0),
            viewId = ConstantsTransparencyValidation.CAMERA_ANGLES.Right
        },
        {
            axis1 = Vector3.new(1, 0, 0),
            axis2 = Vector3.new(0, 0, 1),
            normal = Vector3.new(0, -1, 0),
            viewId = ConstantsTransparencyValidation.CAMERA_ANGLES.Top
        },
        {
            axis1 = Vector3.new(1, 0, 0),
            axis2 = Vector3.new(0, 0, 1),
            normal = Vector3.new(0, 1, 0),
            viewId = ConstantsTransparencyValidation.CAMERA_ANGLES.Bottom
        }
    }
end

local function getAspectRatio(vec1: vector, viewId: string) -- Luacid: Inlined by compiler; 1 call site recovered
    if viewId == ConstantsTransparencyValidation.CAMERA_ANGLES.Front
        or viewId == ConstantsTransparencyValidation.CAMERA_ANGLES.Back
    then
        return vec1.X / vec1.Y
    end

    if viewId == ConstantsTransparencyValidation.CAMERA_ANGLES.Left
        or viewId == ConstantsTransparencyValidation.CAMERA_ANGLES.Right
    then
        return vec1.Z / vec1.Y
    end

    return vec1.X / vec1.Z
end

local function getScaleFactor(vec1: vector, viewId: string)
    local aspectRatio = getAspectRatio(vec1, viewId)
    local assetTransparencyRasterSize, assetTransparencyRasterSize2

    if aspectRatio > 1 then
        assetTransparencyRasterSize = ConstantsTransparencyValidation.ASSET_TRANSPARENCY_RASTER_SIZE / aspectRatio
        assetTransparencyRasterSize2 = ConstantsTransparencyValidation.ASSET_TRANSPARENCY_RASTER_SIZE
    elseif aspectRatio < 1 then
        assetTransparencyRasterSize2 = ConstantsTransparencyValidation.ASSET_TRANSPARENCY_RASTER_SIZE * aspectRatio
        assetTransparencyRasterSize = ConstantsTransparencyValidation.ASSET_TRANSPARENCY_RASTER_SIZE
    else
        assetTransparencyRasterSize2 = ConstantsTransparencyValidation.ASSET_TRANSPARENCY_RASTER_SIZE
        assetTransparencyRasterSize = ConstantsTransparencyValidation.ASSET_TRANSPARENCY_RASTER_SIZE
    end

    local vector2 = Vector2.new(
        assetTransparencyRasterSize2 / ConstantsTransparencyValidation.ASSET_TRANSPARENCY_RASTER_SIZE,
        assetTransparencyRasterSize / ConstantsTransparencyValidation.ASSET_TRANSPARENCY_RASTER_SIZE
    )
    local num1 = math.max(vector2.X, vector2.Y)
    return if num1 > 1 then vector2 / num1 else vector2
end

local function addTransformedTriangle(editableMesh, tbl1, arg1, cFrame: CFrame, vec1: vector)
    local tbl2 = {
        orderedVerts = {}
    }

    local faceVertices = editableMesh:GetFaceVertices(arg1)

    local position = editableMesh:GetPosition(faceVertices[1])
    local position2 = editableMesh:GetPosition(faceVertices[2])
    local position3 = editableMesh:GetPosition(faceVertices[3])

    local var1, var2, var3, normal = TransparencyUtil.transformTriangleToWorld(position, position2, position3, cFrame, vec1)
    table.insert(tbl2.orderedVerts, var1)
    table.insert(tbl2.orderedVerts, var2)
    table.insert(tbl2.orderedVerts, var3)
    tbl2.normal = normal

    table.insert(tbl1, tbl2)

    return tbl2
end

local function updateMinMaxBounds(tbl1: {max: Vector3, min: Vector3}, tbl2: {orderedVerts: {[any]: any}})
    local minX = tbl1.min.X
    local maxX = tbl1.max.X
    local minY = tbl1.min.Y
    local maxY = tbl1.max.Y
    local minZ = tbl1.min.Z
    local maxZ = tbl1.max.Z

    local orderedVert = tbl2.orderedVerts[1]
    local orderedVert2 = tbl2.orderedVerts[2]
    local orderedVert3 = tbl2.orderedVerts[3]

    local x = math.min(orderedVert.X, orderedVert2.X, orderedVert3.X, minX)
    local x2 = math.max(orderedVert.X, orderedVert2.X, orderedVert3.X, maxX)
    local y = math.min(orderedVert.Y, orderedVert2.Y, orderedVert3.Y, minY)
    local y2 = math.max(orderedVert.Y, orderedVert2.Y, orderedVert3.Y, maxY)
    local z = math.min(orderedVert.Z, orderedVert2.Z, orderedVert3.Z, minZ)
    local z2 = math.max(orderedVert.Z, orderedVert2.Z, orderedVert3.Z, maxZ)

    tbl1.min = Vector3.new(x, y, z)
    tbl1.max = Vector3.new(x2, y2, z2)
end

local function getOpacity(arg1)
    local buf = arg1:ReadPixelsBuffer(Vector2.new(0, 0), arg1.Size)
    local num1 = 0
    local num2 = 0
    for i = 0, buffer.len(buf) - 1, 4 do
        local num3 = buffer.readu8(buf, i)
        local num4 = buffer.readu8(buf, i + 1)
        local num5 = buffer.readu8(buf, i + 2)

        if num3 == 0 and num4 == 0 and num5 == 0 then
            num2 += 1
        end

        num1 += 1
    end

    if num1 == 0 then
        return false, 0
    end

    return true, 1 - num2 / num1
end

local tbl1 = {
    [Enum.AssetType.LeftArm] = true,
    [Enum.AssetType.RightArm] = true,
    [Enum.AssetType.LeftLeg] = true,
    [Enum.AssetType.RightLeg] = true
}

function module.run(arg1, arg2)
    local rootInstance = arg2.rootInstance
    local assetType = arg2.uploadEnum.assetType
    local renderMeshesData = arg2.renderMeshesData
    local tbl2 = {
        shouldYield = arg2.consumerConfig.validationEnv ~= ValidationEnums.ValidationEnv.Backend,
        lastTickSeconds = tick()
    }

    local tbl3 = {}
    if rootInstance:IsA("MeshPart") and assetType == Enum.AssetType.DynamicHead then
        table.insert(tbl3, rootInstance)
    else
        for _, child in rootInstance:GetChildren() do
            if child:IsA("MeshPart") then
                table.insert(tbl3, child)
            end
        end
    end

    local tbl4 = {}
    for _, value in tbl3 do
        if value.Transparency ~= 0 then
            table.insert(tbl4, value.Name)
        end
    end

    if #tbl4 > 0 then
        for _, partName in tbl4 do
            arg1:fail(ErrorSourceStrings.Keys.AssetOpacity_NonZeroTransparency, { PartName = partName })
        end

        return
    end

    local allTransformsForAsset = AssetCalculator.calculateAllTransformsForAsset(assetType, rootInstance)

    if tbl1[assetType] then
        for value, value2 in (AssetCalculator.calculateStraightenedLimb(assetType, allTransformsForAsset, function(str1: string) -- name: findMeshHandle
            return (rootInstance:FindFirstChild(str1))
        end)) do
            allTransformsForAsset[value] = value2
        end
    end

    local tbl5 = {}
    local tbl6 = {
        min = Vector3.new(math.huge, math.huge, math.huge),
        max = Vector3.new(-math.huge, -math.huge, -math.huge)
    }

    for _, value in tbl3 do
        local var1 = renderMeshesData[value.Name]
        if not var1 then
            arg1:fail(ErrorSourceStrings.Keys.AssetOpacity_MeshLoadFailed, { PartName = value.Name })

            return
        end
        local editable = var1.editable
        editable:Triangulate()

        local var2 = value.Size / value.MeshSize

        local cFrame = allTransformsForAsset[value.Name] or CFrame.new()
        for _, value2 in (editable:GetFaces()) do
            local tbl7 = addTransformedTriangle(editable, tbl5, value2, cFrame, var2)
            updateMinMaxBounds(tbl6, tbl7)
            tryYield(tbl2)
        end
    end

    if (tbl6.max - tbl6.min).Magnitude == 0 then
        arg1:fail(ErrorSourceStrings.Keys.AssetOpacity_ZeroSize, { AssetName = assetType.Name })

        return
    end

    for _, value in (getViews()) do
        if #tbl5 == 0 then
            local assetOpacityNoTriangles = ErrorSourceStrings.Keys.AssetOpacity_NoTriangles
            local tbl7 = {
                AssetName = assetType.Name
            }
            arg1:fail(assetOpacityNoTriangles, tbl7)
        else
            local var1 = tbl6.max - tbl6.min
            local var2 = tbl6.min + var1 / 2
            local var3 = Vector2.new(
                ConstantsTransparencyValidation.ASSET_TRANSPARENCY_RASTER_SIZE,
                ConstantsTransparencyValidation.ASSET_TRANSPARENCY_RASTER_SIZE
            ) * getScaleFactor(var1, value.viewId)

            local var4 = RasterUtil.rasterMesh(tbl5, var3, value, var2, var1, tbl2)

            local var5 = ConstantsTransparencyValidation.ASSET_TRANSPARENCY_THRESHOLDS[assetType][value.viewId]
            local bool1, num1 = getOpacity(var4)
            if not bool1 then
                local assetOpacityInvisible = ErrorSourceStrings.Keys.AssetOpacity_Invisible
                local tbl7 = {
                    AssetName = assetType.Name
                }
                arg1:fail(assetOpacityInvisible, tbl7)

                var4:Destroy()
            else
                if num1 < var5 then
                    local assetOpacityBelowThreshold = ErrorSourceStrings.Keys.AssetOpacity_BelowThreshold
                    local tbl7 = {
                        AssetName = assetType.Name,
                        ViewName = value.viewId,
                        Opacity = string.format("%.2f", num1),
                        Threshold = string.format("%.2f", var5)
                    }
                    arg1:fail(assetOpacityBelowThreshold, tbl7)
                end

                var4:Destroy()
            end
        end
    end
end

return module
