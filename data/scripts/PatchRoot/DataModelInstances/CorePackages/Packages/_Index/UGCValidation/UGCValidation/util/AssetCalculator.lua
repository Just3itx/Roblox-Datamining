-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T17:11:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local Cryo = require(scriptParentParent.Parent.Cryo)

local ConstantsInterface = require(scriptParentParent.ConstantsInterface)

local _Types = require(scriptParentParent.util.Types)
local canBeNormalized = require(scriptParentParent.util.canBeNormalized)
local getPartNamesInHierarchyOrder = require(scriptParentParent.util.getPartNamesInHierarchyOrder)
local AssetTraversalUtils = require(scriptParentParent.util.AssetTraversalUtils)
local getMeshScales = require(scriptParentParent.util.getMeshScales)
local R15plusUtils = require(scriptParentParent.util.R15plusUtils)
local getAttachmentCFrameInPartSpace = require(scriptParentParent.util.getAttachmentCFrameInPartSpace)

local LowerTorso = {
    root = "LowerTorso",
    children = {
        UpperTorso = {
            children = {
                Head = AssetTraversalUtils.assetHierarchy[Enum.AssetType.DynamicHead],
                LeftUpperArm = AssetTraversalUtils.assetHierarchy[Enum.AssetType.LeftArm],
                RightUpperArm = AssetTraversalUtils.assetHierarchy[Enum.AssetType.RightArm]
            }
        },
        LeftUpperLeg = AssetTraversalUtils.assetHierarchy[Enum.AssetType.LeftLeg],
        RightUpperLeg = AssetTraversalUtils.assetHierarchy[Enum.AssetType.RightLeg]
    }
}

local tbl2 = {
    root = "HumanoidRootPart",
    children = { LowerTorso = LowerTorso }
}

local module = {}

local function calculateCFrame(pos: vector, position: vector)
    local var1 = pos - position

    if not canBeNormalized(var1) then
        return
    end

    local unit = var1.Unit

    local unit2 = unit:Cross(Vector3.new(0, 0, 1)).Unit
    if not canBeNormalized(unit2) then
        unit2 = unit:Cross(if unit.Z < 0 then Vector3.new(0, 1, 0) else vector.create(-0, -1, -0, -0)).Unit
    end
    local unit3 = unit2:Cross(unit).Unit

    return CFrame.fromMatrix(pos, unit2, unit, unit3)
end

local function calculatePartTransformInHierarchy(arg1, str1: string?, cFrame: CFrame, func1: (...any) -> (...any), tbl3)
    local var1 = if tbl3 and tbl3[arg1.Name] then tbl3[arg1.Name] else CFrame.new()

    if not str1 then
        return var1
    end

    local var2 = func1(str1)
    assert(var2)

    local rigAttachmentToParent = ConstantsInterface.getRigAttachmentToParent(nil, arg1.Name)

    local var3 = var2:FindFirstChild(rigAttachmentToParent, R15plusUtils.checkFlagEnabledForAllowHrd())
    assert(var3)

    local var4 = arg1:FindFirstChild(rigAttachmentToParent, R15plusUtils.checkFlagEnabledForAllowHrd())
    assert(var4)

    return cFrame * getAttachmentCFrameInPartSpace(var3) * var1 * getAttachmentCFrameInPartSpace(var4):Inverse()
end

local function calculateHierarchyTransforms(arg1, func1: (...any) -> (...any), tbl3)
    local hierarchyTransforms = {}

    local function calculateAllTransformsInternal(str1: string, str2: string?, arg2, cFrame: CFrame)
        local var1 = func1(str1)
        assert(var1)

        local partTransformInHierarchy = calculatePartTransformInHierarchy(var1, str2, cFrame, func1, tbl3)
        hierarchyTransforms[var1.Name] = partTransformInHierarchy

        if not arg2.children then
            return
        end
        for k, child in arg2.children do
            calculateAllTransformsInternal(k, str1, child, partTransformInHierarchy)
        end
    end

    calculateAllTransformsInternal(arg1.root, nil, arg1, CFrame.new())
    return hierarchyTransforms
end

local function calculateLocalSpaceTransform(cFrame: CFrame, cFrame2: CFrame) -- Luacid: Inlined by compiler; 2 call sites recovered
    local var1 = cFrame.Rotation:Inverse() * cFrame2.Rotation
    local pos = cFrame.Rotation:Inverse() * (cFrame2.Position - cFrame.Position)

    return CFrame.new(pos) * var1
end

local function calculateAssetCFrameFromPartsCFrames(assetType, tbl3) -- Luacid: Inlined by compiler; 1 call site recovered
    local partNamesInHierarchyOrder = getPartNamesInHierarchyOrder(assetType)
    local position = tbl3[partNamesInHierarchyOrder[1]].Position
    local position2 = tbl3[partNamesInHierarchyOrder[3]].Position

    return calculateCFrame(position, position2)
end

local function assertTypesToOrient(assetType) -- Luacid: Inlined by compiler; 2 call sites recovered
    assert(
        assetType == Enum.AssetType.LeftArm
            or assetType == Enum.AssetType.RightArm
            or assetType == Enum.AssetType.LeftLeg
            or assetType == Enum.AssetType.RightLeg
    )
end

local function getAttachmentCFrame(arg1, rigAttachmentToParent: string, cFrame: CFrame) -- Luacid: Inlined by compiler; 4 call sites recovered
    local var1 = arg1:FindFirstChild(rigAttachmentToParent, R15plusUtils.checkFlagEnabledForAllowHrd())
    assert(var1)
    return cFrame * getAttachmentCFrameInPartSpace(var1)
end

function module.calculatePartCFrameFromRigAttachments(assetTypeEnum, arg1, cFrame: CFrame)
    assertTypesToOrient(assetTypeEnum)
    local rigAttachmentToParent = ConstantsInterface.getRigAttachmentToParent(assetTypeEnum, arg1.Name)
    if rigAttachmentToParent == "" then
        return
    end

    local attachmentCFrame = getAttachmentCFrame(arg1, rigAttachmentToParent, cFrame)
    local assetRigChild = AssetTraversalUtils.getAssetRigChild(assetTypeEnum, arg1.Name)
    if assetRigChild then
        local attachmentCFrame2 = getAttachmentCFrame(arg1, ConstantsInterface.getRigAttachmentToParent(assetTypeEnum, assetRigChild), cFrame)

        return calculateCFrame(attachmentCFrame.Position, attachmentCFrame2.Position)
    end
end

function module.calculateStraightenedLimb(assetTypeEnum, tbl3, func1: (...any) -> (...any))
    assertTypesToOrient(assetTypeEnum)
    local var1 = Cryo.Dictionary.join(tbl3)

    local attachmentCFramePosition = nil
    local cFrame = CFrame.new()
    for _, value in getPartNamesInHierarchyOrder(assetTypeEnum) do
        local var2 = func1(value)

        local assetRigChild = AssetTraversalUtils.getAssetRigChild(assetTypeEnum, value)

        local bool1 = assetRigChild == nil
        local cFrame2 = if bool1 then cFrame else module.calculatePartCFrameFromRigAttachments(assetTypeEnum, var2, tbl3[value]) or cFrame
        var1[value] = calculateLocalSpaceTransform(cFrame2, tbl3[value])

        if attachmentCFramePosition then
            local var3 = attachmentCFramePosition - getAttachmentCFrame(var2, ConstantsInterface.getRigAttachmentToParent(assetTypeEnum, value), var1[value]).Position
            var1[value] = CFrame.new(var1[value].Position + var3) * var1[value].Rotation
        end

        if not bool1 then
            attachmentCFramePosition = getAttachmentCFrame(var2, ConstantsInterface.getRigAttachmentToParent(assetTypeEnum, assetRigChild), var1[value]).Position
            cFrame = cFrame2
        end
    end
    return var1
end

function module.calculateAssetCFrame(assetType, arg1)
    local allTransformsForAsset = module.calculateAllTransformsForAsset(assetType, arg1)
    if Enum.AssetType.DynamicHead == assetType then
        return allTransformsForAsset.Head
    elseif Enum.AssetType.Torso == assetType then
        return allTransformsForAsset.LowerTorso
    end

    return calculateAssetCFrameFromPartsCFrames(assetType, allTransformsForAsset)
end

function module.calculateAllTransformsForAsset(assetType, arg1)
    if Enum.AssetType.DynamicHead == assetType then
        return {
            Head = CFrame.new()
        }
    end
    return (calculateHierarchyTransforms(AssetTraversalUtils.assetHierarchy[assetType], function(str1: string) -- name: findMeshHandle
        return (arg1:FindFirstChild(str1))
    end))
end

function module.calculateAllTransformsForFullBody(arg1, tbl3)
    local function findMeshHandle(str1: string)
        return arg1[str1]
    end

    local var1 = if tbl3 then tbl2 else LowerTorso
    return (calculateHierarchyTransforms(var1, findMeshHandle, tbl3))
end

function module.calculatePartsLocalToAsset(assetType, tbl3)
    assert(
        assetType == Enum.AssetType.LeftArm
            or assetType == Enum.AssetType.RightArm
            or assetType == Enum.AssetType.LeftLeg
            or assetType == Enum.AssetType.RightLeg
    )
    local assetCFrameFromPartsCFrames = calculateAssetCFrameFromPartsCFrames(assetType, tbl3)
    local partsLocalToAsset = ({})
    for _, value in getPartNamesInHierarchyOrder(assetType) do
        local var1 = if assetCFrameFromPartsCFrames then calculateLocalSpaceTransform(assetCFrameFromPartsCFrames, tbl3[value]) else tbl3[value]
        partsLocalToAsset[value] = var1
    end

    return partsLocalToAsset
end

function module.getBodyPartsToParents()
    local bodyPartsToParents = ({})

    local function calculateAllTransformsInternal(str1: string, str2: string?, arg1)
        bodyPartsToParents[str1] = str2 or "HumanoidRootPart"

        if not arg1.children then
            return
        end
        for k, child in arg1.children do
            calculateAllTransformsInternal(k, str1, child)
        end
    end

    local root = LowerTorso.root
    local tbl3 = LowerTorso
    bodyPartsToParents[root] = "HumanoidRootPart"

    if not tbl3.children then
        return bodyPartsToParents
    end
    for k, child in tbl3.children do
        calculateAllTransformsInternal(k, root, child)
    end

    return bodyPartsToParents
end

function module.getAssetMeshesValidationSpaceTransforms(arg1, arg2)
    local assetTypeEnum = arg2.assetTypeEnum
    assert(assetTypeEnum)

    local tbl3 = {}
    if assetTypeEnum == Enum.AssetType.DynamicHead then
        table.insert(tbl3, arg1.Name)
    else
        for _, child in arg1:GetChildren() do
            if child:IsA("MeshPart") then
                table.insert(tbl3, child.Name)
            end
        end
    end

    local allTransformsForAsset = module.calculateAllTransformsForAsset(assetTypeEnum, arg1)

    local function findMeshHandle(str1: string)
        if assetTypeEnum == Enum.AssetType.DynamicHead then
            return arg1
        end
        return (arg1:FindFirstChild(str1))
    end

    if assetTypeEnum ~= Enum.AssetType.DynamicHead and assetTypeEnum ~= Enum.AssetType.Torso then
        for value, value2 in (module.calculateStraightenedLimb(assetTypeEnum, allTransformsForAsset, findMeshHandle)) do
            allTransformsForAsset[value] = value2
        end
    end

    local meshScales = getMeshScales(tbl3, findMeshHandle, arg2)

    local assetMeshesValidationSpaceTransforms = ({})
    for _, value in tbl3 do
        local tbl4 = {
            CFrame = allTransformsForAsset[value],
            scale = meshScales[value]
        }
        assetMeshesValidationSpaceTransforms[value] = tbl4
    end

    return assetMeshesValidationSpaceTransforms
end

return module
