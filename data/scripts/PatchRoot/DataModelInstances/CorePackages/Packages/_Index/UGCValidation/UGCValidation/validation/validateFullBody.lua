-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T17:41:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local Analytics = require(scriptParentParent.Analytics)
local Constants = require(scriptParentParent.Constants)
local ConstantsInterface = require(scriptParentParent.ConstantsInterface)

local _Types = require(scriptParentParent.util.Types)
local FailureReasonsAccumulator = require(scriptParentParent.util.FailureReasonsAccumulator)
local validateWithSchema = require(scriptParentParent.util.validateWithSchema)

local validateSingleInstance = require(scriptParentParent.validation.validateSingleInstance)

local createDynamicHeadMeshPartSchema = require(scriptParentParent.util.createDynamicHeadMeshPartSchema)
local createLimbsAndTorsoSchema = require(scriptParentParent.util.createLimbsAndTorsoSchema)
local resetPhysicsData = require(scriptParentParent.util.resetPhysicsData)
local ParseContentIds = require(scriptParentParent.util.ParseContentIds)
local R15plusUtils = require(scriptParentParent.util.R15plusUtils)
local getFFlagDebugAllowHRDUploadOnBundleBackend = require(scriptParentParent.flags.getFFlagDebugAllowHRDUploadOnBundleBackend)

local function getInstance(allSelectedInstances, name: string) -- Luacid: Inlined by compiler; 2 call sites recovered
    for _, value in allSelectedInstances do
        if value.Name == name then
            return value
        end
    end
    return nil
end

local function validateAllAssetsWithSchema(fullBodyData, tbl1, arg1)
    for _, value in fullBodyData do
        if Enum.AssetType.DynamicHead == value.assetTypeEnum then
            if not validateSingleInstance(value.allSelectedInstances, arg1) then
                return false
            end
            if not validateWithSchema(createDynamicHeadMeshPartSchema(arg1), value.allSelectedInstances[1], arg1).success then
                return false
            end
        else
            for _, value2 in tbl1 do
                local instance = getInstance(value.allSelectedInstances, value2)
                if not instance then
                    return false
                end
                if not validateWithSchema(createLimbsAndTorsoSchema(value.assetTypeEnum, value2, arg1), instance, arg1).success then
                    return false
                end
            end
        end
    end
    return true
end

local function validateCorrectAssetTypesExist(fullBodyData)
    local tbl1 = {}
    local num1 = #ConstantsInterface.getBodyPartAssets()

    local num2 = 0
    for _, value in fullBodyData do
        if not ConstantsInterface.isBodyPart(value.assetTypeEnum) then
            return false
        end
        if tbl1[value.assetTypeEnum] then
            return false
        end
        tbl1[value.assetTypeEnum] = true
        num2 += 1
    end
    return num2 == num1
end

local function createAllBodyPartsTable(name: string, fullBodyData)
    local allBodyPartsTable = {}
    for _, value in fullBodyData do
        if Enum.AssetType.DynamicHead == value.assetTypeEnum then
            allBodyPartsTable[value.allSelectedInstances[1].Name] = value.allSelectedInstances[1]
        else
            for _, child in getInstance(value.allSelectedInstances, name):GetChildren() do
                allBodyPartsTable[child.Name] = child
            end
        end
    end
    return allBodyPartsTable
end

local function validateMeshIds(fullBodyData, arg1)
    local tbl1 = {
        MeshPart = { "MeshId" }
    }

    local tbl2 = {
        MeshPart = { MeshId = true }
    }

    for _, value in fullBodyData do
        for _, value2 in value.allSelectedInstances do
            if not ParseContentIds.parseWithErrorCheck({}, {}, value2, tbl1, tbl2, arg1) then
                Analytics.reportFailure(Analytics.ErrorType.validateFullBody_MeshIdsMissing, nil, arg1)
                return false, { "Unable to run full body validation due to previous errors detected while processing individual body parts" }
            end
        end
    end

    return true
end

local function validateInstanceHierarchy(fullBodyData, tbl1, arg1)
    local isServer = if arg1 then arg1.isServer else nil

    if not validateCorrectAssetTypesExist(fullBodyData) then
        Analytics.reportFailure(Analytics.ErrorType.validateFullBody_IncorrectAssetTypeSet, nil, arg1)
        if isServer then
            error(
                "Full body check did not receive the correct set of body part Asset Types (i.e. Head, Torso, LeftArm, RightArm, LeftLeg, RightLeg). Make sure the body model is valid and try again."
            )
        end

        return false, { "Full body check did not receive the correct set of body part Asset Types (i.e. Head, Torso, LeftArm, RightArm, LeftLeg, RightLeg). Make sure the body model is valid and try again." }
    elseif not validateAllAssetsWithSchema(fullBodyData, tbl1, arg1) then
        Analytics.reportFailure(Analytics.ErrorType.validateFullBody_InstancesMissing, nil, arg1)

        return false, { "Unable to run full body validation due to previous errors detected while processing individual body parts." }
    else
        local var1, var2 = validateMeshIds(fullBodyData, arg1)
        if not var1 then
            return false, var2
        end

        return true
    end
end

local function resetAllPhysicsData(arg1)
    for _, value in arg1.fullBodyData do
        local var1, var2 = resetPhysicsData(value.allSelectedInstances, arg1)
        if not var1 then
            return false, { var2 }
        end
    end

    return true
end

local function validateFullBody(arg1)
    assert(arg1.fullBodyData ~= nil, "fullBodyData required in validationContext for validateFullBody")
    local fullBodyData = arg1.fullBodyData
    local requireAllFolders = arg1.requireAllFolders
    if getFFlagDebugAllowHRDUploadOnBundleBackend() then
        R15plusUtils.setIsBackendBundleUpload(arg1.isBackendBundleUpload == true)
    end

    local tbl1 = { Constants.FOLDER_NAMES.R15ArtistIntent }

    if requireAllFolders then
        table.insert(tbl1, Constants.FOLDER_NAMES.R15Fixed)
    end

    local var1, var2 = validateInstanceHierarchy(fullBodyData, tbl1, arg1)
    if not var1 then
        if getFFlagDebugAllowHRDUploadOnBundleBackend() then
            R15plusUtils.setIsBackendBundleUpload(false)
        end
        return false, var2
    end

    local var3, var4 = resetAllPhysicsData(arg1)
    if not var3 then
        if getFFlagDebugAllowHRDUploadOnBundleBackend() then
            R15plusUtils.setIsBackendBundleUpload(false)
        end
        return false, var4
    end

    local failureReasonsAccumulator = FailureReasonsAccumulator.new()

    for _, value in tbl1 do
        assert((createAllBodyPartsTable(value, fullBodyData)))
    end

    if getFFlagDebugAllowHRDUploadOnBundleBackend() then
        R15plusUtils.setIsBackendBundleUpload(false)
    end

    return failureReasonsAccumulator:getFinalResults()
end

return validateFullBody
