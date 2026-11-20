-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:01:37Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent

local Constants = require(scriptParentParentParent.Constants)
local _Types = require(scriptParentParentParent.util.Types)
local ValidationEnums = require(scriptParentParentParent.validationSystem.ValidationEnums)
local ErrorSourceStrings = require(scriptParentParentParent.validationSystem.ErrorSourceStrings)

local BoundsDataUtils = require(scriptParentParentParent.util.BoundsDataUtils)
local BoundsCalculator = require(scriptParentParentParent.util.BoundsCalculator)

local getFFlagUGCValidateHeadAboveTorso = require(scriptParentParentParent.flags.getFFlagUGCValidateHeadAboveTorso)
local GetFStringUGCValidateLegHipAttachmentRange = require(scriptParentParentParent.flags.GetFStringUGCValidateLegHipAttachmentRange)

local GetFStringUGCValidateAllowedLegOverlapMultiplier = require(scriptParentParentParent.flags.GetFStringUGCValidateAllowedLegOverlapMultiplier)

local module = {
    categories = { ValidationEnums.UploadCategory.TORSO_AND_LIMBS, ValidationEnums.UploadCategory.FULL_BODY },
    requiredData = { ValidationEnums.SharedDataMember.rootInstance, ValidationEnums.SharedDataMember.renderMeshesData }
}

if getFFlagUGCValidateHeadAboveTorso() then
    module.conditionalData = { ValidationEnums.SharedDataMember.fullBodyPartsMetrics }
end

module.expectedFailures = {}

local function validateAttachmentPosition(arg1, rootInstance, assetType)
    if assetType == Enum.AssetType.RightLeg then
        local var1 = rootInstance.RightUpperLeg.Size.X * GetFStringUGCValidateLegHipAttachmentRange.asNumber()
        if var1 < rootInstance.RightUpperLeg.RightHipRigAttachment.CFrame.Position.X then
            arg1:fail(ErrorSourceStrings.Keys.LegsSeparated_HipAttachmentOutOfRange, {
                attachmentPath = "RightUpperLeg.RightHipRigAttachment.CFrame.Position.X",
                currentValue = string.format("%.2f", rootInstance.RightUpperLeg.RightHipRigAttachment.CFrame.Position.X),
                comparison = "greater than",
                cutoff = string.format("%.2f", var1)
            })
        end
    elseif assetType == Enum.AssetType.LeftLeg then
        local var1 = -rootInstance.LeftUpperLeg.Size.X * GetFStringUGCValidateLegHipAttachmentRange.asNumber()
        if rootInstance.LeftUpperLeg.LeftHipRigAttachment.CFrame.Position.X < var1 then
            arg1:fail(ErrorSourceStrings.Keys.LegsSeparated_HipAttachmentOutOfRange, {
                attachmentPath = "LeftUpperLeg.LeftHipRigAttachment.CFrame.Position.X",
                currentValue = string.format("%.2f", rootInstance.LeftUpperLeg.LeftHipRigAttachment.CFrame.Position.X),
                comparison = "less than",
                cutoff = string.format("%.2f", var1)
            })
        end
    end
end

local function calculateBounds(tbl1, tbl2)
    local bounds = {}
    for _, value in tbl2 do
        bounds = BoundsDataUtils.combineBounds(bounds, tbl1[value].boundsData)
    end
    return bounds
end

local function buildEditableMeshesFromSharedData(arg1)
    local editableMeshesFromSharedData = ({})
    for value, value2 in arg1.renderMeshesData do
        local var1 = arg1.rootInstance:FindFirstChild(value, true)
        if not (var1 and value2.editable) then
            continue
        end

        editableMeshesFromSharedData[var1] = {
            MeshId = {
                instance = value2.editable,
                created = false
            }
        }
    end

    return editableMeshesFromSharedData
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

local function checkLegOverlap(arg1, tbl1)
    local bounds = calculateBounds(tbl1, { Constants.NAMED_R15_BODY_PARTS.LeftUpperLeg, Constants.NAMED_R15_BODY_PARTS.LeftLowerLeg, Constants.NAMED_R15_BODY_PARTS.LeftFoot })

    local boundsCenters = BoundsDataUtils.calculateBoundsCenters(bounds)
    local boundsDimensions = BoundsDataUtils.calculateBoundsDimensions(bounds)

    local bounds2 = calculateBounds(tbl1, { Constants.NAMED_R15_BODY_PARTS.RightUpperLeg, Constants.NAMED_R15_BODY_PARTS.RightLowerLeg, Constants.NAMED_R15_BODY_PARTS.RightFoot })

    local boundsCenters2 = BoundsDataUtils.calculateBoundsCenters(bounds2)
    local boundsDimensions2 = BoundsDataUtils.calculateBoundsDimensions(bounds2)

    if not (boundsCenters and boundsDimensions and boundsCenters2 and boundsDimensions2) then
        return
    end

    local var1 = boundsCenters2.X - boundsCenters.X
    local var2 = (boundsDimensions.X + boundsDimensions2.X) * 0.5 - var1
    if var2 <= 0 then
        return
    end
    local var3 = boundsDimensions.X * GetFStringUGCValidateAllowedLegOverlapMultiplier.asNumber()
    local var4 = boundsDimensions2.X * GetFStringUGCValidateAllowedLegOverlapMultiplier.asNumber()
    if not (var3 < var2) and not (var4 < var2) then
        return
    end

    arg1:fail(
        ErrorSourceStrings.Keys.LegsSeparated_LegsOverlap,
        {
            overlap = string.format("%.2f", var2),
            leftMax = string.format("%.2f", var3),
            rightMax = string.format("%.2f", var4)
        }
    )
end

local function validateFullBodySeparation(arg1, arg2)
    if getFFlagUGCValidateHeadAboveTorso() then
        local fullBodyPartsMetrics = arg2.fullBodyPartsMetrics
        if not (fullBodyPartsMetrics and next(fullBodyPartsMetrics)) then
            return
        end
        checkLegOverlap(arg1, fullBodyPartsMetrics)
        return
    end
    local allBodyPartsFromRootInstance = createAllBodyPartsFromRootInstance(arg2.rootInstance)
    local editableMeshes = buildEditableMeshesFromSharedData(arg2)
    local tbl1 = {
        isServer = arg2.consumerConfig.consumerEnv == ValidationEnums.ConsumerEnv.Backend,
        editableMeshes = editableMeshes
    }

    local var1, var2, var3 = BoundsCalculator.calculateIndividualFullBodyPartsData(allBodyPartsFromRootInstance, tbl1, nil, false)
    if not var1 then
        arg1:fail(
            ErrorSourceStrings.Keys.LegsSeparated_BoundsCalculationFailed,
            {
                details = if var2 then table.concat(var2, "; ") else "Unknown error"
            }
        )
        return
    end
    checkLegOverlap(arg1, var3)
end

local function getAssetTypeFromUploadEnum(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    return if arg1.uploadEnum and arg1.uploadEnum.assetType then arg1.uploadEnum.assetType else nil
end

function module.run(arg1, arg2)
    if arg2.uploadCategory == ValidationEnums.UploadCategory.FULL_BODY then
        validateFullBodySeparation(arg1, arg2)
        return
    end

    local assetTypeFromUploadEnum = getAssetTypeFromUploadEnum(arg2)

    if assetTypeFromUploadEnum
        and (assetTypeFromUploadEnum == Enum.AssetType.RightLeg or assetTypeFromUploadEnum == Enum.AssetType.LeftLeg)
    then
        validateAttachmentPosition(arg1, arg2.rootInstance, assetTypeFromUploadEnum)
    end
end
return module
