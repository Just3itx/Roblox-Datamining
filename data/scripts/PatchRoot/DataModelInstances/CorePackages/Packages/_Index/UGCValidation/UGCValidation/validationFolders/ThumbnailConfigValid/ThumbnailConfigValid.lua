-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:11:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UGCValidationService = game:GetService("UGCValidationService")

local scriptParentParentParent = script.Parent.Parent.Parent

local _Types = require(scriptParentParentParent.util.Types)
local ValidationEnums = require(scriptParentParentParent.validationSystem.ValidationEnums)
local ErrorSourceStrings = require(scriptParentParentParent.validationSystem.ErrorSourceStrings)

local bool1 = game:DefineFastFlag("UGCValidationAddThumbnailFrustumCheckingv2", false)

local module = {
    categories = { ValidationEnums.UploadCategory.LAYERED_CLOTHING, ValidationEnums.UploadCategory.EYEBROW_EYELASH, ValidationEnums.UploadCategory.RIGID_ACCESSORY },
    requiredData = { ValidationEnums.SharedDataMember.rootInstance, ValidationEnums.SharedDataMember.renderMeshesData, ValidationEnums.SharedDataMember.uploadEnum },
    expectedFailures = {}
}
function module.run(arg1, arg2)
    local rootInstance = arg2.rootInstance

    local assetType = arg2.uploadEnum and arg2.uploadEnum.assetType
    if assetType == Enum.AssetType.EyebrowAccessory or assetType == Enum.AssetType.EyelashAccessory then
        return
    end

    local thumbnailConfiguration = rootInstance:FindFirstChild("ThumbnailConfiguration")
    if not thumbnailConfiguration then
        return
    end

    local handle = rootInstance:FindFirstChild("Handle")
    if not (handle and handle:IsA("BasePart")) then
        return
    end

    local thumbnailCameraTarget = thumbnailConfiguration:FindFirstChild("ThumbnailCameraTarget")
    if not thumbnailCameraTarget then
        return
    end

    if thumbnailCameraTarget.Value ~= handle then
        arg1:fail(ErrorSourceStrings.Keys.ThumbnailInvalidTarget, { ExpectedTarget = handle:GetFullName() })
        return
    end

    if not game:GetEngineFeature("EngineUGCValidateThumbnailerMeshInFrustum") or not bool1 then
        return
    end
    local renderMeshesData = arg2.renderMeshesData
    if not renderMeshesData then
        return
    end

    local var1 = renderMeshesData[handle.Name]
    if not var1 then
        return
    end

    local thumbnailCameraTargetValueCFrame = thumbnailCameraTarget.Value.CFrame
    local thumbnailCameraValue = thumbnailConfiguration:FindFirstChild("ThumbnailCameraValue")
    if not thumbnailCameraValue then
        return
    end

    local var2 = thumbnailCameraTargetValueCFrame * thumbnailCameraValue.Value
    local scale = var1.scale

    if UGCValidationService:CheckEditableMeshInCameraFrustum(var1.editable, scale, thumbnailCameraTargetValueCFrame, var2) == false then
        arg1:fail(ErrorSourceStrings.Keys.ThumbnailOutsideView, { InstancePath = handle:GetFullName() })
    end
end

return module
