-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:01:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent

local Constants = require(scriptParentParentParent.Constants)
local _Types = require(scriptParentParentParent.util.Types)
local ValidationEnums = require(scriptParentParentParent.validationSystem.ValidationEnums)
local ErrorSourceStrings = require(scriptParentParentParent.validationSystem.ErrorSourceStrings)
local BoundsCalculator = require(scriptParentParentParent.util.BoundsCalculator)
local R15plusUtils = require(scriptParentParentParent.util.R15plusUtils)
local getAttachmentCFrameInPartSpace = require(scriptParentParentParent.util.getAttachmentCFrameInPartSpace)

local getFFlagUGCValidateHeadAboveTorso = require(scriptParentParentParent.flags.getFFlagUGCValidateHeadAboveTorso)

local SharedDataMember = ValidationEnums.SharedDataMember

local module = {
    categories = { ValidationEnums.UploadCategory.TORSO_AND_LIMBS }
}

if getFFlagUGCValidateHeadAboveTorso() then
    table.insert(module.categories, ValidationEnums.UploadCategory.FULL_BODY)
end
module.requiredData = { ValidationEnums.SharedDataMember.rootInstance, ValidationEnums.SharedDataMember.uploadEnum }

module.conditionalData = { SharedDataMember.renderMeshesData }

if getFFlagUGCValidateHeadAboveTorso() then
    table.insert(module.conditionalData, SharedDataMember.fullBodyPartsMetrics)
end
module.expectedFailures = {}

local tbl1 = {
    [Enum.AssetType.Torso] = true,
    [Enum.AssetType.LeftArm] = true,
    [Enum.AssetType.RightArm] = true,
    [Enum.AssetType.RightLeg] = true,
    [Enum.AssetType.LeftLeg] = true
}

local tbl2 = { UpperTorso = true }

local tbl3 = {
    [Enum.AssetType.LeftLeg] = true,
    [Enum.AssetType.RightLeg] = true
}

local function validateBasedOnBBoxes(arg1, arg2, tbl4, attachmentName: string, arg3): boolean
    local boundsData = tbl4[arg1.Name].boundsData
    local boundsData2 = tbl4[arg2.Name].boundsData
    local bool1

    if boundsData2.maxOverall and boundsData.maxOverall and boundsData2.maxOverall.Y > boundsData.maxOverall.Y then
        arg3:fail(
            ErrorSourceStrings.Keys.Extents_PartAboveParent,
            {
                lowerPart = arg2.Name,
                upperPart = arg1.Name,
                attachmentName = attachmentName
            },
            arg2
        )
        bool1 = false
    else
        bool1 = true
    end

    if boundsData.minOverall and boundsData2.minOverall and boundsData.minOverall.Y < boundsData2.minOverall.Y then
        arg3:fail(
            ErrorSourceStrings.Keys.Extents_ParentBelowPart,
            {
                upperPart = arg1.Name,
                lowerPart = arg2.Name,
                attachmentName = attachmentName
            },
            arg1
        )
        bool1 = false
    end

    return bool1
end

local function validateBasedOnAttachmentYPos(arg1, arg2, attachmentName: string, arg3)
    local var1 = arg2:FindFirstChild(attachmentName, R15plusUtils.checkFlagEnabledForAllowHrd())
    local var2 = arg1:FindFirstChild(attachmentName, R15plusUtils.checkFlagEnabledForAllowHrd())
    if not (var1 and var2) then
        return
    end

    local size = arg2.Size
    local size2 = arg1.Size

    local attachmentCFrameInPartSpacePosition = getAttachmentCFrameInPartSpace(var1).Position
    local attachmentCFrameInPartSpacePosition2 = getAttachmentCFrameInPartSpace(var2).Position

    local y = (size / 2 - attachmentCFrameInPartSpacePosition).Y
    local y2 = (size / 2 + attachmentCFrameInPartSpacePosition).Y
    local y3 = (size2 / 2 - attachmentCFrameInPartSpacePosition2).Y
    local y4 = (size2 / 2 + attachmentCFrameInPartSpacePosition2).Y

    if y3 < y then
        arg3:fail(
            ErrorSourceStrings.Keys.Extents_PartAboveParent,
            {
                lowerPart = arg2.Name,
                upperPart = arg1.Name,
                attachmentName = attachmentName
            },
            arg2
        )
    end

    if not (y2 < y4) then
        return
    end

    arg3:fail(
        ErrorSourceStrings.Keys.Extents_ParentBelowPart,
        {
            upperPart = arg1.Name,
            lowerPart = arg2.Name,
            attachmentName = attachmentName
        },
        arg1
    )
end

local function validateHeadAboveTorso(arg1, arg2)
    local fullBodyPartsMetrics = arg2.fullBodyPartsMetrics
    if not (fullBodyPartsMetrics and next(fullBodyPartsMetrics)) then
        return
    end

    local fullBodyPartsMetric = fullBodyPartsMetrics[Constants.NAMED_R15_BODY_PARTS.Head]
    local fullBodyPartsMetric2 = fullBodyPartsMetrics[Constants.NAMED_R15_BODY_PARTS.UpperTorso]
    if not (fullBodyPartsMetric and fullBodyPartsMetric2) then
        return
    end

    local boundsData = fullBodyPartsMetric.boundsData
    local boundsData2 = fullBodyPartsMetric2.boundsData

    if not (boundsData.maxOverall and boundsData.minOverall and boundsData2.maxOverall and boundsData2.minOverall) then
        return
    end

    local var1 = arg2.rootInstance:FindFirstChild(Constants.NAMED_R15_BODY_PARTS.Head)

    if boundsData.minOverall.Y < boundsData2.minOverall.Y then
        arg1:fail(
            ErrorSourceStrings.Keys.Extents_ParentBelowPart,
            { upperPart = "Head", lowerPart = "UpperTorso", attachmentName = "NeckRigAttachment" },
            var1
        )
    end

    local var2 = (boundsData.maxOverall.Y + boundsData.minOverall.Y) / 2
    local var3 = (boundsData.maxOverall.Z + boundsData.minOverall.Z) / 2
    local bool1 = boundsData2.maxOverall.Y < var2
    local bool2 = var3 < boundsData2.minOverall.Z
    if not (bool1 or bool2) then
        arg1:fail(ErrorSourceStrings.Keys.Extents_HeadBelowTorso, {}, var1)
    end
end

function module.run(arg1, arg2)
    if arg2.uploadCategory == ValidationEnums.UploadCategory.FULL_BODY then
        if getFFlagUGCValidateHeadAboveTorso() then
            validateHeadAboveTorso(arg1, arg2)
        end
        return
    end

    local rootInstance = arg2.rootInstance
    local assetType = arg2.uploadEnum.assetType

    if not tbl1[assetType] then
        return
    end

    local var1 = Constants.ASSET_TYPE_INFO[assetType]
    if not var1 then
        return
    end

    local renderMeshesData = arg2.renderMeshesData
    if not renderMeshesData then
        return
    end

    local var2, _, var3 = BoundsCalculator.calculateIndividualAssetPartsDataFromData(rootInstance, assetType, renderMeshesData)
    if not var2 then
        arg1:fetchError("Failed to calculate asset bounds data for extents check on " .. assetType.Name)
        return
    end

    for k, subPart in pairs(var1.subParts) do
        local var4 = Constants.BODYPART_TO_PARENT[k]
        if var4 == nil then
            continue
        end

        local var5 = rootInstance:FindFirstChild(k)
        local var6 = rootInstance:FindFirstChild(var4)
        if not (var5 and var6) then
            continue
        end

        if not tbl2[k] then
            local var7 = var6
            var6 = var5
            var5 = var7
        end

        local name = subPart.rigAttachmentToParent.name

        if (not (var3[var5.Name] and var3[var6.Name]) or validateBasedOnBBoxes(var5, var6, var3, name, arg1)) and tbl3[assetType] then
            validateBasedOnAttachmentYPos(var5, var6, name, arg1)
        end
    end
end

return module
