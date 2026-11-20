-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T17:41:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UGCValidationService = game:GetService("UGCValidationService")

local scriptParentParent = script.Parent.Parent

local Analytics = require(scriptParentParent.Analytics)
local Constants = require(scriptParentParent.Constants)
local _Types = require(scriptParentParent.util.Types)
local validateSkinningTransfer = require(scriptParentParent.validation.validateSkinningTransfer)

local FailureReasonsAccumulator = require(scriptParentParent.util.FailureReasonsAccumulator)
local ParseContentIds = require(scriptParentParent.util.ParseContentIds)
local getMeshMinMax = require(scriptParentParent.util.getMeshMinMax)
local getEditableMeshFromContext = require(scriptParentParent.util.getEditableMeshFromContext)

local getEngineFeatureEngineUGCValidationConsolidateAccessorySkinning = require(scriptParentParent.flags.getEngineFeatureEngineUGCValidationConsolidateAccessorySkinning)

local function validateIsSkinned(instance, isServer: boolean?, allowEditableInstances: boolean?, arg1)
    local var1 = instance:GetAttribute(Constants.AlternateMeshIdAttributeName)
    if not instance.HasSkinnedMesh and (var1 == nil or var1 == "" or not allowEditableInstances) then
        Analytics.reportFailure(Analytics.ErrorType.validateDescendantMeshMetrics_NoSkinningInfo, nil, arg1)

        return false, { `Missing skinning data for {instance.Name}.MeshId. You need to skin your model.` }
    end

    local success, result = pcall(function(): boolean
        local var2, editableMesh = getEditableMeshFromContext(instance, "MeshId", arg1)
        if not var2 then
            error("Failed to retrieve MeshContent")
        end
        return UGCValidationService:ValidateSkinnedEditableMesh(editableMesh)
    end)

    if not success then
        if isServer then
            error("Failed to retrieve mesh data to validate skinned mesh")
        end
        Analytics.reportFailure(Analytics.ErrorType.validateDescendantMeshMetrics_FailedToLoadMesh, nil, arg1)

        return false, { "Failed to retrieve mesh data to validate skinned mesh" }
    end

    if result then
        return true
    end

    local str1 = `Detected mismatch between model and skinned data for {instance.Name}. You need to re-skin your model to fix this issue.`
    if isServer then
        error(str1)
    end
    Analytics.reportFailure(Analytics.ErrorType.validateDescendantMeshMetrics_HasSkinnedMeshMismatch, nil, arg1)

    return false, { str1 }
end

local function validateMeshIsAtOrigin(tbl1: {contentId: number, context: number, fieldName: number, fullName: number}, vec1: vector?, vec2: vector?, arg1)
    if not ((vec1 + (vec2 - vec1) / 2).Magnitude > 0.001) then
        return true
    end

    Analytics.reportFailure(Analytics.ErrorType.validateDescendantMeshMetrics_TooFarFromOrigin, nil, arg1)

    return false, { string.format(
            "Bounds for the mesh '%s' are not centered at the origin. The max allowed distance is '%f'",
            tbl1.fullName,
            0.001
        ) }
end

local function validateDescendantMeshMetrics(arg1, arg2)
    local isServer = arg2.isServer

    assert(arg2.assetTypeEnum ~= nil, "assetTypeEnum required in validationContext for validateDescendantMeshMetrics")

    local allowEditableInstances = arg2.allowEditableInstances

    local failureReasonsAccumulator = FailureReasonsAccumulator.new()

    for _, value in (ParseContentIds.parse(arg1, Constants.MESH_CONTENT_ID_FIELDS, arg2)) do
        local tbl1 = {
            fullName = value.instance:GetFullName(),
            fieldName = value.fieldName,
            contentId = value.instance[value.fieldName],
            context = value.instance.Name
        }

        local var1, editableMesh = getEditableMeshFromContext(value.instance, value.fieldName, arg2)
        if not var1 then
            return false, { string.format("Failed to load mesh for '%s'. Make sure mesh exists and try again.", value.instance.Name) }
        end

        tbl1.editableMesh = editableMesh

        if value.instance.ClassName == "MeshPart" then
            assert(value.fieldName == "MeshId")

            local var3, var4, var5, var6 = getMeshMinMax(tbl1, arg2)
            if not var3 then
                failureReasonsAccumulator:updateReasons(false, var4)
            end

            if var3 then
                local now = tick()
                failureReasonsAccumulator:updateReasons(validateMeshIsAtOrigin(tbl1, var5, var6, arg2))

                Analytics.recordScriptTime("validateMeshIsAtOrigin", now, arg2)
            end

            local now = tick()
            failureReasonsAccumulator:updateReasons(validateIsSkinned(value.instance, isServer, allowEditableInstances, arg2))

            Analytics.recordScriptTime("validateIsSkinned", now, arg2)

            if not getEngineFeatureEngineUGCValidationConsolidateAccessorySkinning() then
                failureReasonsAccumulator:updateReasons(validateSkinningTransfer(value.instance, arg2))
            end
        elseif value.instance.ClassName == "WrapTarget" then
            assert(value.fieldName == "CageMeshId")
            tbl1.fullName ..= "OuterCage"
        end
    end

    return failureReasonsAccumulator:getFinalResults()
end

return validateDescendantMeshMetrics
