-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T17:50:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent

local Constants = require(scriptParentParentParent.Constants)
local _Types = require(scriptParentParentParent.util.Types)
local ValidationEnums = require(scriptParentParentParent.validationSystem.ValidationEnums)
local ErrorSourceStrings = require(scriptParentParentParent.validationSystem.ErrorSourceStrings)
local getMeshMinMax = require(scriptParentParentParent.util.getMeshMinMax)
local getMeshSize = require(scriptParentParentParent.util.getMeshSize)
local getEditableMeshFromContext = require(scriptParentParentParent.util.getEditableMeshFromContext)
local getExpectedPartSize = require(scriptParentParentParent.util.getExpectedPartSize)
local getMeshInfo = require(scriptParentParentParent.util.getMeshInfo)

local module = {
    categories = { ValidationEnums.UploadCategory.TORSO_AND_LIMBS, ValidationEnums.UploadCategory.DYNAMIC_HEAD },
    requiredData = { ValidationEnums.SharedDataMember.rootInstance, ValidationEnums.SharedDataMember.uploadEnum, ValidationEnums.SharedDataMember.consumerConfig },
    conditionalData = { ValidationEnums.SharedDataMember.renderMeshesData, ValidationEnums.SharedDataMember.outerCagesData },
    expectedFailures = {}
}
local function calculateMeshSizeForPart(arg1, tbl1: {assetTypeEnum: any, bypassFlags: {skipPhysicsDataReset: boolean}, editableMeshes: {[any]: any}, isServer: boolean})
    local tbl2 = {
        fullName = arg1:GetFullName(),
        fieldName = "MeshId",
        contentId = arg1.MeshId,
        context = arg1.Name
    }

    local var1, editableMesh = getEditableMeshFromContext(arg1, "MeshId", tbl1)
    if not var1 then
        return false, nil
    end

    tbl2.editableMesh = editableMesh

    return true, (getMeshSize(tbl2))
end

local function validateWrapTargetComparison(scale: vector, arg1, tbl1: {assetTypeEnum: any, bypassFlags: {skipPhysicsDataReset: boolean}, editableMeshes: {[any]: any}, isServer: boolean}, arg2)
    local var1, _, var2 = getMeshInfo(arg1, Constants.MESH_CONTENT_TYPE.RENDER_MESH, tbl1)
    if not var1 then
        arg2:fail(ErrorSourceStrings.Keys.BodyMesh_LoadFailed, { meshName = arg1:GetFullName() }, arg1)
        return
    end

    local wrapTarget = arg1:FindFirstChildWhichIsA("WrapTarget")
    if not wrapTarget then
        return
    end

    local var3, _, var4 = getMeshInfo(wrapTarget, Constants.MESH_CONTENT_TYPE.OUTER_CAGE, tbl1)
    if not var3 then
        arg2:fail(ErrorSourceStrings.Keys.BodyMesh_LoadFailed, { meshName = wrapTarget:GetFullName() }, arg1)
        return
    end

    var2.scale = scale
    var4.scale = scale

    local renderVsWrapMeshMaxDiff = Constants.RenderVsWrapMeshMaxDiff

    local var5, _, var6, var7 = getMeshMinMax(var2, tbl1)
    if not var5 then
        arg2:fetchError("Failed to read mesh: " .. var2.fullName)
        return
    end

    local var8, _, var9, var10 = getMeshMinMax(var4, tbl1)
    if not var8 then
        arg2:fetchError("Failed to read mesh: " .. var4.fullName)
        return
    end

    if not (renderVsWrapMeshMaxDiff < (var6 - var9).Magnitude) and not (renderVsWrapMeshMaxDiff < (var7 - var10).Magnitude) then
        return
    end

    local meshContext = var2.fullName .. "." .. var2.fieldName
    local otherMeshContext = var4.fullName .. "." .. var4.fieldName
    arg2:fail(ErrorSourceStrings.Keys.BodyMesh_SizeMismatch, {
        meshContext = meshContext,
        maxDiff = string.format("%.2f", renderVsWrapMeshMaxDiff),
        otherMeshContext = otherMeshContext
    }, arg1)
end

function module.run(arg1, arg2)
    local rootInstance = arg2.rootInstance
    local assetType = arg2.uploadEnum.assetType
    local isServer = arg2.consumerConfig.validationEnv == ValidationEnums.ValidationEnv.Backend

    local editableMeshes = ({})
    if arg2.renderMeshesData then
        local descendants = rootInstance:GetDescendants()
        table.insert(descendants, rootInstance)
        for _, descendant in descendants do
            local var1 = arg2.renderMeshesData[descendant.Name]
            if not (var1 and var1.editable) then
                continue
            end

            local tbl2 = {
                MeshId = {
                    instance = var1.editable,
                    created = var1.createdInValidation
                }
            }
            editableMeshes[descendant] = tbl2
        end
    end

    if arg2.outerCagesData then
        local descendants = rootInstance:GetDescendants()
        table.insert(descendants, rootInstance)
        for _, descendant in descendants do
            if not (descendant:IsA("BaseWrap") and descendant.Parent) then
                continue
            end

            local var1 = arg2.outerCagesData[descendant.Parent.Name]
            if not (var1 and var1.editable) then
                continue
            end

            local tbl2 = {
                CageMeshId = {
                    instance = var1.editable,
                    created = var1.createdInValidation
                }
            }
            editableMeshes[descendant] = tbl2
        end
    end

    local tbl2 = {
        assetTypeEnum = assetType,
        isServer = isServer,
        editableMeshes = editableMeshes,
        bypassFlags = { skipPhysicsDataReset = true }
    }

    local function validateSingleMeshPart(arg3)
        local bool2, var1 = calculateMeshSizeForPart(arg3, tbl2)
        if not (bool2 and var1) then
            arg1:fail(ErrorSourceStrings.Keys.BodyMesh_LoadFailed, { meshName = arg3:GetFullName() }, arg3)

            return
        end

        local var2 = getExpectedPartSize(arg3, tbl2) / var1

        validateWrapTargetComparison(var2, arg3, tbl2, arg1)
    end

    local var1 = Constants.ASSET_TYPE_INFO[assetType]
    if Enum.AssetType.DynamicHead == assetType then
        validateSingleMeshPart(rootInstance)
        return
    end
    if not var1 then
        return
    end

    for k in pairs(var1.subParts) do
        local var2 = rootInstance:FindFirstChild(k)
        if var2 then
            validateSingleMeshPart(var2)
        end
    end
end

return module
