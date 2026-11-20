-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T17:50:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent

local _Types = require(scriptParentParentParent.util.Types)
local ValidationEnums = require(scriptParentParentParent.validationSystem.ValidationEnums)
local ErrorSourceStrings = require(scriptParentParentParent.validationSystem.ErrorSourceStrings)

local bodyAssetMasksRenderer = require(scriptParentParentParent.util.bodyAssetMasksRenderer)
local AccurateBoundingBoxRasterUtil = require(scriptParentParentParent.util.AccurateBoundingBoxRasterUtil)

local module = {
    categories = { ValidationEnums.UploadCategory.TORSO_AND_LIMBS, ValidationEnums.UploadCategory.DYNAMIC_HEAD },
    requiredData = { ValidationEnums.SharedDataMember.rootInstance, ValidationEnums.SharedDataMember.renderMeshesData },
    expectedFailures = {}
}
local function getAssetTypeFromUploadEnum(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    return if arg1.uploadEnum and arg1.uploadEnum.assetType then arg1.uploadEnum.assetType else nil
end

local function buildEditableMeshesFromSharedData(arg1)
    local editableMeshesFromSharedData = ({})
    for value, value2 in arg1.renderMeshesData do
        local var1 = arg1.rootInstance:FindFirstChild(value, true)
        if not var1 and arg1.rootInstance.Name == value then
            var1 = arg1.rootInstance
        end

        if not (var1 and value2.editable) then
            continue
        end

        local tbl1 = {
            MeshId = {
                instance = value2.editable,
                created = false
            }
        }
        editableMeshesFromSharedData[var1] = tbl1
    end

    return editableMeshesFromSharedData
end

function module.run(arg1, arg2)
    local assetTypeEnum = getAssetTypeFromUploadEnum(arg2)

    if not assetTypeEnum then
        return
    end

    local rootInstance = arg2.rootInstance
    local editableMeshes = buildEditableMeshesFromSharedData(arg2)

    local tbl1 = {
        assetTypeEnum = assetTypeEnum,
        isServer = arg2.consumerConfig.validationEnv == ValidationEnums.ValidationEnv.Backend,
        editableMeshes = editableMeshes,
        shouldYield = false
    }

    local boundsViewsForAssetType = AccurateBoundingBoxRasterUtil.getBoundsViewsForAssetType(assetTypeEnum)
    local bodyAssetMasksRenderer2, var1 = bodyAssetMasksRenderer.new(rootInstance, boundsViewsForAssetType, tbl1)
    if not bodyAssetMasksRenderer2 then
        if var1 then
            for _, reason in var1 do
                arg1:fail(ErrorSourceStrings.Keys.BoundingBox_ValidationFailed, { reason = reason })
            end
        end

        return
    end

    local var2, var3 = AccurateBoundingBoxRasterUtil.validate(rootInstance, var1, tbl1)

    if var2 or not var3 then
        return
    end

    for _, reason in var3 do
        arg1:fail(ErrorSourceStrings.Keys.BoundingBox_ValidationFailed, { reason = reason })
    end
end

return module
