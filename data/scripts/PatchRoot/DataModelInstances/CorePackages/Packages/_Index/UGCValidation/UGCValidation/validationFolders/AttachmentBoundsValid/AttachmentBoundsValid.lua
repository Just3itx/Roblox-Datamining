-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T17:50:42Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent

local _Types = require(scriptParentParentParent.util.Types)
local Constants = require(scriptParentParentParent.Constants)
local ValidationEnums = require(scriptParentParentParent.validationSystem.ValidationEnums)
local ErrorSourceStrings = require(scriptParentParentParent.validationSystem.ErrorSourceStrings)
local BoundsCalculator = require(scriptParentParentParent.util.BoundsCalculator)
local BoundsDataUtils = require(scriptParentParentParent.util.BoundsDataUtils)
local MeshSpaceUtils = require(scriptParentParentParent.util.MeshSpaceUtils)
local prettyPrintVector3 = require(scriptParentParentParent.util.prettyPrintVector3)
local R15plusUtils = require(scriptParentParentParent.util.R15plusUtils)
local getAttachmentCFrameInPartSpace = require(scriptParentParentParent.util.getAttachmentCFrameInPartSpace)

local getFStringUGCValidationAttachmentErrorLink = require(scriptParentParentParent.flags.getFStringUGCValidationAttachmentErrorLink)

local module = {
    categories = { ValidationEnums.UploadCategory.TORSO_AND_LIMBS, ValidationEnums.UploadCategory.DYNAMIC_HEAD },
    requiredData = { ValidationEnums.SharedDataMember.rootInstance, ValidationEnums.SharedDataMember.uploadEnum, ValidationEnums.SharedDataMember.consumerConfig },
    conditionalData = { ValidationEnums.SharedDataMember.renderMeshesData },
    expectedFailures = {}
}
local function validateInMeshSpace(arg1, arg2, bounds, arg3, arg4, bool1: boolean)
    local var1 = arg3.cframe * getAttachmentCFrameInPartSpace(arg1)
    local boundsCenters = BoundsDataUtils.calculateBoundsCenters(arg3.boundsData)
    local boundsDimensions = BoundsDataUtils.calculateBoundsDimensions(arg3.boundsData)
    if not (boundsCenters and boundsDimensions) then
        arg4:fail(
            ErrorSourceStrings.Keys.AttachmentBoundsCalculationFailed,
            {
                AttachmentName = arg1.Name,
                PartName = arg2.Name
            }
        )
        return
    end
    local var2 = (var1.Position - boundsCenters) / (boundsDimensions / 2)

    local min = bounds.min
    local max = bounds.max
    for _, value in { "X", "Y", "Z" } do
        if not (var2[value] < min[value] or var2[value] > max[value]) then
            continue
        end

        local var3 = MeshSpaceUtils.clampAttachmentToBounds(arg1, arg3, bounds, 0.001)
        local var4 = if bool1 then ErrorSourceStrings.Keys.RigAttachmentOutOfBounds else ErrorSourceStrings.Keys.AccessoryAttachmentOutOfBounds
        arg4:fail(var4, {
            AttachmentName = arg1.Name,
            PartName = arg2.Name,
            CurrentPosition = prettyPrintVector3(arg1.CFrame.Position, 3),
            ClosestValidPosition = prettyPrintVector3(var3.Position, 3),
            HelpLink = getFStringUGCValidationAttachmentErrorLink()
        })
        return
    end
end

local function checkAll(arg1, arg2, arg3, arg4)
    local var1 = arg1:FindFirstChild(arg2.rigAttachmentToParent.name, R15plusUtils.checkFlagEnabledForAllowHrd())

    if not var1 then
        return
    end

    validateInMeshSpace(var1, arg1, arg2.rigAttachmentToParent.bounds, arg3, arg4, true)

    for k, otherAttachment in pairs(arg2.otherAttachments) do
        local var2 = arg1:FindFirstChild(k, R15plusUtils.checkFlagEnabledForAllowHrd())
        if var2 then
            validateInMeshSpace(var2, arg1, otherAttachment.bounds, arg3, arg4, string.find(k, "RigAttachment$") ~= nil)
        end
    end
end

function module.run(arg1, arg2)
    local rootInstance = arg2.rootInstance
    local assetType = arg2.uploadEnum.assetType

    local var1 = Constants.ASSET_TYPE_INFO[assetType]
    if not var1 then
        return
    end

    local editableMeshes = ({})
    if arg2.renderMeshesData then
        local descendants = rootInstance:GetDescendants()
        table.insert(descendants, rootInstance)
        for _, descendant in descendants do
            local var2 = arg2.renderMeshesData[descendant.Name]
            if not (var2 and var2.editable) then
                continue
            end

            local tbl2 = {
                MeshId = {
                    instance = var2.editable,
                    created = false
                }
            }
            editableMeshes[descendant] = tbl2
        end
    end

    local isServer = arg2.consumerConfig.validationEnv == ValidationEnums.ValidationEnv.Backend

    local var2, _, var3 = BoundsCalculator.calculateIndividualAssetPartsData(
        rootInstance,
        { assetTypeEnum = assetType, isServer = isServer, editableMeshes = editableMeshes }
    )

    if not var2 then
        arg1:fail(ErrorSourceStrings.Keys.AttachmentBoundsAssetCalculationFailed, { InstancePath = rootInstance:GetFullName() })

        return
    end

    if Enum.AssetType.DynamicHead == assetType then
        local var4 = var3[rootInstance.Name]
        if var4 then
            checkAll(rootInstance, var1.subParts.Head, var4, arg1)
        end

        return
    end

    for k, subPart in pairs(var1.subParts) do
        local var4 = rootInstance:FindFirstChild(k)
        if not var4 then
            continue
        end

        local var5 = var3[k]
        if var5 then
            checkAll(var4, subPart, var5, arg1)
        end
    end
end

return module
