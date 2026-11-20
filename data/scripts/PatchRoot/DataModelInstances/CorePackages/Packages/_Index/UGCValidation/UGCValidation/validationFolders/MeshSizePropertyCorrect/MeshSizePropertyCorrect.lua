-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:10:36Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent

local Constants = require(scriptParentParentParent.Constants)
local _Types = require(scriptParentParentParent.util.Types)
local ValidationEnums = require(scriptParentParentParent.validationSystem.ValidationEnums)
local ErrorSourceStrings = require(scriptParentParentParent.validationSystem.ErrorSourceStrings)
local floatEquals = require(scriptParentParentParent.util.floatEquals)
local getMeshSize = require(scriptParentParentParent.util.getMeshSize)
local getEditableMeshFromContext = require(scriptParentParentParent.util.getEditableMeshFromContext)

local module = {
    categories = { ValidationEnums.UploadCategory.TORSO_AND_LIMBS, ValidationEnums.UploadCategory.DYNAMIC_HEAD },
    requiredData = { ValidationEnums.SharedDataMember.rootInstance, ValidationEnums.SharedDataMember.uploadEnum, ValidationEnums.SharedDataMember.consumerConfig },
    conditionalData = { ValidationEnums.SharedDataMember.renderMeshesData },
    expectedFailures = {}
}
local function vector3Equals(meshSize: vector, vec1: vector) -- Luacid: Inlined by compiler; 1 call site recovered
    return floatEquals(meshSize.X, vec1.X, 0.00001)
        and floatEquals(meshSize.Y, vec1.Y, 0.00001)
        and floatEquals(meshSize.Z, vec1.Z, 0.00001)
end

local function validateSingleMeshPart(arg1, tbl1: {assetTypeEnum: any, editableMeshes: {[any]: any}, isServer: boolean}, arg2)
    local tbl2 = {
        fullName = arg1:GetFullName(),
        fieldName = "MeshId",
        contentId = arg1.MeshId,
        context = arg1.Name
    }

    local var1, editableMesh = getEditableMeshFromContext(arg1, "MeshId", tbl1)
    if not var1 then
        arg2:fail(ErrorSourceStrings.Keys.MeshSize_LoadFailed, { meshName = arg1.Name }, arg1)
        return
    end

    tbl2.editableMesh = editableMesh

    local meshSize = getMeshSize(tbl2)

    if not vector3Equals(arg1.MeshSize, meshSize) then
        arg2:fail(ErrorSourceStrings.Keys.MeshSize_Mismatch, { meshName = arg1.Name }, arg1)
    end
end

function module.run(arg1, arg2)
    local rootInstance = arg2.rootInstance
    local assetType = arg2.uploadEnum.assetType

    local isServer = arg2.consumerConfig.validationEnv == ValidationEnums.ValidationEnv.Backend

    if arg2.consumerConfig.consumerEnv == ValidationEnums.ConsumerEnv.IEC then
        return
    end

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
                    created = false
                }
            }
            editableMeshes[descendant] = tbl2
        end
    end

    local tbl2 = { assetTypeEnum = assetType, isServer = isServer, editableMeshes = editableMeshes }

    if Enum.AssetType.DynamicHead == assetType then
        validateSingleMeshPart(rootInstance, tbl2, arg1)
        return
    end
    local var1 = Constants.ASSET_TYPE_INFO[assetType]
    if not var1 then
        return
    end
    for k in pairs(var1.subParts) do
        local var2 = rootInstance:FindFirstChild(k)
        if var2 then
            validateSingleMeshPart(var2, tbl2, arg1)
        end
    end
end

return module
