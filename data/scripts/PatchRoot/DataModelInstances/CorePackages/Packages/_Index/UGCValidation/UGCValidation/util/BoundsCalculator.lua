-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T17:11:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local Constants = require(scriptParentParent.Constants)
local _Types = require(scriptParentParent.util.Types)
local ConstantsInterface = require(scriptParentParent.ConstantsInterface)
local AssetCalculator = require(scriptParentParent.util.AssetCalculator)
local getPartNamesInHierarchyOrder = require(scriptParentParent.util.getPartNamesInHierarchyOrder)
local getMeshVerts = require(scriptParentParent.util.getMeshVerts)
local getMeshInfo = require(scriptParentParent.util.getMeshInfo)
local BoundsDataUtils = require(scriptParentParent.util.BoundsDataUtils)
local getExpectedPartSize = require(scriptParentParent.util.getExpectedPartSize)
local R15plusUtils = require(scriptParentParent.util.R15plusUtils)
local getAttachmentCFrameInPartSpace = require(scriptParentParent.util.getAttachmentCFrameInPartSpace)

local module = {}

local function orientSingleAssetToWorldAxes(tbl1, assetType, func1: (...any) -> (...any))
    if assetType ~= Enum.AssetType.LeftArm
        and assetType ~= Enum.AssetType.RightArm
        and assetType ~= Enum.AssetType.LeftLeg
        and assetType ~= Enum.AssetType.RightLeg
    then
        return
    end

    for value, value2 in (AssetCalculator.calculateStraightenedLimb(assetType, tbl1, func1)) do
        tbl1[value] = value2
    end
end

local function orientFullBodyArmsLegsToWorldAxes(allTransformsForFullBody, func1: (...any) -> (...any))
    local function orientAndMoveParts(assetType: Enum.AssetType, str1: string)
        orientSingleAssetToWorldAxes(allTransformsForFullBody, assetType, func1)

        local partNamesInHierarchyOrder = getPartNamesInHierarchyOrder(assetType)
        local var1 = func1(partNamesInHierarchyOrder[1])

        local rigAttachmentToParent = ConstantsInterface.getRigAttachmentToParent(assetType, var1.Name)

        local var2 = var1:FindFirstChild(rigAttachmentToParent, R15plusUtils.checkFlagEnabledForAllowHrd())
        assert(var2)
        local var3 = allTransformsForFullBody[var1.Name] * getAttachmentCFrameInPartSpace(var2)

        local var4 = func1(str1)
        assert(var4)

        local var5 = var4:FindFirstChild(rigAttachmentToParent, R15plusUtils.checkFlagEnabledForAllowHrd())
        assert(var5)
        local var6 = (allTransformsForFullBody[var4.Name] * getAttachmentCFrameInPartSpace(var5)).Position - var3.Position

        for _, value in partNamesInHierarchyOrder do
            allTransformsForFullBody[value] = CFrame.new(allTransformsForFullBody[value].Position + var6) * allTransformsForFullBody[value].Rotation
        end
    end

    orientAndMoveParts(Enum.AssetType.LeftArm, "UpperTorso")
    orientAndMoveParts(Enum.AssetType.RightArm, "UpperTorso")
    orientAndMoveParts(Enum.AssetType.LeftLeg, "LowerTorso")
    orientAndMoveParts(Enum.AssetType.RightLeg, "LowerTorso")
end

local function calculateBoundsDataForPart(arg1, arg2, cFrame: CFrame, arg3, arg4)
    assert(arg1 ~= nil ~= (arg4 ~= nil))

    local meshSize = arg2.MeshSize

    local var1 = getExpectedPartSize(arg2, arg3) / meshSize

    local var2 = nil

    if arg4 then
        if arg4.meshData and arg4.meshData[arg2.MeshId] then
            var2 = arg4.meshData[arg2.MeshId].verts or var2
        end

        if not var2 then
            return false, { "Verts not found in data cache" }
        end
    end

    if not var2 then
        local var3, var4
        var3, var4, var2 = getMeshVerts(arg1, arg3)
        if not var3 then
            return var3, var4
        end
    end

    local tbl1 = {}
    for _, value in var2 do
        BoundsDataUtils.expandMeshBounds(tbl1, cFrame:PointToWorldSpace(value * var1))
    end

    for _, value in ConstantsInterface.getAttachments(nil, arg2.Name) do
        if string.match(value, "RigAttachment$") ~= nil then
            local var3 = arg2:FindFirstChild(value, R15plusUtils.checkFlagEnabledForAllowHrd())
            assert(var3)

            local var4 = cFrame * getAttachmentCFrameInPartSpace(var3)
            BoundsDataUtils.expandRigAttachmentBounds(tbl1, var4.Position)
        end
    end
    BoundsDataUtils.setOverallBounds(tbl1)
    return true, nil, tbl1
end

local function buildValidationContextFromRenderMeshes(arg1, assetTypeEnum, tbl1)
    local editableMeshes = ({})
    local descendants = arg1:GetDescendants()
    table.insert(descendants, arg1)
    for _, descendant in descendants do
        local var1 = tbl1[descendant.Name]
        if not (var1 and var1.editable) then
            continue
        end
        local tbl3 = {
            MeshId = {
                instance = var1.editable,
                created = var1.createdInValidation or false
            }
        }
        editableMeshes[descendant] = tbl3
    end

    return { assetTypeEnum = assetTypeEnum, editableMeshes = editableMeshes }
end

local function calculateAllPartsBoundsData(tbl1, func1: (...any) -> (...any), arg1, arg2)
    local tbl2 = ({})
    for value, value2 in tbl1 do
        local var1 = func1(value)
        local var2

        if arg2 then
            var2 = nil
        else
            local var3, var4
            var3, var4, var2 = getMeshInfo(var1, Constants.MESH_CONTENT_TYPE.RENDER_MESH, arg1)
            if not var3 then
                return var3, var4
            end
        end

        local var3, var4, var5 = calculateBoundsDataForPart(var2, var1, value2, arg1, arg2)
        if not var3 then
            return var3, var4
        end
        tbl2[value] = var5
    end
    return true, nil, tbl2
end

local function calculateTotalBoundsForAsset(tbl1, func1: (...any) -> (...any), arg1)
    local var1, var2, var3 = calculateAllPartsBoundsData(tbl1, func1, arg1)
    if not var1 then
        return var1, var2
    end

    local tbl2 = {}
    for _, value in var3 do
        tbl2 = BoundsDataUtils.combineBounds(tbl2, value)
    end
    return true, nil, tbl2
end

local function calculatePartBounds(arg1, arg2)
    local tbl1 = {
        [arg1.Name] = CFrame.new()
    }

    local var1, var2, var3 = calculateTotalBoundsForAsset(tbl1, function(name: string) -- name: findMeshHandle
        assert(name == arg1.Name)
        return arg1
    end, arg2)
    if not var1 then
        return var1, var2
    end
    return true, nil, var3
end

function module.calculateAssetBounds(arg1, arg2)
    local assetTypeEnum = arg2.assetTypeEnum
    assert(assetTypeEnum)

    if assetTypeEnum == Enum.AssetType.DynamicHead then
        return calculatePartBounds(arg1, arg2)
    end

    local allTransformsForAsset = AssetCalculator.calculateAllTransformsForAsset(assetTypeEnum, arg1)

    local function findMeshHandle(str1: string)
        return (arg1:FindFirstChild(str1))
    end

    orientSingleAssetToWorldAxes(allTransformsForAsset, assetTypeEnum, findMeshHandle)

    local var1, var2, var3 = calculateTotalBoundsForAsset(allTransformsForAsset, findMeshHandle, arg2)
    if not var1 then
        return var1, var2
    end
    return true, nil, var3
end

function module.calculateIndividualAssetPartsData(arg1, arg2)
    local assetTypeEnum = arg2.assetTypeEnum
    assert(assetTypeEnum)

    local allTransformsForAsset = AssetCalculator.calculateAllTransformsForAsset(assetTypeEnum, arg1)

    local function findMeshHandle(str1: string)
        if assetTypeEnum == Enum.AssetType.DynamicHead then
            return arg1
        end
        return (arg1:FindFirstChild(str1))
    end

    orientSingleAssetToWorldAxes(allTransformsForAsset, assetTypeEnum, findMeshHandle)

    local var1, var2, var3 = calculateAllPartsBoundsData(allTransformsForAsset, findMeshHandle, arg2)
    if not var1 then
        return var1, var2
    end

    local tbl1 = ({})
    for value, boundsData in var3 do
        local tbl2 = {
            boundsData = boundsData,
            cframe = allTransformsForAsset[value]
        }
        tbl1[value] = tbl2
    end
    return true, nil, tbl1
end

function module.calculateIndividualFullBodyPartsData(arg1, arg2, arg3, bool1: boolean)
    local function findMeshHandle(str1: string)
        return arg1[str1]
    end

    local allTransformsForFullBody = AssetCalculator.calculateAllTransformsForFullBody(arg1)
    if bool1 then
        orientFullBodyArmsLegsToWorldAxes(allTransformsForFullBody, findMeshHandle)
    end

    local var1, var2, var3 = calculateAllPartsBoundsData(allTransformsForFullBody, findMeshHandle, arg2, arg3)
    if not var1 then
        return var1, var2
    end

    local tbl1 = ({})
    for value, boundsData in var3 do
        local tbl2 = {
            boundsData = boundsData,
            cframe = allTransformsForFullBody[value]
        }
        tbl1[value] = tbl2
    end
    return true, nil, tbl1
end

function module.calculateFullBodyBounds(arg1, arg2)
    local function findMeshHandle(str1: string)
        return arg1[str1]
    end

    local allTransformsForFullBody = AssetCalculator.calculateAllTransformsForFullBody(arg1)
    orientFullBodyArmsLegsToWorldAxes(allTransformsForFullBody, findMeshHandle)

    local var1, var2, var3 = calculateTotalBoundsForAsset(allTransformsForFullBody, findMeshHandle, arg2)
    if not var1 then
        return var1, var2
    end
    return true, nil, var3
end

function module.calculateAssetBoundsFromData(arg1, assetTypeEnum, tbl1)
    local validationContextFromRenderMeshes = buildValidationContextFromRenderMeshes(arg1, assetTypeEnum, tbl1)
    return module.calculateAssetBounds(arg1, validationContextFromRenderMeshes)
end

function module.calculateFullBodyBoundsFromData(arg1, tbl1)
    local var1 = next(arg1)
    if not var1 then
        return false, { "No body parts provided" }
    end
    local parent = arg1[var1].Parent
    local validationContextFromRenderMeshes = buildValidationContextFromRenderMeshes(parent, nil, tbl1)
    return module.calculateFullBodyBounds(arg1, validationContextFromRenderMeshes)
end

function module.calculateIndividualAssetPartsDataFromData(arg1, assetTypeEnum, tbl1)
    local validationContextFromRenderMeshes = buildValidationContextFromRenderMeshes(arg1, assetTypeEnum, tbl1)
    return module.calculateIndividualAssetPartsData(arg1, validationContextFromRenderMeshes)
end

function module.calculateIndividualFullBodyPartsDataFromData(arg1, tbl1)
    local var1 = next(arg1)
    if not var1 then
        return false, { "No body parts provided" }
    end
    local parent = arg1[var1].Parent
    local validationContextFromRenderMeshes = buildValidationContextFromRenderMeshes(parent, nil, tbl1)
    return module.calculateIndividualFullBodyPartsData(arg1, validationContextFromRenderMeshes, nil, true)
end

return module
