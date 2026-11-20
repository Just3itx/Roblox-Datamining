-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T17:50:39Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent

local Constants = require(scriptParentParentParent.Constants)
local _Types = require(scriptParentParentParent.util.Types)
local ValidationEnums = require(scriptParentParentParent.validationSystem.ValidationEnums)
local ErrorSourceStrings = require(scriptParentParentParent.validationSystem.ErrorSourceStrings)
local BoundsCalculator = require(scriptParentParentParent.util.BoundsCalculator)

local module = {
    categories = { ValidationEnums.UploadCategory.TORSO_AND_LIMBS, ValidationEnums.UploadCategory.DYNAMIC_HEAD, ValidationEnums.UploadCategory.FULL_BODY },
    requiredData = { ValidationEnums.SharedDataMember.rootInstance, ValidationEnums.SharedDataMember.uploadEnum },
    conditionalData = { ValidationEnums.SharedDataMember.renderMeshesData },
    expectedFailures = {}
}
local function getScaleTypeFromInstance(arg1) -- Luacid: Inlined by compiler; 2 call sites recovered
    local avatarPartScaleType = arg1:FindFirstChild("AvatarPartScaleType")
    return if avatarPartScaleType and Constants.AvatarPartScaleTypes[avatarPartScaleType.Value] then avatarPartScaleType.Value else nil
end

local function getConsistentScaleType(rootInstance, assetType, arg1)
    local var1 = Constants.ASSET_TYPE_INFO[assetType]
    local var2 = nil

    if Enum.AssetType.DynamicHead == assetType then
        return getScaleTypeFromInstance(rootInstance)
    end

    for k in pairs(var1.subParts) do
        local var3 = rootInstance:FindFirstChild(k)
        if not var3 then
            continue
        end

        local scaleTypeFromInstance = getScaleTypeFromInstance(var3)

        if not scaleTypeFromInstance then
            continue
        end

        if var2 == nil then
            var2 = scaleTypeFromInstance
        elseif var2 ~= scaleTypeFromInstance then
            arg1:fail(ErrorSourceStrings.Keys.AssetBounds_InconsistentScaleType, nil, rootInstance)
            return nil
        end
    end
    return var2
end

local function validateMinBounds(minSize: vector, assetName: string, arg1, arg2, rootInstance)
    local var1 = arg1.maxMeshCorner - arg1.minMeshCorner
    for _, axis in { "X", "Y", "Z" } do
        local var2 = var1[axis]
        local var3 = minSize[axis]
        if not (var2 < var3) then
            continue
        end

        local assetBoundsTooSmall = ErrorSourceStrings.Keys.AssetBounds_TooSmall
        local tbl1 = {
            assetName = assetName,
            axis = axis,
            currentSize = string.format("%.2f", var2),
            minSize = string.format("%.2f", var3)
        }
        arg2:fail(assetBoundsTooSmall, tbl1, rootInstance)
    end
end

local function validateMaxBounds(maxSize: vector, assetName: string, arg1, arg2, rootInstance)
    local var1 = arg1.maxOverall - arg1.minOverall
    for _, axis in { "X", "Y", "Z" } do
        local var2 = var1[axis]
        local var3 = maxSize[axis]
        if not (var3 < var2) then
            continue
        end

        local assetBoundsTooLarge = ErrorSourceStrings.Keys.AssetBounds_TooLarge
        local tbl1 = {
            assetName = assetName,
            axis = axis,
            currentSize = string.format("%.2f", var2),
            maxSize = string.format("%.2f", var3)
        }
        arg2:fail(assetBoundsTooLarge, tbl1, rootInstance)
    end
end

local function createAllBodyPartsFromRootInstance(rootInstance)
    local allBodyPartsFromRootInstance = {}
    for _, child in rootInstance:GetChildren() do
        if child:IsA("MeshPart") then
            allBodyPartsFromRootInstance[child.Name] = child
        end
    end
    return allBodyPartsFromRootInstance
end

local function getFullBodyConsistentScaleType(allBodyPartsFromRootInstance, arg1, rootInstance)
    local var1 = nil
    for _, value in allBodyPartsFromRootInstance do
        local avatarPartScaleType = value:FindFirstChild("AvatarPartScaleType")
        if not avatarPartScaleType then
            continue
        end

        if not Constants.AvatarPartScaleTypes[avatarPartScaleType.Value] then
            arg1:fail(ErrorSourceStrings.Keys.ScaleTypeInvalid, { ParentName = value.Name }, value)

            return nil
        end
        local avatarPartScaleTypeValue = avatarPartScaleType.Value
        if var1 == nil then
            var1 = avatarPartScaleTypeValue
        elseif var1 ~= avatarPartScaleTypeValue then
            arg1:fail(ErrorSourceStrings.Keys.AssetBounds_InconsistentScaleType, nil, rootInstance)
            return nil
        end
    end
    return var1
end

function module.run(arg1, arg2)
    local rootInstance = arg2.rootInstance
    local renderMeshesData = arg2.renderMeshesData
    if arg2.uploadCategory ~= ValidationEnums.UploadCategory.FULL_BODY then
        local assetType = arg2.uploadEnum.assetType

        local consistentScaleType = getConsistentScaleType(rootInstance, assetType, arg1)
        if not consistentScaleType then
            return
        end

        local var1 = Constants.ASSET_TYPE_INFO[assetType]
        if not var1 or not var1.bounds or not var1.bounds[consistentScaleType] or not renderMeshesData then
            return
        end

        local var2, _, var3 = BoundsCalculator.calculateAssetBoundsFromData(rootInstance, assetType, renderMeshesData)
        if not var2 then
            arg1:fetchError("Failed to calculate asset bounds for " .. assetType.Name)
            return
        end

        local assetTypeName = assetType.Name
        validateMinBounds(var1.bounds[consistentScaleType].minSize, assetTypeName, var3, arg1, rootInstance)
        validateMaxBounds(var1.bounds[consistentScaleType].maxSize, assetTypeName, var3, arg1, rootInstance)
        return
    end

    if not renderMeshesData then
        return
    end

    local allBodyPartsFromRootInstance = createAllBodyPartsFromRootInstance(rootInstance)
    if not next(allBodyPartsFromRootInstance) then
        return
    end

    local fullBodyConsistentScaleType = getFullBodyConsistentScaleType(allBodyPartsFromRootInstance, arg1, rootInstance)
    if not fullBodyConsistentScaleType then
        return
    end

    local var1 = Constants.FULL_BODY_BOUNDS[fullBodyConsistentScaleType]
    if not var1 then
        return
    end

    local var2, _, var3 = BoundsCalculator.calculateFullBodyBoundsFromData(allBodyPartsFromRootInstance, renderMeshesData)
    if not var2 then
        arg1:fetchError("Failed to calculate full body bounds")
        return
    end

    validateMinBounds(var1.minSize, "Full body", var3, arg1, rootInstance)
    validateMaxBounds(var1.maxSize, "Full body", var3, arg1, rootInstance)
end

return module
