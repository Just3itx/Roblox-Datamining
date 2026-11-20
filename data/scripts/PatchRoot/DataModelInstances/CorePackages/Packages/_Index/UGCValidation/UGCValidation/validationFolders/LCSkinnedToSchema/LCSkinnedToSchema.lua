-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:01:33Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UGCValidationService = game:GetService("UGCValidationService")
local scriptParentParentParent = script.Parent.Parent.Parent
local Constants = require(scriptParentParentParent.Constants)
local _Types = require(scriptParentParentParent.util.Types)
local ValidationEnums = require(scriptParentParentParent.validationSystem.ValidationEnums)
local ErrorSourceStrings = require(scriptParentParentParent.validationSystem.ErrorSourceStrings)
local module = {
    fflag = require(scriptParentParentParent.flags.getEngineFeatureEngineUGCValidationConsolidateAccessorySkinning),
    categories = { ValidationEnums.UploadCategory.LAYERED_CLOTHING, ValidationEnums.UploadCategory.EYEBROW_EYELASH },
    requiredData = { ValidationEnums.SharedDataMember.renderMeshesData }
}
function module.run(arg1, arg2)
    local handle = arg2.rootInstance:FindFirstChild("Handle")
    local handle2 = arg2.renderMeshesData.Handle

    if handle == nil or handle2 == nil then
        error("Schema should have ensured data exists for handle")
    end

    local tbl1 = {}
    for _, value in handle2.editable:GetBones() do
        table.insert(tbl1, handle2.editable:GetBoneName(value))
    end

    local tbl2 = { UGCValidationService:GetSkinnedJointNamesFromEditableMesh(handle2.editable) }

    local editableMeshSkinningTransferJointsInfo = UGCValidationService:GetEditableMeshSkinningTransferJointsInfo(handle2.editable)

    local wrapLayer = handle:FindFirstChildOfClass("WrapLayer")
    assert(wrapLayer, "WrapLayer not found on handle")
    local bool1 = wrapLayer.AutoSkin == Enum.WrapLayerAutoSkin.EnabledOverride

    arg1:setReportingInstance(handle)

    for _, jointName in tbl1 do
        if Constants.ALLOWED_SKINNING_TRANSFER_JOINT_NAMES[jointName] then
            if not bool1 then
                arg1:fail(ErrorSourceStrings.Keys.AccessorySkinning_TransferJointWithoutAutoSkin, { jointName = jointName })
            end
        elseif not Constants.R15_STANDARD_JOINT_NAMES[jointName] then
            arg1:fail(ErrorSourceStrings.Keys.AccessorySkinning_ExtraJoint, { jointName = jointName })
        end
    end

    for _, value in editableMeshSkinningTransferJointsInfo do
        if not value then
            arg1:fail(ErrorSourceStrings.Keys.AccessorySkinning_WeightNotFull)
            break
        end
    end

    if not Constants.SkinningTransferRequiredTypes[arg2.uploadEnum.assetType] then
        return
    end
    if not bool1 then
        arg1:fail(
            ErrorSourceStrings.Keys.AccessorySkinning_RequiredSkinningTransfer,
            {
                assetType = arg2.uploadEnum.assetType.Name
            }
        )
    end
    for requiredJointName, _ in Constants.ALLOWED_SKINNING_TRANSFER_JOINT_NAMES do
        if table.find(tbl2, requiredJointName) ~= nil then
            continue
        end

        local accessorySkinningMissingTransferJoint = ErrorSourceStrings.Keys.AccessorySkinning_MissingTransferJoint
        local tbl3 = {
            assetType = arg2.uploadEnum.assetType.Name,
            requiredJointName = requiredJointName
        }
        arg1:fail(accessorySkinningMissingTransferJoint, tbl3)
    end

    for _, jointName in tbl2 do
        if not Constants.R15_STANDARD_JOINT_NAMES[jointName] then
            continue
        end

        local tbl3 = {}
        for value2, _ in Constants.ALLOWED_SKINNING_TRANSFER_JOINT_NAMES do
            table.insert(tbl3, value2)
        end
        local accessorySkinningNotLeaderOrFollower = ErrorSourceStrings.Keys.AccessorySkinning_NotLeaderOrFollower
        local tbl4 = {
            jointName = jointName,
            validJointNameList = table.concat(tbl3, ", ")
        }
        arg1:fail(accessorySkinningNotLeaderOrFollower, tbl4)
    end
end

return module
