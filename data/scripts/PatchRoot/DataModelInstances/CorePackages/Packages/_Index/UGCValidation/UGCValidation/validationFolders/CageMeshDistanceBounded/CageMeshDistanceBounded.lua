-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T17:50:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UGCValidationService = game:GetService("UGCValidationService")

local scriptParentParentParent = script.Parent.Parent.Parent

local _Types = require(scriptParentParentParent.util.Types)
local ValidationEnums = require(scriptParentParentParent.validationSystem.ValidationEnums)
local ErrorSourceStrings = require(scriptParentParentParent.validationSystem.ErrorSourceStrings)

local getFIntUGCValidateCageMeshDistanceThreshold = require(scriptParentParentParent.flags.getFIntUGCValidateCageMeshDistanceThreshold)
local getFFlagUGCValidationEyebrowEyelashSupport = require(scriptParentParentParent.flags.getFFlagUGCValidationEyebrowEyelashSupport)

local module = {
    categories = { ValidationEnums.UploadCategory.LAYERED_CLOTHING },
    requiredData = { ValidationEnums.SharedDataMember.renderMeshesData, ValidationEnums.SharedDataMember.innerCagesData, ValidationEnums.SharedDataMember.outerCagesData },
    expectedFailures = {}
}
function module.run(arg1, arg2)
    if getFFlagUGCValidationEyebrowEyelashSupport() then
        local assetType = arg2.uploadEnum.assetType
        if assetType == Enum.AssetType.EyebrowAccessory or assetType == Enum.AssetType.EyelashAccessory then
            return
        end
    end

    local handle = arg2.renderMeshesData.Handle
    if handle == nil then
        return
    end

    local handle2 = arg2.innerCagesData.Handle
    local handle3 = arg2.outerCagesData.Handle
    if handle2 == nil or handle3 == nil then
        return
    end

    local num1 = UGCValidationService:CalculateAverageEditableCageMeshDistance(
        handle2.editable,
        handle3.editable,
        handle.editable,
        handle2.origin,
        handle3.origin
    )

    if not (getFIntUGCValidateCageMeshDistanceThreshold() < num1 * 100) and not (num1 < 0) then
        return
    end

    if num1 < 0 then
        arg1:fail(ErrorSourceStrings.Keys.CageMeshDistanceBounded_MeshOutsideCage, {})
        return
    end
    arg1:fail(ErrorSourceStrings.Keys.CageMeshDistanceBounded_DistanceTooHigh, { distance = string.format("%.2f", num1) })
end

return module
