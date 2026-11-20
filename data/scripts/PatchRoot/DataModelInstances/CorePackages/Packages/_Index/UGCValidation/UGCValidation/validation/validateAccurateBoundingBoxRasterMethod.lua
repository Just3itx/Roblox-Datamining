-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T17:40:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AssetService = game:GetService("AssetService")

local scriptParentParent = script.Parent.Parent

local Analytics = require(scriptParentParent.Analytics)
local bodyAssetMasksRenderer = require(scriptParentParent.util.bodyAssetMasksRenderer)
local nelderMead = require(scriptParentParent.util.nelderMead)
local SummedAreaTable = require(scriptParentParent.util.SummedAreaTable)
local FailureReasonsAccumulator = require(scriptParentParent.util.FailureReasonsAccumulator)
local AssetCalculator = require(scriptParentParent.util.AssetCalculator)
local getEditableMeshFromContext = require(scriptParentParent.util.getEditableMeshFromContext)
local getMeshVerts = require(scriptParentParent.util.getMeshVerts)
local getAttachmentCFrameInPartSpace = require(scriptParentParent.util.getAttachmentCFrameInPartSpace)
local _Types = require(scriptParentParent.util.Types)
local FloatVector = require(scriptParentParent.util.FloatVector)
local Extents = require(scriptParentParent.util.Extents)
local tryYield = require(scriptParentParent.util.tryYield)

local validateAccurateBoundingBoxFlags = require(scriptParentParent.flags.validateAccurateBoundingBoxFlags)
local getFFlagUGCValidateTinyTrianglesIntersectFix = require(scriptParentParent.flags.getFFlagUGCValidateTinyTrianglesIntersectFix)

local function getHeadNeckAttachmentMeshLocalPosition(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    local neckRigAttachment = arg1:FindFirstChild("NeckRigAttachment", true)
    if not neckRigAttachment then
        return nil
    end

    local attachmentCFrameInPartSpace = getAttachmentCFrameInPartSpace(neckRigAttachment)
    local var1 = arg1.Size / arg1.MeshSize
    return attachmentCFrameInPartSpace.Position / var1
end

local function projectMeshLocalPointToImageRow(headNeckAttachmentMeshLocalPosition: vector, arg1)
    local var1 = arg1.view:Inverse() * headNeckAttachmentMeshLocalPosition

    local viewSpaceBounds = arg1.viewSpaceBounds
    local var2 = (viewSpaceBounds.max.Y + viewSpaceBounds.min.Y) / 2
    local var3 = (viewSpaceBounds.max.Y - viewSpaceBounds.min.Y) / 2
    local var4 = (var1.Y - var2) / var3

    local maskSize = arg1.mask.Size
    return (var4 * -0.5 + 0.5) * (maskSize.Y - 1)
end

local function cloneMaskZeroedBelowRow(mask, num1: number)
    local maskSize = mask.Size
    local maskSizeX = maskSize.X
    local maskSizeY = maskSize.Y

    local var1 = mask:ReadPixelsBuffer(Vector2.zero, maskSize)

    local num2 = math.max(0, math.min(maskSizeY, math.floor(num1) + 1))
    if num2 < maskSizeY then
        local offset = num2 * maskSizeX * 4
        local count = (maskSizeY - num2) * maskSizeX * 4
        buffer.fill(var1, offset, 0, count)
    end

    local editableImage = AssetService:CreateEditableImage({ Size = maskSize })
    editableImage:WritePixelsBuffer(Vector2.zero, maskSize, var1)
    return editableImage
end

local function sampleAreaTable(arg1, x: number?, x2: number?, y: number?, y2: number?) -- Luacid: Inlined by compiler; 1 call site recovered
    local vector2 = Vector2.new(x, y)
    local vector2_2 = Vector2.new(x2, y2)
    local var1 = vector2 * arg1.size
    return (arg1:GetAreaDensityContinuous(var1, vector2_2 * arg1.size - var1))
end

local function shrinkBounds(arg1, func1: (...any) -> (...any), vector2: Vector2)
    local function func2(num1: number): number -- Luacid: Inlined by compiler; 1 call site recovered
        return if num1 % 2 == 0 then num1 - 1 else num1 + 1
    end

    for i = 1, 4 do
        local var1 = arg1[func2(i)]

        local var2 = 1 / vector2[if i < 3 then "X" else "Y"]

        local floatVector = FloatVector.new(arg1)
        local var3 = func1(arg1)
        local var4 = arg1[i]
        while var2 <= math.abs(var4 - var1) do
            local var5 = (var4 + var1) / 2
            floatVector[i] = var5
            local var6 = func1(floatVector)

            if var6 < var3 then
                floatVector[i] = var5 + (var1 - var5) * 0.01
                if not (func1(floatVector) - var6 > 0) then
                    var4 = var1
                end
            else
                var6 = var3
                local var7 = var4
                var4 = var5
                var5 = var7
            end

            var3 = var6
            var1 = var4
            var4 = var5
        end

        arg1[i] = var4
    end
end

local function createSimplex<T>(arg1: T, num1: number): {T}
    local simplex = {}
    table.insert(simplex, arg1)
    table.insert(simplex, arg1 + FloatVector.new(num1, 0, 0, 0))
    table.insert(simplex, arg1 + FloatVector.new(0, num1, 0, 0))
    table.insert(simplex, arg1 + FloatVector.new(0, 0, num1, 0))
    table.insert(simplex, arg1 + FloatVector.new(0, 0, 0, num1))
    return simplex
end

local function calculateMinimumBoundsForView(arg1, arg2)
    local floatVector = FloatVector.new(0, 1, 0, 1)
    local simplex = createSimplex(floatVector, 0.9)

    local mask = arg1.mask
    local maskSize = mask.Size
    local summedAreaTable = SummedAreaTable.new(maskSize, function(color3): number
        return if color3.R > 0 or color3.G > 0 or color3.B > 0 then 1 else 0
    end)

    summedAreaTable:BuildSummedAreaTable(mask)
    local areaDensity = summedAreaTable:GetAreaDensity(Vector2.zero, maskSize)
    if areaDensity <= 0 then
        return false, { string.format(
                "%s asset not visible from the %s, cannot determine quality of asset bounding box",
                arg2.assetTypeEnum.Name,
                arg1.viewId
            ) }
    end

    local var1 = validateAccurateBoundingBoxFlags.targetPercentage()
    local var2 = validateAccurateBoundingBoxFlags.percentageWeight()

    local function func1(arg3): number
        assert(arg3:getSize() == 4)

        local var3 = math.abs(
            (if arg3[1] <= arg3[2] and arg3[3] <= arg3[4] then sampleAreaTable(summedAreaTable, arg3[1], arg3[2], arg3[3], arg3[4]) else 0) / areaDensity * 100 - var1
        ) * var2

        local vector2 = Vector2.new(arg3[2] - arg3[1], arg3[4] - arg3[3])
        return var3 + (vector2.X + vector2.Y)
    end

    local var3 = validateAccurateBoundingBoxFlags.maxIterations()
    local vector2 = Vector2.new(1 / maskSize.X, 1 / maskSize.Y)
    local var4 = validateAccurateBoundingBoxFlags.convergedLength()
    local var5 = vector2.Magnitude * var4
    local nelderMead2 = nelderMead.new(simplex, func1, function(tbl1, num1: number): boolean
        if var3 <= num1 then
            return true
        end

        if nelderMead.calculateMaxLengthBetweenVertices(tbl1) <= var5 then
            return true
        end

        tryYield(arg2)
        return false
    end)

    nelderMead2:evaluate()

    local var6 = nelderMead2.simplex[1]
    shrinkBounds(var6, func1, maskSize)

    return true, (FloatVector.new(
        math.clamp(var6[1], 0, 1),
        math.clamp(var6[2], 0, 1),
        math.clamp(var6[3], 0, 1),
        math.clamp(var6[4], 0, 1)
    ))
end

local function transformIsAlignedWithAxis(cFrame: CFrame, vec1: vector): boolean -- Luacid: Inlined by compiler; 3 call sites recovered
    return if vec1:FuzzyEq(cFrame.XVector:Abs()) then true else not not vec1:FuzzyEq(cFrame.YVector:Abs())
end

local function alignedExtentsFromReprojectedPoint(vec1: vector, cFrame: CFrame)
    local bool1 = transformIsAlignedWithAxis(cFrame, Vector3.new(1, 0, 0))
    local tbl1 = {
        X = -math.huge,
        Y = -math.huge,
        Z = -math.huge
    }
    local tbl2 = {
        X = math.huge,
        Y = math.huge,
        Z = math.huge
    }

    if bool1 then
        tbl1.X = math.max(tbl1.X, vec1.X)
        tbl2.X = math.min(tbl2.X, vec1.X)
    end

    if transformIsAlignedWithAxis(cFrame, Vector3.new(0, 1, 0)) then
        tbl1.Y = math.max(tbl1.Y, vec1.Y)
        tbl2.Y = math.min(tbl2.Y, vec1.Y)
    end

    if transformIsAlignedWithAxis(cFrame, Vector3.new(0, 0, 1)) then
        tbl1.Z = math.max(tbl1.Z, vec1.Z)
        tbl2.Z = math.min(tbl2.Z, vec1.Z)
    end

    return Extents.fromMinMax(Vector3.new(tbl2.X, tbl2.Y, tbl2.Z), Vector3.new(tbl1.X, tbl1.Y, tbl1.Z))
end

local function calculateValidBounds(tbl1, arg1)
    local extents = Extents.new()

    local var1 = getFFlagUGCValidateTinyTrianglesIntersectFix() and {} or nil
    for value, value2 in tbl1 do
        local bool1, var2 = calculateMinimumBoundsForView(value2, arg1)
        if not bool1 then
            return false, var2
        end

        local vector2 = Vector2.new(var2[2], var2[3])
        local vector2_2 = Vector2.new(var2[1], var2[4])

        local viewSpacePositionFromNormalized = bodyAssetMasksRenderer.getViewSpacePositionFromNormalized(vector2, value2.viewSpaceBounds)
        local var3 = value2.view * viewSpacePositionFromNormalized

        local viewSpacePositionFromNormalized2 = bodyAssetMasksRenderer.getViewSpacePositionFromNormalized(vector2_2, value2.viewSpaceBounds)
        local var4 = value2.view * viewSpacePositionFromNormalized2

        local var5 = alignedExtentsFromReprojectedPoint(var3, value2.view)

        local var6 = alignedExtentsFromReprojectedPoint(var4, value2.view)

        if getFFlagUGCValidateTinyTrianglesIntersectFix() then
            local var7 = Extents.new():unionExtents(var5):unionExtents(var6)

            local opposingViewId = bodyAssetMasksRenderer.opposingViewIds[value]
            if var1[opposingViewId] then
                var1[opposingViewId] = var7:intersectExtents(var1[opposingViewId])
            else
                var1[value] = var7
            end
        else
            extents = extents:unionExtents(var5):unionExtents(var6)
        end
    end

    if getFFlagUGCValidateTinyTrianglesIntersectFix() then
        for _, value in var1 do
            extents = extents:unionExtents(value)
        end
        assert(extents:isValid())
    end

    return true, extents
end

local function worldSpacePositionFromPointInMeshPart(vec1: vector, arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    return arg1.CFrame * (vec1 * (arg1.Size / arg1.MeshSize))
end

local function getHighestInflatingPointInEachAxis(arg1, assetMeshesValidationSpaceTransforms, tbl1, func1: (...any) -> (...any), arg2)
    local tbl2 = {
        X = {
            positive = { inflationScale = 0, furthestPointWorldSpace = nil },
            negative = { inflationScale = 0, furthestPointWorldSpace = nil }
        },
        Y = {
            positive = { inflationScale = 0, furthestPointWorldSpace = nil },
            negative = { inflationScale = 0, furthestPointWorldSpace = nil }
        },
        Z = {
            positive = { inflationScale = 0, furthestPointWorldSpace = nil },
            negative = { inflationScale = 0, furthestPointWorldSpace = nil }
        }
    }

    local var1 = arg1:size()
    for fullName, editableMesh in tbl1 do
        local var2, var3, var4 = getMeshVerts({ editableMesh = editableMesh, fullName = fullName }, arg2)
        if not var2 then
            return false, var3
        end

        local assetMeshesValidationSpaceTransform = assetMeshesValidationSpaceTransforms[fullName]

        for _, value3 in var4 do
            local var5 = value3 * assetMeshesValidationSpaceTransform.scale
            local var6 = assetMeshesValidationSpaceTransform.CFrame * var5
            local furthestPointWorldSpace = worldSpacePositionFromPointInMeshPart(value3, (func1(fullName)))
            local var8 = (var6 - arg1.max) / var1
            local var9 = (arg1.min - var6) / var1

            for _, value4 in { "X", "Y", "Z" } do
                local var10 = tbl2[value4]
                local positive = var10.positive
                local inflationScale = var8[value4]
                if positive.inflationScale < inflationScale then
                    positive.furthestPointWorldSpace = furthestPointWorldSpace
                    positive.inflationScale = inflationScale
                end
                local negative = var10.negative
                local var7 = var9[value4]
                if negative.inflationScale < var7 then
                    negative.furthestPointWorldSpace = furthestPointWorldSpace
                    negative.inflationScale = var7
                end
            end
        end
    end

    return true, tbl2
end

local function getBodyPartAssetEditableMeshes(arg1, arg2)
    local tbl1 = {}
    if arg1:IsA("MeshPart") and arg2.assetTypeEnum == Enum.AssetType.DynamicHead then
        table.insert(tbl1, arg1)
    else
        for _, child in arg1:GetChildren() do
            if child:IsA("MeshPart") then
                table.insert(tbl1, child)
            end
        end
    end

    local tbl2 = {}
    for _, value in tbl1 do
        local var1, var2 = getEditableMeshFromContext(value, "MeshId", arg2)
        if not var1 then
            local str1 = string.format("Failed to load mesh for MeshPart '%s'. Make sure mesh exists and try again.", value.Name)

            if not arg2.isServer then
                return false, { str1 }
            end

            error(str1)
        end

        tbl2[value.Name] = var2
    end

    return true, tbl2
end

local function tryReportInflationError(tbl1, assetTypeEnum)
    local failureReasonsAccumulator = FailureReasonsAccumulator.new()
    local assetTypeToAxisThreshold = validateAccurateBoundingBoxFlags.AssetTypeToAxisThresholds[assetTypeEnum]

    for _, value in { "X", "Y", "Z" } do
        local var1 = tbl1[value]
        local var2 = var1.negative.inflationScale + var1.positive.inflationScale
        local var3 = assetTypeToAxisThreshold[value]

        if not (var3 < var2) then
            continue
        end

        local tbl2 = {}
        if var1.positive.inflationScale > var3 * 0.2 then
            table.insert(tbl2, var1.positive.furthestPointWorldSpace)
        end
        if var1.negative.inflationScale > var3 * 0.2 then
            table.insert(tbl2, var1.negative.furthestPointWorldSpace)
        end

        local var4

        if #tbl2 > 0 then
            var4 = " near " .. string.format("{%.4f, %.4f, %.4f}", tbl2[1].X, tbl2[1].Y, tbl2[1].Z)
            if #tbl2 > 1 then
                var4 ..= string.format(", and {%.4f, %.4f, %.4f}", tbl2[2].X, tbl2[2].Y, tbl2[2].Z)
            end
        else
            var4 = ""
        end

        local var5 = var2 * 100
        local var6 = var3 * 100

        failureReasonsAccumulator:updateReasons(false, { string.format(
                "Detected low visibility geometry%s that increases %s bounding box size by %.2f%% (threshold is %.2f%%) in the %s axis. Remove the geometry or increase its size so that it is more visible",
                var4,
                assetTypeEnum.Name,
                var5,
                var6,
                value
            ) })
    end

    return failureReasonsAccumulator
end

local module = {}

local var1 = nil

function module.getBoundsViewsForAssetType(assetTypeEnum)
    if not var1 then
        local function func1() -- Luacid: Inlined by compiler; 4 call sites recovered
            local result = ({})
            for _, viewId in bodyAssetMasksRenderer.viewIds do
                result[viewId] = true
            end
            return result
        end

        local tbl1 = func1()
        tbl1[bodyAssetMasksRenderer.viewIds.Left] = false
        tbl1[bodyAssetMasksRenderer.viewIds.Bottom] = false
        local tbl2 = func1()
        tbl2[bodyAssetMasksRenderer.viewIds.Right] = false
        tbl2[bodyAssetMasksRenderer.viewIds.Bottom] = false
        local tbl3 = func1()
        tbl3[bodyAssetMasksRenderer.viewIds.Left] = false
        tbl3[bodyAssetMasksRenderer.viewIds.Bottom] = false
        local tbl4 = func1()
        tbl4[bodyAssetMasksRenderer.viewIds.Right] = false
        tbl4[bodyAssetMasksRenderer.viewIds.Bottom] = false

        var1 = {
            [Enum.AssetType.DynamicHead] = nil,
            [Enum.AssetType.Torso] = nil,
            [Enum.AssetType.LeftArm] = tbl1,
            [Enum.AssetType.RightArm] = tbl2,
            [Enum.AssetType.LeftLeg] = tbl3,
            [Enum.AssetType.RightLeg] = tbl4
        }
    end

    return var1[assetTypeEnum]
end

function module.validate(arg1, arg2, arg3)
    local assetTypeEnum = arg3.assetTypeEnum
    assert(assetTypeEnum)

    local function findMeshHandle(str1: string)
        if assetTypeEnum == Enum.AssetType.DynamicHead then
            return arg1
        end
        return (arg1:FindFirstChild(str1))
    end

    local boundsViewsForAssetType = module.getBoundsViewsForAssetType(assetTypeEnum)
    local tbl1 = ({})
    if boundsViewsForAssetType then
        for value, value2 in boundsViewsForAssetType do
            if value2 then
                assert(arg2.bodyAssetMasks[value])
                local bodyAssetMask = arg2.bodyAssetMasks[value]
                tbl1[value] = bodyAssetMask
            end
        end
    else
        tbl1 = arg2.bodyAssetMasks
    end

    local tbl2 = {}
    if assetTypeEnum == Enum.AssetType.DynamicHead and validateAccurateBoundingBoxFlags.neckAttachmentCrop() then
        local headNeckAttachmentMeshLocalPosition = getHeadNeckAttachmentMeshLocalPosition(arg1)

        if headNeckAttachmentMeshLocalPosition then
            local var2 = validateAccurateBoundingBoxFlags.neckAttachmentCropMargin()
            local tbl3 = ({})
            for value, value2 in tbl1 do
                if value ~= bodyAssetMasksRenderer.viewIds.Top and value ~= bodyAssetMasksRenderer.viewIds.Bottom then
                    local var3 = projectMeshLocalPointToImageRow(headNeckAttachmentMeshLocalPosition, value2)
                    local mask = value2.mask
                    local var4 = var3 + var2 * (mask.Size.Y - 1) / 2

                    local editableImage = cloneMaskZeroedBelowRow(mask, var4)
                    table.insert(tbl2, editableImage)

                    local tbl4 = {
                        mask = editableImage,
                        view = value2.view,
                        viewSpaceBounds = value2.viewSpaceBounds,
                        viewId = value2.viewId
                    }
                    tbl3[value] = tbl4
                else
                    tbl3[value] = value2
                end
            end
            tbl1 = tbl3
        end
    end

    local var2, var3 = (function()
        local bool1, var2 = calculateValidBounds(tbl1, arg3)

        if not bool1 then
            return false, var2
        end

        local assetMeshesValidationSpaceTransforms = AssetCalculator.getAssetMeshesValidationSpaceTransforms(arg1, arg3)

        local bool2, var3 = getBodyPartAssetEditableMeshes(arg1, arg3)
        if not bool2 then
            return false, var3
        end

        local bool3, var4 = getHighestInflatingPointInEachAxis(var2, assetMeshesValidationSpaceTransforms, var3, findMeshHandle, arg3)

        if not bool3 then
            return false, var4
        end

        local var5 = tryReportInflationError(var4, assetTypeEnum)

        if not var5:getFinalResults() then
            Analytics.reportFailure(Analytics.ErrorType.validateAccurateBoundingBox, nil, arg3)
        end

        return var5:getFinalResults()
    end)()

    for _, value in tbl2 do
        value:Destroy()
    end

    return var2, var3
end

return module
